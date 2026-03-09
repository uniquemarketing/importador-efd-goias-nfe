let
    Fonte = Table.NestedJoin(R0000_base, {"Chave_Linha"}, R0001_base, {"Chave_Pai"}, "R0001_base", JoinKind.Inner),

    RemoveCols01 = Table.RemoveColumns(
        Fonte,
        {"Nome", "Periodo", "ArquivoId", "LinhaId", "Chave_Linha", "Chave_Pai",
         "COD_VER", "COD_FIN", "NOME", "CNPJ", "CPF", "UF", "IE",
         "COD_MUN", "IM", "SUFRAMA", "IND_PERFIL", "IND_ATIV",
         "FINALIDADE", "ATIVIDADE"}
    ),

    ExpandeR0001 = Table.ExpandTableColumn(
        RemoveCols01,
        "R0001_base",
        {"Chave_Linha"},
        {"R0001_base.Chave_Linha"}
    ),

    MesclaR0001_R0150 = Table.NestedJoin(
        ExpandeR0001,
        {"R0001_base.Chave_Linha"},
        R0150_base,
        {"Chave_Pai"},
        "R0150_base",
        JoinKind.Inner
    ),

    ExpandeR0150 = Table.ExpandTableColumn(
        MesclaR0001_R0150,
        "R0150_base",
        {"Nome", "Periodo", "Chave_Linha", "COD_PART", "CNPJ"},
        {"R0150_base.Nome", "R0150_base.Periodo", "R0150_base.Chave_Linha",
         "R0150_base.COD_PART", "R0150_base.CNPJ"}
    ),

    // 🔎 FILTRO ANTES DO JOIN (Alta performance)
    R0175_Filtrado =
        Table.SelectRows(
            R0175_base,
            each
                let v = try Text.Trim(Text.From([NR_CAMPO])) otherwise null
                in v = "05" or v = "06" or v = "5" or v = "6"
        ),

    MesclaR0150_R0175 = Table.NestedJoin(
        ExpandeR0150,
        {"R0150_base.Chave_Linha"},
        R0175_Filtrado,
        {"Chave_Pai"},
        "R0175_base",
        JoinKind.Inner
    ),

    RemoveCols02 = Table.RemoveColumns(
        MesclaR0150_R0175,
        {"R0001_base.Chave_Linha", "R0150_base.Nome", "R0150_base.Chave_Linha"}
    ),

    ExpandeR0175 = Table.ExpandTableColumn(
        RemoveCols02,
        "R0175_base",
        {"DT_ALT", "NR_CAMPO", "CONT_ANT"},
        {"R0175_base.DT_ALT", "R0175_base.NR_CAMPO", "R0175_base.CONT_ANT"}
    ),

    Renomea = Table.RenameColumns(
        ExpandeR0175,
        {
            {"DT_INI", "DT_INI_R0000"},
            {"DT_FIN", "DT_FIN_R0000"},
            {"R0150_base.Periodo", "PERIODO_R0150"},
            {"R0150_base.COD_PART", "COD_PART_R0150"},
            {"R0150_base.CNPJ", "CNPJ_R0150"},
            {"R0175_base.DT_ALT", "DT_ALT_R0175"},
            {"R0175_base.NR_CAMPO", "NR_CAMPO_R0175"},
            {"R0175_base.CONT_ANT", "CONT_ANT_R0175"}
        }
    )
in
    Renomea

