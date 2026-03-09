let
    Fonte = R0000_base,
    ColunasIniciais = Table.ColumnNames(Fonte),
    Base =
        Table.RemoveColumns(
            Fonte,
            List.Intersect({ColunasIniciais, {"Nome", "ArquivoId", "LinhaId"}}),
            MissingField.Ignore
        ),
    AddCOD_MUN_Key =
        Table.AddColumn(
            Base,
            "COD_MUN_Key",
            each fxAux_NormalizarCodigo(try [COD_MUN] otherwise null, 7),
            type text
        ),
    BufMunicipios =
        Table.Buffer(
            Table.SelectColumns(dim_municipio, {"Codigo_Municipio", "Nome_Municipio"}, MissingField.Ignore)
        ),
    MergeMunicipio =
        Table.NestedJoin(
            AddCOD_MUN_Key, {"COD_MUN_Key"},
            BufMunicipios, {"Codigo_Municipio"},
            "Municipio", JoinKind.LeftOuter
        ),
    ExpandMunicipio =
        Table.ExpandTableColumn(
            MergeMunicipio,
            "Municipio",
            {"Nome_Municipio"},
            {"NOME_MUNICIPIO"}
        ),
    ColunasA = Table.ColumnNames(ExpandMunicipio),
    FixFINALIDADE =
        if List.Contains(ColunasA, "FINALIDADE") then
            Table.RemoveColumns(ExpandMunicipio, List.Intersect({ColunasA, {"COD_FIN"}}), MissingField.Ignore)
        else if List.Contains(ColunasA, "COD_FIN") then
            Table.RenameColumns(ExpandMunicipio, {{"COD_FIN", "FINALIDADE"}}, MissingField.Ignore)
        else
            ExpandMunicipio,
    ColunasB = Table.ColumnNames(FixFINALIDADE),
    FixATIVIDADE =
        if List.Contains(ColunasB, "ATIVIDADE") then
            Table.RemoveColumns(FixFINALIDADE, List.Intersect({ColunasB, {"IND_ATIV"}}), MissingField.Ignore)
        else if List.Contains(ColunasB, "IND_ATIV") then
            Table.RenameColumns(FixFINALIDADE, {{"IND_ATIV", "ATIVIDADE"}}, MissingField.Ignore)
        else
            FixFINALIDADE,
    RemoveCodMun =
        Table.RemoveColumns(
            FixATIVIDADE,
            List.Intersect({Table.ColumnNames(FixATIVIDADE), {"COD_MUN", "COD_MUN_Key"}}),
            MissingField.Ignore
        ),
    TiposMinimos =
        fxAux_AplicarTiposAuxiliares(
            RemoveCodMun,
            {{"CNPJ", type text}, {"DT_INI", type date}, {"DT_FIN", type date}, {"Periodo", type text}},
            "pt-BR"
        ),
    AddPeriodoNum =
        Table.AddColumn(
            TiposMinimos,
            "PeriodoNum",
            each
                let
                    PeriodoTexto = try Text.Trim(Text.From([Periodo])) otherwise null
                in
                    try Number.FromText(PeriodoTexto) otherwise null,
            Int64.Type
        ),
    Ordenado =
        Table.Sort(
            AddPeriodoNum,
            {{"CNPJ", Order.Ascending}, {"DT_INI", Order.Descending}, {"PeriodoNum", Order.Descending}}
        ),
    Agrupado =
        Table.Group(
            Ordenado,
            {"CNPJ"},
            {{"_Top", each Table.FirstN(_, 1), type table}}
        ),
    ColunasOrdenado = Table.ColumnNames(Ordenado),
    Expandido =
        Table.ExpandTableColumn(
            Agrupado,
            "_Top",
            List.RemoveItems(ColunasOrdenado, {"CNPJ"}),
            List.RemoveItems(ColunasOrdenado, {"CNPJ"})
        ),
    RenomeiaAuditoria =
        if List.Contains(Table.ColumnNames(Expandido), "Periodo") then
            Table.RenameColumns(Expandido, {{"Periodo", "Periodo_ULT"}}, MissingField.Ignore)
        else
            Expandido,
    Limpo =
        Table.RemoveColumns(
            RenomeiaAuditoria,
            List.Intersect({Table.ColumnNames(RenomeiaAuditoria), {"Chave_Linha", "Chave_Pai", "PeriodoNum"}}),
            MissingField.Ignore
        ),
    AddEmpresaKey = Table.AddColumn(Limpo, "EmpresaKey", each [CNPJ], type text),
    TiposFinais =
        fxAux_AplicarTiposAuxiliares(
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
    Final = fxAux_ReordenarColunasSeguras(TiposFinais, {"EmpresaKey", "CNPJ"})
in
    Final
