let
    t = EFD_Extraida,
    g = Table.Group(t, {"Periodo"}, {{"Linhas", each Table.RowCount(_), Int64.Type}}),
    s = Table.Sort(g, {{"Linhas", Order.Ascending}})
in
    s

