(tabela as table) =>
    let
        Fonte = tabela,
        #"Colunas Não Dinâmicas" = Table.UnpivotOtherColumns(Fonte, {}, "Atributo", "Valor"),
        #"Linhas Filtradas" = Table.SelectRows(#"Colunas Não Dinâmicas", each ([Valor] is table)),
        Personalizar1 = List.Distinct(#"Linhas Filtradas"[Atributo])
    in
        Personalizar1
