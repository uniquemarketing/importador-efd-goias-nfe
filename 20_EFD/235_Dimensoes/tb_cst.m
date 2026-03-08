let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_cst"]}[Content],
    #"Colunas Renomeadas" = Table.RenameColumns(Fonte,{{"CST_ICMS", "Código"}, {"DESC_CST", "Descrição"}, {"INICIO", "Início"}, {"FIM", "Fim"}}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Colunas Renomeadas",{{"Código", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}})
in
    #"Tipo Alterado"

