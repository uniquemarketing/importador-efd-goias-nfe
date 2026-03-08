let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_cfop"]}[Content],
    #"Tipo Alterado" = Table.TransformColumnTypes(Fonte,{{"CFOP", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}}),
    #"Colunas Renomeadas" = Table.RenameColumns(#"Tipo Alterado",{{"CFOP", "Código"}})
in
    #"Colunas Renomeadas"

