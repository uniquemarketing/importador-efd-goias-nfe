let
    // ======================================================
    // 1) FONTE & EARLY COLUMN PRUNING (Otimização de Memória)
    // ======================================================
    Fonte = R0000_base,
    
    // Remove colunas que não agregam valor à dimensão o mais cedo possível
    ColsAtuais = Table.ColumnNames(Fonte),
    RemoverTecnicasIniciais = Table.RemoveColumns(
        Fonte,
        List.Intersect({ColsAtuais, {"Nome", "ArquivoId", "LinhaId"}}),
        MissingField.Ignore
    ),

    // ======================================================
    // 2) PREPARAÇÃO E MERGE (Hash Join em Memória)
    // ======================================================
    // O schemaAuxiliares dita que tb_municipios[Codigo_Municipio] é texto
    AddCOD_MUN_Key = Table.AddColumn(
        RemoverTecnicasIniciais,
        "COD_MUN_Key",
        each let v = try [COD_MUN] otherwise null in if v = null then null else Text.From(v),
        type text
    ),
    
    // Carrega a dimensão pequena na RAM
    BufMunicipios = Table.Buffer(tb_municipios),
    
    MergeMunicipio = Table.NestedJoin(
        AddCOD_MUN_Key, {"COD_MUN_Key"},
        BufMunicipios, {"Codigo_Municipio"},
        "Mun", JoinKind.LeftOuter
    ),
    
    ExpandMunicipio = Table.ExpandTableColumn(
        MergeMunicipio, "Mun", {"Nome_Municipio"}, {"NOME_MUNICIPIO"}
    ),

    // ======================================================
    // 3) SUBSTITUIÇÕES SEMÂNTICAS BLINDADAS
    // ======================================================
    ColsA = Table.ColumnNames(ExpandMunicipio),
    FixFINALIDADE = if List.Contains(ColsA, "FINALIDADE") then
        Table.RemoveColumns(ExpandMunicipio, List.Intersect({ColsA, {"COD_FIN"}}))
    else if List.Contains(ColsA, "COD_FIN") then
        Table.RenameColumns(ExpandMunicipio, {{"COD_FIN", "FINALIDADE"}}, MissingField.Ignore)
    else ExpandMunicipio,

    ColsB = Table.ColumnNames(FixFINALIDADE),
    FixATIVIDADE = if List.Contains(ColsB, "ATIVIDADE") then
        Table.RemoveColumns(FixFINALIDADE, List.Intersect({ColsB, {"IND_ATIV"}}))
    else if List.Contains(ColsB, "IND_ATIV") then
        Table.RenameColumns(FixFINALIDADE, {{"IND_ATIV", "ATIVIDADE"}}, MissingField.Ignore)
    else FixFINALIDADE,

    // Remove as chaves temporárias do JOIN
    RemoveCodMun = Table.RemoveColumns(
        FixATIVIDADE,
        List.Intersect({Table.ColumnNames(FixATIVIDADE), {"COD_MUN", "COD_MUN_Key"}})
    ),

    // ======================================================
    // 4) TIPAGEM MÍNIMA PARA ORDENAÇÃO ESTÁVEL
    // ======================================================
    TiposMinimos = Table.TransformColumnTypes(
        RemoveCodMun,
        {{"CNPJ", type text}, {"DT_INI", type date}, {"DT_FIN", type date}, {"Periodo", type text}},
        "pt-BR"
    ),
    
    // Helper para o sort cronológico
    AddPeriodoNum = Table.AddColumn(
        TiposMinimos,
        "PeriodoNum",
        each let p = try Text.Trim(Text.From([Periodo])) otherwise null in try Number.FromText(p) otherwise null,
        Int64.Type
    ),

    // ======================================================
    // 5) DEDUPLICAÇÃO: 1 LINHA POR CNPJ (Regra da Última Ocorrência)
    // ======================================================
    Ordenado = Table.Sort(
        AddPeriodoNum,
        {{"CNPJ", Order.Ascending}, {"DT_INI", Order.Descending}, {"PeriodoNum", Order.Descending}}
    ),
    
    Agrupado = Table.Group(
        Ordenado,
        {"CNPJ"},
        {{"_Top", each Table.FirstN(_, 1), type table}}
    ),
    
    Expandido = Table.ExpandTableColumn(
        Agrupado,
        "_Top",
        List.RemoveItems(Table.ColumnNames(Ordenado), {"CNPJ"}),
        List.RemoveItems(Table.ColumnNames(Ordenado), {"CNPJ"})
    ),

    // ======================================================
    // 6) AUDITORIA E CHAVE DO MODELO
    // ======================================================
    RenomeiaAuditoria = if List.Contains(Table.ColumnNames(Expandido), "Periodo") then
        Table.RenameColumns(Expandido, {{"Periodo", "Periodo_ULT"}}, MissingField.Ignore)
    else Expandido,

    RemoverTecnicasFinais = Table.RemoveColumns(
        RenomeiaAuditoria,
        List.Intersect({Table.ColumnNames(RenomeiaAuditoria), {"Chave_Linha", "Chave_Pai", "PeriodoNum"}})
    ),

    AddEmpresaKey = Table.AddColumn(RemoverTecnicasFinais, "EmpresaKey", each [CNPJ], type text),

    // ======================================================
    // 7) TIPAGEM FINAL E REORDENAÇÃO
    // ======================================================
    TiposFinais = Table.TransformColumnTypes(
        AddEmpresaKey,
        {
            {"EmpresaKey", type text}, {"CNPJ", type text}, {"Periodo_ULT", type text},
            {"COD_VER", type text}, {"FINALIDADE", type text}, {"DT_INI", type date}, {"DT_FIN", type date},
            {"NOME", type text}, {"CPF", type text}, {"UF", type text}, {"IE", type text},
            {"NOME_MUNICIPIO", type text}, {"IM", type text}, {"SUFRAMA", type text},
            {"IND_PERFIL", type text}, {"ATIVIDADE", type text}
        },
        "pt-BR"
    ),
    
    ColsOut = Table.ColumnNames(TiposFinais),
    OrdemPreferida = {"EmpresaKey", "CNPJ"},
    Final = Table.ReorderColumns(
        TiposFinais,
        List.Combine({OrdemPreferida, List.RemoveItems(ColsOut, OrdemPreferida)}),
        MissingField.Ignore
    )
in
    Final

