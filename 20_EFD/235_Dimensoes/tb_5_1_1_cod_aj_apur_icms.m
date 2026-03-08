let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_5_1_1_cod_aj_apur_icms"]}[Content],
    #"Colunas Renomeadas" = Table.RenameColumns(Fonte,{{"Descricao_do_ajuste", "Descrição"}}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Colunas Renomeadas",{{"Código", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}})
in
    #"Tipo Alterado"

