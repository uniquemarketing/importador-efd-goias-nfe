let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_4_2_1_gen_mercadoria"]}[Content],
    #"Tipo Alterado" = Table.TransformColumnTypes(Fonte,{{"Código", type text}, {"Descrição", type text}})
in
    #"Tipo Alterado"

