let
    // =========================================================
    // QA: COD_PART associado a mais de um CNPJ 
    // Retorna as combinações (COD_PART, CNPJ) para códigos internos "problemáticos",
    // unificando o período total em que a anomalia ocorreu.
    // =========================================================

    // 1) Column pruning (performance) + Trazendo as datas e o ArquivoId
    R0000_Min = Table.SelectColumns(R0000_base, {"ArquivoId", "DT_INI", "DT_FIN"}),
    R0150_Min = Table.SelectColumns(R0150_base, {"ArquivoId", "COD_PART", "CNPJ"}),

    // 2) O Atalho: R0150 -> R0000 direto via ArquivoId
    J0150 = Table.NestedJoin(
        R0150_Min,
        {"ArquivoId"},
        R0000_Min,
        {"ArquivoId"},
        "R0000",
        JoinKind.Inner
    ),
    
    // 3) Expande as datas que faltavam
    E0150 = Table.ExpandTableColumn(J0150, "R0000", {"DT_INI", "DT_FIN"}, {"DT_INI", "DT_FIN"}),

    // 4) Normalização defensiva
    Norm = Table.TransformColumns(
        E0150,
        {
            {"COD_PART", each if _ = null then null else Text.Trim(Text.From(_)), type text},
            {"CNPJ",     each if _ = null then null else Text.Trim(Text.From(_)), type text}
        }
    ),

    // 5) Remove COD_PART vazio (não faz sentido na checagem)
    Validos = Table.SelectRows(
        Norm,
        each [COD_PART] <> null and [COD_PART] <> "" 
    ),

    // 6) Base única de pares (COD_PART, CNPJ) para contar corretamente
    Pares = Table.Distinct(Table.SelectColumns(Validos, {"COD_PART", "CNPJ"}), {"COD_PART", "CNPJ"}),

    // 7) Conta quantos CNPJs distintos existem por COD_PART
    Agrupa = Table.Group(
        Pares,
        {"COD_PART"},
        {{"Qtde_CNPJ", each List.Count(List.Distinct([CNPJ])), Int64.Type}}
    ),

    // 8) Mantém só COD_PART com mais de um CNPJ
    CODPART_Problema = Table.SelectRows(Agrupa, each [Qtde_CNPJ] > 1),

    // 9) Inner Join de volta para atuar como um filtro massivo (Pushdown)
    JoinDeVolta = Table.NestedJoin(
        CODPART_Problema,
        {"COD_PART"},
        Validos,
        {"COD_PART"},
        "Detalhes",
        JoinKind.Inner
    ),
    
    // 10) Expande as colunas (agora a tabela Detalhes possui DT_INI e DT_FIN)
    Out = Table.ExpandTableColumn(JoinDeVolta, "Detalhes", {"CNPJ", "DT_INI", "DT_FIN"}, {"CNPJ", "DT_INI", "DT_FIN"}),

    // ========================================================================
    // 11) REDUÇÃO DE GRANULARIDADE (AGRUPAMENTO TEMPORAL)
    // ========================================================================
    // Em vez de Distinct, usamos Group By para "colar" os meses consecutivos.
    // Assim, se o erro ocorreu de Jan a Mar, teremos 1 linha (01/01 a 31/03)
    // em vez de 3 linhas soltas.
    AgrupaFinal = Table.Group(
        Out,
        {"COD_PART", "Qtde_CNPJ", "CNPJ"},
        {
            {"DT_INI_Min", each List.Min([DT_INI]), type date},
            {"DT_FIN_Max", each List.Max([DT_FIN]), type date}
        }
    ),

    // 12) Ordenação final lógica (Primeiro o Código, depois a Data e o CNPJ)
    Final = Table.Sort(AgrupaFinal, {{"COD_PART", Order.Ascending}, {"DT_INI_Min", Order.Ascending},  {"CNPJ", Order.Ascending}})
in
    Final

