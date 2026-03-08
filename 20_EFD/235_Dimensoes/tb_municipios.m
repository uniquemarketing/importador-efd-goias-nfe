let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_municipios"]}[Content],
    #"Tipo Alterado" = Table.TransformColumnTypes(Fonte,{{"UF", type text}, {"Nome_UF", type text}, {"Codigo_Municipio", type text}, {"Nome_Municipio", type text}})
in
    #"Tipo Alterado"

