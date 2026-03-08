let
    Fonte = (path as text) =>
    let
        // ====================================================================
        // 1. LEITURA FÍSICA OTIMIZADA VIA STREAMING (BLINDAGEM I/O)
        // ====================================================================
        Binario = Binary.Buffer(File.Contents(path)), 
        // O Binary.Buffer evita que o Mashup Engine vá ao disco múltiplas vezes pelo mesmo txt
        Tabela = Csv.Document(Binario,[Delimiter="|", Columns=40, Encoding=1252, QuoteStyle=QuoteStyle.None]),

        // ====================================================================
        // 2. EXTRAÇÃO DE METADADOS DO ARQUIVO (0000)
        // ... restante do código inalterado ...
        // ====================================================================
        Row0000 =
        try
            Table.First(
                Table.SelectRows(
                    Tabela,
                    each
                        let r = try Text.Upper(Text.Trim(Text.From([Column2]))) otherwise null
                        in r = "0000"
                )
            )
        otherwise
            null,

        DtIniTxt =
            if Row0000 = null then null
            else try Text.Trim(Text.From(Record.Field(Row0000, "Column5"))) otherwise null,

        DataInicial =
            if DtIniTxt = null or DtIniTxt = "" then null
            else if Text.Length(DtIniTxt) = 8 then fnFinalDate(DtIniTxt)
            else try Date.From(DtIniTxt) otherwise null,

        Periodo = fnPeriodo(DataInicial), 

        // ====================================================================
        // 3. LIMPEZA (FILTRO DE ASSINATURAS E LINHAS INVÁLIDAS)
        // ====================================================================
        SemLixo =
            Table.SelectRows(
                Tabela,
                each
                    let
                        r = try Text.Upper(Text.Trim(Text.From([Column2]))) otherwise null,
                        okLen = r <> null and Text.Length(r) = 4,
                        okChar =
                            okLen and
                            (
                                (Text.Select(r, {"0".."9"}) <> "" and Text.Start(r, 1) >= "0" and Text.Start(r, 1) <= "9")
                                or
                                (Text.Start(r, 1) >= "A" and Text.Start(r, 1) <= "Z")
                            )
                    in
                        okChar
            ),

        AddDataInicial = Table.AddColumn(SemLixo, "DataInicial", each DataInicial, type date),
        AddPeriodo = Table.AddColumn(AddDataInicial, "Periodo", each Periodo, type text),

        // ====================================================================
        // 4. PREPARAÇÃO DA HIERARQUIA
        // ====================================================================
        AddLinhaId = Table.AddIndexColumn(AddPeriodo, "LinhaId", 1, 1, Int64.Type),

        // Busca o nível do registro na tabela Meta
        JoinMeta = Table.NestedJoin(AddLinhaId, {"Column2"}, Meta_Registros, {"Registro"}, "Meta", JoinKind.LeftOuter),
        ExpandMeta = Table.ExpandTableColumn(JoinMeta, "Meta", {"Nivel"}, {"Nivel"}),

        // ⚠️ GARANTIA DE ORDENAÇÃO: Impede que o Join anterior bagunce o FillDown
        SortFisico = Table.Sort(ExpandMeta, {{"LinhaId", Order.Ascending}}),

        // ====================================================================
        // 5. O MOTOR DE HIERARQUIA (SCD TIPO 2 - PARENT/CHILD)
        // ====================================================================
        // Criação das Gavetas apontando para a tabela ordenada (SortFisico)
        L0 = Table.AddColumn(SortFisico, "L0", each if [Nivel] = 0 then [LinhaId] else null, Int64.Type),
        L1 = Table.AddColumn(L0, "L1", each if [Nivel] = 1 then [LinhaId] else null, Int64.Type),
        L2 = Table.AddColumn(L1, "L2", each if [Nivel] = 2 then [LinhaId] else null, Int64.Type),
        L3 = Table.AddColumn(L2, "L3", each if [Nivel] = 3 then [LinhaId] else null, Int64.Type),
        L4 = Table.AddColumn(L3, "L4", each if [Nivel] = 4 then [LinhaId] else null, Int64.Type),
        L5 = Table.AddColumn(L4, "L5", each if [Nivel] = 5 then [LinhaId] else null, Int64.Type),
        L6 = Table.AddColumn(L5, "L6", each if [Nivel] = 6 then [LinhaId] else null, Int64.Type),

        // Preenchimento Global para baixo
        Preenche = Table.FillDown(L6, {"L0", "L1", "L2", "L3", "L4", "L5", "L6"}),

        // Define a Linha_Pai baseada na gaveta do nível imediatamente anterior
        AdcPai = Table.AddColumn(Preenche, "Linha_Pai", each 
            if [Nivel] = null or [Nivel] = 0 then null
            else if [Nivel] = 1 then [L0]
            else if [Nivel] = 2 then [L1]
            else if [Nivel] = 3 then [L2]
            else if [Nivel] = 4 then [L3]
            else if [Nivel] = 5 then [L4]
            else if [Nivel] = 6 then [L5]
            else null, Int64.Type
        ),

        // ====================================================================
        // 6. LIMPEZA E FORMATAÇÃO FINAL
        // ====================================================================
        Limpeza = Table.RemoveColumns(AdcPai, {"Nivel", "L0", "L1", "L2", "L3", "L4", "L5", "L6"}),

        Reordenadas = Table.ReorderColumns(Limpeza,{"LinhaId", "Linha_Pai", "DataInicial", "Periodo", "Column1", "Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8", "Column9", "Column10", "Column11", "Column12", "Column13", "Column14", "Column15", "Column16", "Column17", "Column18", "Column19", "Column20", "Column21", "Column22", "Column23", "Column24", "Column25", "Column26", "Column27", "Column28", "Column29", "Column30", "Column31", "Column32", "Column33", "Column34", "Column35", "Column36", "Column37", "Column38", "Column39", "Column40"})
    in
        Reordenadas
in
    Fonte

