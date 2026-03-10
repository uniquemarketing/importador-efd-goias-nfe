(Tabela as table, OrdemPreferida as list) as table =>
let
    ColunasAtuais = Table.ColumnNames(Tabela),
    OrdemSegura =
        List.Distinct(
            List.Combine(
                {
                    List.Intersect({OrdemPreferida, ColunasAtuais}),
                    ColunasAtuais
                }
            )
        ),
    Final = Table.ReorderColumns(Tabela, OrdemSegura, MissingField.Ignore)
in
    Final
