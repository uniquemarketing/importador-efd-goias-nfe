let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_4_5_5_classific_contrib_ipi"]}[Content],
    #"Colunas Renomeadas" = Table.RenameColumns(Fonte,{{"COD_ESTAB_IND", "Código"}, {"DESCRICAO_TIPO_ATIVIDADE_IPI", "Descrição"}, {"INICIO", "Início"}, {"FIM", "Fim"}}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Colunas Renomeadas",{{"Código", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}})
in
    #"Tipo Alterado"

