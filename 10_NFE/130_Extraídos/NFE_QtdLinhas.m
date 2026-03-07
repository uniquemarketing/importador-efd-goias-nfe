let
    QtdTotais = try Table.RowCount(#"NFE_Totais") otherwise null,
    QtdProdutos = try Table.RowCount(#"NFE_Produtos") otherwise null,
    Resultado = #table(
        {"Consulta", "QtdLinhas"},
        {
            {"NFE_Totais", QtdTotais},
            {"NFE_Produtos", QtdProdutos}
        }
    )
in
    Resultado
