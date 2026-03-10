let
    source = #"NFE_Processado_Base",
    LayoutBase = LAYOUT_NFE_BASE,
    CamposBase = LayoutBase[Fields],
    DerivadosBase = Record.FieldOrDefault(LayoutBase, "Derivados", {}),
    TodasColunas = List.Transform(CamposBase, each _[Alias]) & List.Transform(DerivadosBase, each _[Name]),
    Expandir = Table.ExpandRecordColumn(source, "ConteudoBase", TodasColunas, TodasColunas),
    ChaveRef = Table.AddColumn(
        Expandir,
        "Chave_Acesso_Ref",
        each
            let
                chave44 = try Text.Trim(Text.From([Chave_Acesso_44])) otherwise null,
                chave = try Text.Trim(Text.From([Chave de Acesso])) otherwise null
            in
                if chave44 <> null and chave44 <> "" then chave44 else chave,
        type text
    ),
    SemDuplicadas = Table.Distinct(ChaveRef, {"Chave_Acesso_Ref"}),
    ParesTipoCampos = List.Transform(CamposBase, each {_[Alias], fnParseKind(null, _[Kind], "type")}),
    ParesTipoDerivados = List.Transform(DerivadosBase, each {_[Name], fnParseKind(null, _[Kind], "type")}),
    ParesTipoFixos = {{"Chave_Acesso_Ref", type text}},
    RegrasTipo = List.Distinct(List.Combine({ParesTipoFixos, ParesTipoCampos, ParesTipoDerivados})),
    ColunasAtuais = Table.ColumnNames(SemDuplicadas),
    RegrasTipoAtivas = List.Select(RegrasTipo, each List.Contains(ColunasAtuais, _{0})),
    Tipada = Table.TransformColumnTypes(SemDuplicadas, RegrasTipoAtivas, "pt-BR")
in
    Tipada
