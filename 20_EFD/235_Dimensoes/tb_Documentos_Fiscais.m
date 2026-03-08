let
    // =====================================================================
    // 1) FONTE (FATO C100) + EARLY PRUNING
    // =====================================================================
    FonteC100 = RC100_base,

    ColsC100Desejadas = {
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

    // Tipagem segura (somente colunas existentes)
    TiposC100Candidatos = {
        {"DT_DOC", type date},
        {"COD_PART", type text},
        {"COD_SIT", type text}
    },
    TiposC100Aplicaveis = List.Select(TiposC100Candidatos, each List.Contains(Table.ColumnNames(PrunedC100), _{0})),
    TipadoC100 =
        if List.Count(TiposC100Aplicaveis) = 0
        then PrunedC100
        else Table.TransformColumnTypes(PrunedC100, TiposC100Aplicaveis, "pt-BR"),

    // Normaliza chaves (trim) e COD_SIT com padstart se 1 dígito
    C100 =
        Table.TransformColumns(
            TipadoC100,
            List.Select(
                {
                    {"COD_PART", each if _ = null then null else Text.Trim(Text.From(_)), type text},
                    {"COD_SIT", each
                        let t = if _ = null then null else Text.Trim(Text.From(_))
                        in if t = null then null else if Text.Length(t) = 1 then Text.PadStart(t, 2, "0") else t,
                     type text}
                },
                each List.Contains(Table.ColumnNames(TipadoC100), _{0})
            ),
            null,
            MissingField.Ignore
        ),

    // =====================================================================
    // 2) DIMENSÃO PARTICIPANTES (SCD2) — SET-BASED
    // =====================================================================
    // Pruning da dimensão (inclui vigência)
    ColsPartDesejadas = {"COD_PART", "NOME", "TIPO DOC", "Numero DOC", "IE", "MUNICIPIO", "DataInicial", "DataFinal"},
    PartPruned =
        Table.SelectColumns(
            tb_participantes,
            List.Intersect({ColsPartDesejadas, Table.ColumnNames(tb_participantes)}),
            MissingField.Ignore
        ),

    // Tipagem mínima (se existir)
    TiposPartCandidatos = {
        {"COD_PART", type text},
        {"DataInicial", type date},
        {"DataFinal", type date}
    },
    TiposPartAplicaveis = List.Select(TiposPartCandidatos, each List.Contains(Table.ColumnNames(PartPruned), _{0})),
    PartTipado =
        if List.Count(TiposPartAplicaveis) = 0
        then PartPruned
        else Table.TransformColumnTypes(PartPruned, TiposPartAplicaveis, "pt-BR"),

    PartDim =
        if Table.HasColumns(PartTipado, "COD_PART")
        then Table.TransformColumns(PartTipado, {{"COD_PART", each if _ = null then null else Text.Trim(Text.From(_)), type text}}, null, MissingField.Ignore)
        else PartTipado,

    // Participantes é pequeno (369 linhas no seu teste): buffering aqui é seguro e acelera hash join
    PartBuffered = Table.Buffer(PartDim),

    // Merge + Expansão (gera uma linha por versão do participante)
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
            List.Intersect({{"NOME","TIPO DOC","Numero DOC","IE","MUNICIPIO","DataInicial","DataFinal"}, Table.ColumnNames(PartBuffered)}),
            {"NOME","TIPO DOC","Numero DOC","IE","MUNICIPIO","DataInicial","DataFinal"}
        ),

    // Se não houve match (DataInicial null), mantém a linha
    PartSemMatch = Table.SelectRows(ExpandePart, each [DataInicial] = null),

    // Filtra vigência em lote para os casos com match
    PartComMatch0 = Table.SelectRows(ExpandePart, each [DataInicial] <> null and [DT_DOC] <> null),

    PartComMatch =
        Table.SelectRows(
            PartComMatch0,
            each [DataInicial] <= [DT_DOC] and ([DataFinal] = null or [DT_DOC] < [DataFinal])
        ),

    // Combina (linhas sem match + linhas com match válido)
    PartUniao = Table.Combine({PartSemMatch, PartComMatch}),

    // Seleciona a versão correta: ordena por DataInicial DESC e dedup por documento
    PartOrdenado =
        Table.Sort(
            PartUniao,
            {{"ArquivoId", Order.Ascending}, {"Chave_Linha", Order.Ascending}, {"DataInicial", Order.Descending}}
        ),

    PartEscolhido =
        Table.Distinct(PartOrdenado, {"ArquivoId", "Chave_Linha"}),

    // Remove colunas técnicas da dimensão (vigência) após selecionar a versão
    PartLimpo =
        Table.RemoveColumns(PartEscolhido, {"DataInicial", "DataFinal"}, MissingField.Ignore),

    // =====================================================================
    // 3) DIMENSÃO SITUAÇÃO DO DOCUMENTO — SET-BASED AS-OF
    // =====================================================================
    ColsSitDesejadas = {"Código", "Descrição", "Início", "Fim"},
    SitPruned =
        Table.SelectColumns(
            tb_4_1_2_situacao_doc,
            List.Intersect({ColsSitDesejadas, Table.ColumnNames(tb_4_1_2_situacao_doc)}),
            MissingField.Ignore
        ),

    TiposSitCandidatos = {
        {"Código", type text},
        {"Início", type date},
        {"Fim", type date},
        {"Descrição", type text}
    },
    TiposSitAplicaveis = List.Select(TiposSitCandidatos, each List.Contains(Table.ColumnNames(SitPruned), _{0})),
    SitTipado =
        if List.Count(TiposSitAplicaveis) = 0
        then SitPruned
        else Table.TransformColumnTypes(SitPruned, TiposSitAplicaveis, "pt-BR"),

    SitDim =
        if Table.HasColumns(SitTipado, "Código")
        then Table.TransformColumns(SitTipado, {{"Código", each if _ = null then null else Text.Trim(Text.From(_)), type text}}, null, MissingField.Ignore)
        else SitTipado,

    // Situação é minúscula (13 linhas): buffering perfeito aqui
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
            List.Intersect({{"Descrição","Início","Fim"}, Table.ColumnNames(SitBuffered)}),
            {"DESC_SITUACAO","Sit_Inicio","Sit_Fim"}
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
            Table.SelectRows(
                SitComMatch0,
                each [Sit_Inicio] <= [DT_DOC]
            ),

    SitUniao = Table.Combine({SitSemMatch, SitComMatch}),

    SitOrdenado =
        Table.Sort(
            SitUniao,
            {{"ArquivoId", Order.Ascending}, {"Chave_Linha", Order.Ascending}, {"Sit_Inicio", Order.Descending}}
        ),

    SitEscolhido =
        Table.Distinct(SitOrdenado, {"ArquivoId", "Chave_Linha"}),

    SitLimpo =
        Table.RemoveColumns(SitEscolhido, {"Sit_Inicio", "Sit_Fim", "Código"}, MissingField.Ignore),

    // =====================================================================
    // 4) TIPAGEM FINAL + REORDENAÇÃO
    // =====================================================================
    TiposFinaisCandidatos = {
        {"NOME", type text},
        {"TIPO DOC", type text},
        {"Numero DOC", type text},
        {"IE", type text},
        {"MUNICIPIO", type text},
        {"DESC_SITUACAO", type text}
    },
    TiposFinaisAplicaveis = List.Select(TiposFinaisCandidatos, each List.Contains(Table.ColumnNames(SitLimpo), _{0})),
    TipagemFinal =
        if List.Count(TiposFinaisAplicaveis) = 0
        then SitLimpo
        else Table.TransformColumnTypes(SitLimpo, TiposFinaisAplicaveis, "pt-BR"),

    ColsFinais = Table.ColumnNames(TipagemFinal),
    OrdemBase = {
        "ArquivoId", "Chave_Linha", "COD_PART", "COD_MOD", "COD_SIT", "SER", "NUM_DOC",
        "DT_DOC", "VL_DOC", "CHV_NFE", "IND_OPER", "IND_EMIT",
        "NOME", "TIPO DOC", "Numero DOC", "IE", "MUNICIPIO", "DESC_SITUACAO"
    },
    OrdemSegura = List.Distinct(List.Combine({List.Intersect({OrdemBase, ColsFinais}), ColsFinais})),
    ReordenaFinal = Table.ReorderColumns(TipagemFinal, OrdemSegura, MissingField.Ignore)
in
    ReordenaFinal

