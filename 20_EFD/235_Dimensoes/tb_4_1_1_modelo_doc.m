let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_4_1_1_modelo_doc"]}[Content],
    #"Colunas Renomeadas" = Table.RenameColumns(Fonte,{{"COD_MOD", "Código"}, {"DESC_MOD", "Descrição"}, {"INICIO", "Início"}, {"FIM", "Fim"}}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Colunas Renomeadas",{{"Código", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}})
in
    #"Tipo Alterado"

