let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_cod_receita"]}[Content],
    #"Tipo Alterado" = Table.TransformColumnTypes(Fonte,{{"Código", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}})
in
    #"Tipo Alterado"

