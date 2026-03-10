(Tabela as table, Tipagem as list, optional Cultura as nullable text) as table =>
let
    ColunasAtuais = Table.ColumnNames(Tabela),
    TipagemAplicavel =
        List.Select(
            Tipagem,
            each List.Count(_) >= 2 and List.Contains(ColunasAtuais, _{0})
        ),
    Final =
        if List.Count(TipagemAplicavel) = 0 then
            Tabela
        else if Cultura = null then
            Table.TransformColumnTypes(Tabela, TipagemAplicavel)
        else
            Table.TransformColumnTypes(Tabela, TipagemAplicavel, Cultura)
in
    Final
