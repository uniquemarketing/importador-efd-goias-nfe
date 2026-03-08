let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_cest"]}[Content],
    #"Tipo Alterado" = Table.TransformColumnTypes(Fonte,{{"Código", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}})
in
    #"Tipo Alterado"

