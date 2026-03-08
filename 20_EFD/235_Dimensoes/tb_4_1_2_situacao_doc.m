let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_4_1_2_situacao_doc"]}[Content],
    #"Colunas Renomeadas" = Table.RenameColumns(Fonte,{{"COD_SIT", "Código"}, {"DESC_SIT", "Descrição"}, {"INICIO", "Início"}, {"FIM", "Fim"}}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Colunas Renomeadas",{{"Código", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}})
in
    #"Tipo Alterado"

