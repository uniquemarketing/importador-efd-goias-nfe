let
    Fonte = NFE_Produtos,
    QtdLinhas = Table.RowCount(Fonte),
    Saida =
        #table(
            type table [Consulta = text, QtdLinhas = Int64.Type],
            {{"NFE_Produtos", QtdLinhas}}
        )
in
    Saida
