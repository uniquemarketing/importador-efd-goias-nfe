let
    // =========================================================
    // QA: CNPJs associados a mais de um COD_PART (na cadeia 0000->0001->0150)
    // Retorna TODAS as combinações (CNPJ, COD_PART) apenas para CNPJs "problemáticos".
    // =========================================================

    // 1) Column pruning (performance)
    R0000_Min = Table.SelectColumns(R0000_base, {"Chave_Linha", "DT_INI", "DT_FIN"}),
    R0001_Min = Table.SelectColumns(R0001_base, {"Chave_Pai", "Chave_Linha"}),
    R0150_Min = Table.SelectColumns(R0150_base, {"Chave_Pai", "COD_PART", "CNPJ"}),

    // 2) 0000 -> 0001 (ponte hierárquica)
    J01 = Table.NestedJoin(
        R0000_Min, {"Chave_Linha"}, 
        R0001_Min, {"Chave_Pai"}, 
        "R0001_Aninhado", 
        JoinKind.Inner
    ),
    E01 = Table.ExpandTableColumn(J01, "R0001_Aninhado", 
        {"Chave_Linha"}, 
        {"Chave_Linha_R0001"}),

    // 3) 0001 -> 0150
    J0150 = Table.NestedJoin(
        E01,
        {"Chave_Linha_R0001"},
        R0150_Min,
        {"Chave_Pai"},
        "R0150",
        JoinKind.Inner
    ),
    E0150 = Table.ExpandTableColumn(J0150, "R0150", {"COD_PART", "CNPJ"}, {"COD_PART", "CNPJ"}),

    // 4) Normalização defensiva
    Norm = Table.TransformColumns(
        E0150,
        {
            {"COD_PART", each if _ = null then null else Text.Trim(Text.From(_)), type text},
            {"CNPJ",     each if _ = null then null else Text.Trim(Text.From(_)), type text}
        }
    ),

   // 5) Remove CNPJ nulo/vazio (não faz sentido na checagem)
    Validos = Table.SelectRows(Norm, each [CNPJ] <> null and [CNPJ] <> ""),

    // 6) Base única de pares (CNPJ, COD_PART) para contar corretamente
    // Mantemos isso igual, pois isolar as chaves é vital para a contagem exata.
    Pares = Table.Distinct(Table.SelectColumns(Validos, {"CNPJ", "COD_PART"}), {"CNPJ", "COD_PART"}),

    // 7) Conta quantos COD_PART distintos existem por CNPJ
    Agrupa = Table.Group(
        Pares,
        {"CNPJ"},
        {{"Qtde_COD_PART", each List.Count(List.Distinct([COD_PART])), Int64.Type}}
    ),

    // 8) Mantém só CNPJ com mais de um COD_PART
    CNPJ_Problema = Table.SelectRows(Agrupa, each [Qtde_COD_PART] > 1),

    // ========================================================================
    // 9) O PULO DO GATO: Join na tabela 'Validos' (que possui as datas)
    // ========================================================================
    // Usamos Inner Join para que a tabela CNPJ_Problema atue como um filtro massivo,
    // trazendo apenas as linhas da tabela Validos que estão com inconsistência.
    JoinDeVolta = Table.NestedJoin(
        CNPJ_Problema,
        {"CNPJ"},
        Validos, 
        {"CNPJ"},
        "Detalhes",
        JoinKind.Inner 
    ),

    // 10) Expande as colunas (agora temos acesso ao COD_PART e às Datas)
        Out = Table.ExpandTableColumn(JoinDeVolta, "Detalhes", {"COD_PART", "DT_INI", "DT_FIN"}, {"COD_PART", "DT_INI", "DT_FIN"}),

        // ========================================================================
        // 11) REDUÇÃO DE GRANULARIDADE (AGRUPAMENTO TEMPORAL)
        // ========================================================================
        // Substituímos o Distinct por Group. Isso "cola" os meses consecutivos do 
        // mesmo COD_PART e CNPJ, mostrando apenas o período total (Mínimo e Máximo).
        AgrupaFinal = Table.Group(
            Out,
            {"CNPJ", "Qtde_COD_PART", "COD_PART"},
            {
                {"DT_INI_Min", each List.Min([DT_INI]), type date},
                {"DT_FIN_Max", each List.Max([DT_FIN]), type date}
            }
        ),

        // 12) Ordenação final
        Final = Table.Sort(AgrupaFinal, {{"CNPJ", Order.Ascending}, {"DT_INI_Min", Order.Ascending}, {"COD_PART", Order.Ascending}})
in
    Final

