(EFD as table, registro as text) as table =>
let
    registroNorm = Text.Upper(Text.Trim(registro)),

    // ===== Layout =====
    row =
        try
            Table.First(
                Table.SelectRows(
                    Layouts_Index,
                    each Text.Upper(Text.Trim([Registro])) = registroNorm
                )
            )
        otherwise
            null,

    layout = if row = null then null else row[Layout],

    Out =
        if layout = null then
            #table(type table [], {})
        else
            let
                cols = Table.ColumnNames(EFD),

            // ===== Filtra REG = C001 =====
                Base0 = Table.SelectRows(EFD, each [C001] = registroNorm),

                // ===== Keys (somente as que existirem) =====
                WantedKeys = {"Nome","Periodo","ArquivoId","LinhaId","Chave_Linha","Chave_Pai"},
                KeepKeys = List.Select(WantedKeys, each List.Contains(cols, _)),

                // ===== Raw C columns (precisamos delas para extrair os campos) =====
                KeepRawC = List.Select(cols, each Text.StartsWith(_, "C")),

                // ===== Layout lists (limpa itens inválidos) =====
                rawFields = try layout[Fields] otherwise {},
                rawDerivs = try layout[Derivados] otherwise {},

                fields =
                    List.Select(
                        rawFields,
                        each
                            _ <> null
                            and Record.HasFields(_, {"Name","Pos","Kind"})
                            and _[Name] <> null
                            and Text.Trim(Text.From(_[Name])) <> ""
                    ),

                derivs =
                    List.Select(
                        rawDerivs,
                        each
                            _ <> null
                            and Record.HasFields(_, {"Name","Kind","Fn"})
                            and _[Name] <> null
                            and Text.Trim(Text.From(_[Name])) <> ""
                            and Value.Is(_[Fn], type function)
                    ),

                FieldNames = List.Transform(fields, each Text.From(_[Name])),
                DerivNames = List.Transform(derivs, each Text.From(_[Name])),

                // ===== Base de trabalho: KEYS + Cxxx (depois removemos Cxxx no final) =====
                Base =
                    Table.SelectColumns(
                        Base0,
                        List.Distinct(List.Combine({KeepKeys, KeepRawC})),
                        MissingField.UseNull
                    ),

                // ===== Materializa Fields (Pos -> C{Pos}) =====
                AddFields =
                    List.Accumulate(
                        fields,
                        Base,
                        (state as table, f as record) =>
                            let
                                nm   = Text.From(f[Name]),
                                pos  = Number.From(f[Pos]),
                                kind = Text.From(f[Kind]),
                                col  = "C" & Text.PadStart(Text.From(pos), 3, "0")
                            in
                                Table.AddColumn(
                                    state,
                                    nm,
                                    each fnParseKind(try Record.Field(_, col) otherwise null, kind),
                                    type any
                                )
                    ),

                // ===== Derivados (record limpo = só Fields) =====
                AddDerivs =
                    List.Accumulate(
                        derivs,
                        AddFields,
                        (state as table, d as record) =>
                            let
                                nm   = Text.From(d[Name]),
                                kind = Text.From(d[Kind]),
                                fn   = d[Fn]
                            in
                                Table.AddColumn(
                                    state,
                                    nm,
                                    each
                                        let
                                            r0 = Record.SelectFields(_, FieldNames, MissingField.UseNull),
                                            v  = try fn(r0)
                                        in
                                            if v[HasError] then null else fnParseKind(v[Value], kind),
                                    type any
                                )
                    ),

                // ===== Tipagem final (colunas do layout + derivadas) =====
                KindToType = (k as any) as type =>
                    let
                        kk = if k = null then "" else Text.Lower(Text.Trim(Text.From(k)))
                    in
                        if kk = "text" then type text
                        else if kk = "date8" then type date
                        else if kk = "int" then Int64.Type
                        else if Text.StartsWith(kk, "num_pt") then type number
                        else type any,

                TypePairs_Fields = List.Transform(fields, each { Text.From(_[Name]), KindToType(_[Kind]) }),
                TypePairs_Derivs = List.Transform(derivs, each { Text.From(_[Name]), KindToType(_[Kind]) }),

                Typed =
                    Table.TransformColumnTypes(
                        AddDerivs,
                        List.Combine({TypePairs_Fields, TypePairs_Derivs}),
                        "pt-BR"
                    ),

                // ===== Seleção final (remove Cxxx e qualquer coisa fora do layout) =====
                FinalCols = List.Distinct(List.Combine({KeepKeys, FieldNames, DerivNames})),
                Final = Table.SelectColumns(Typed, FinalCols, MissingField.UseNull)
            in
                Final
in
    Out

