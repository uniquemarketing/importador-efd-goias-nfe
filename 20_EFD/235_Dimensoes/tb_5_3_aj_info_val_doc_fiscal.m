let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_5_3_aj_info_val_doc_fiscal"]}[Content],
    #"Colunas Renomeadas" = Table.RenameColumns(Fonte,{{"Descrição do ajustes/benefício/incentivo", "Descrição"}}),
    #"Colunas Removidas" = Table.RemoveColumns(#"Colunas Renomeadas",{"B", "B - Reflexo na Apuração", "C", "C - Tipo de Apuração", "D", "D - Responsabilidade", "E", "E - Influência no Recolhimento", "F", "F -Origem da Tributação", "GGG", "GGG - Ajuste de ICMS", "UF"}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Colunas Removidas",{{"Código", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}})
in
    #"Tipo Alterado"

