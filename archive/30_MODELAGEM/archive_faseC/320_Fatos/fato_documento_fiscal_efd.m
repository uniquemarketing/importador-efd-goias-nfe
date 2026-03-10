let
    FonteC100 = RC100_base,
    ColsC100Desejadas =
        {
            "ArquivoId", "Chave_Linha",
            "IND_OPER", "IND_EMIT",
            "COD_PART", "COD_MOD", "COD_SIT",
            "SER", "NUM_DOC", "CHV_NFE",
            "DT_DOC", "VL_DOC"
        },
    PrunedC100 =
        Table.SelectColumns(
            FonteC100,
            List.Intersect({ColsC100Desejadas, Table.ColumnNames(FonteC100)}),
            MissingField.Ignore
        ),
    TipadoC100 =
        fxAux_AplicarTiposAuxiliares(
            PrunedC100,
            {{"DT_DOC", type date}, {"COD_PART", type text}, {"COD_SIT", type text}},
            "pt-BR"
        ),
    C100 =
        Table.TransformColumns(
            TipadoC100,
            {
                {"COD_PART", each if _ = null then null else Text.Trim(Text.From(_)), type text},
                {"COD_SIT", each fxAux_NormalizarCodigo(_, 2), type text}
            },
            null,
            MissingField.Ignore
        ),
    ColsPartDesejadas = {"COD_PART", "NOME", "TIPO DOC", "Numero DOC", "IE", "MUNICIPIO", "DataInicial", "DataFinal"},
    PartPruned =
        Table.SelectColumns(
            dim_participante,
            List.Intersect({ColsPartDesejadas, Table.ColumnNames(dim_participante)}),
            MissingField.Ignore
        ),
    PartTipado =
        fxAux_AplicarTiposAuxiliares(
            PartPruned,
            {{"COD_PART", type text}, {"DataInicial", type date}, {"DataFinal", type date}},
            "pt-BR"
        ),
    PartDim =
        Table.TransformColumns(
            PartTipado,
            {{"COD_PART", each if _ = null then null else Text.Trim(Text.From(_)), type text}},
            null,
            MissingField.Ignore
        ),
    PartBuffered = Table.Buffer(PartDim),
    MergePart =
        Table.NestedJoin(
            C100, {"COD_PART"},
            PartBuffered, {"COD_PART"},
            "TbPart", JoinKind.LeftOuter
        ),
    ExpandePart =
        Table.ExpandTableColumn(
            MergePart,
            "TbPart",
            List.Intersect({{"NOME", "TIPO DOC", "Numero DOC", "IE", "MUNICIPIO", "DataInicial", "DataFinal"}, Table.ColumnNames(PartBuffered)}),
            {"NOME", "TIPO DOC", "Numero DOC", "IE", "MUNICIPIO", "DataInicial", "DataFinal"}
        ),
    PartSemMatch = Table.SelectRows(ExpandePart, each [DataInicial] = null),
    PartComMatch0 = Table.SelectRows(ExpandePart, each [DataInicial] <> null and [DT_DOC] <> null),
    PartComMatch =
        Table.SelectRows(
            PartComMatch0,
            each [DataInicial] <= [DT_DOC] and ([DataFinal] = null or [DT_DOC] < [DataFinal])
        ),
    PartUniao = Table.Combine({PartSemMatch, PartComMatch}),
    PartOrdenado =
        Table.Sort(
            PartUniao,
            {{"ArquivoId", Order.Ascending}, {"Chave_Linha", Order.Ascending}, {"DataInicial", Order.Descending}}
        ),
    PartEscolhido = Table.Distinct(PartOrdenado, {"ArquivoId", "Chave_Linha"}),
    PartLimpo = Table.RemoveColumns(PartEscolhido, {"DataInicial", "DataFinal"}, MissingField.Ignore),
    ColsSitDesejadas = {"Código", "Descrição", "Início", "Fim"},
    SitPruned =
        Table.SelectColumns(
            dim_situacao_doc,
            List.Intersect({ColsSitDesejadas, Table.ColumnNames(dim_situacao_doc)}),
            MissingField.Ignore
        ),
    SitTipado =
        fxAux_AplicarTiposAuxiliares(
            SitPruned,
            {{"Código", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}},
            "pt-BR"
        ),
    SitDim =
        Table.TransformColumns(
            SitTipado,
            {{"Código", each fxAux_NormalizarCodigo(_, 2), type text}},
            null,
            MissingField.Ignore
        ),
    SitBuffered = Table.Buffer(SitDim),
    SitHasFim = Table.HasColumns(SitBuffered, "Fim"),
    MergeSit =
        Table.NestedJoin(
            PartLimpo, {"COD_SIT"},
            SitBuffered, {"Código"},
            "TbSit", JoinKind.LeftOuter
        ),
    ExpandeSit =
        Table.ExpandTableColumn(
            MergeSit,
            "TbSit",
            List.Intersect({{"Descrição", "Início", "Fim"}, Table.ColumnNames(SitBuffered)}),
            {"DESC_SITUACAO", "Sit_Inicio", "Sit_Fim"}
        ),
    SitSemMatch = Table.SelectRows(ExpandeSit, each [Sit_Inicio] = null),
    SitComMatch0 = Table.SelectRows(ExpandeSit, each [Sit_Inicio] <> null and [DT_DOC] <> null),
    SitComMatch =
        if SitHasFim then
            Table.SelectRows(
                SitComMatch0,
                each [Sit_Inicio] <= [DT_DOC] and ([Sit_Fim] = null or [DT_DOC] < [Sit_Fim])
            )
        else
            Table.SelectRows(SitComMatch0, each [Sit_Inicio] <= [DT_DOC]),
    SitUniao = Table.Combine({SitSemMatch, SitComMatch}),
    SitOrdenado =
        Table.Sort(
            SitUniao,
            {{"ArquivoId", Order.Ascending}, {"Chave_Linha", Order.Ascending}, {"Sit_Inicio", Order.Descending}}
        ),
    SitEscolhido = Table.Distinct(SitOrdenado, {"ArquivoId", "Chave_Linha"}),
    SitLimpo = Table.RemoveColumns(SitEscolhido, {"Sit_Inicio", "Sit_Fim", "Código"}, MissingField.Ignore),
    TipagemFinal =
        fxAux_AplicarTiposAuxiliares(
            SitLimpo,
            {
                {"NOME", type text}, {"TIPO DOC", type text}, {"Numero DOC", type text},
                {"IE", type text}, {"MUNICIPIO", type text}, {"DESC_SITUACAO", type text}
            },
            "pt-BR"
        ),
    Final =
        fxAux_ReordenarColunasSeguras(
            TipagemFinal,
            {
                "ArquivoId", "Chave_Linha", "COD_PART", "COD_MOD", "COD_SIT", "SER", "NUM_DOC",
                "DT_DOC", "VL_DOC", "CHV_NFE", "IND_OPER", "IND_EMIT",
                "NOME", "TIPO DOC", "Numero DOC", "IE", "MUNICIPIO", "DESC_SITUACAO"
            }
        )
in
    Final
