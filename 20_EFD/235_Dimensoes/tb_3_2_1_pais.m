let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_3_2_1_pais"]}[Content],
    #"Tipo Alterado" = Table.TransformColumnTypes(Fonte,{{"COD_PAIS", type text}, {"NOME_PAIS", type text}, {"SITUACAO", type text}, {"DATA_INICIO", type date}, {"DATA_FIM", type date}}),
    #"Colunas Renomeadas" = Table.RenameColumns(#"Tipo Alterado",{{"DATA_INICIO", "INICIO"}, {"DATA_FIM", "FIM"}})
in
    #"Colunas Renomeadas"

