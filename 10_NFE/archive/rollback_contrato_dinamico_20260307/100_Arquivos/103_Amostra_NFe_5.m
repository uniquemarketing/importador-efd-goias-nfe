let
    Fonte = #"102_NFE_Arquivos",
    AddMes = Table.AddColumn(
        Fonte, "dhMes", each if [dhEmi] = null then null else Date.StartOfMonth(Date.From([dhEmi])), type date
    ),
    SoComDhEmi = Table.SelectRows(AddMes, each [dhMes] <> null),
    GruposMes = Table.Group(
        SoComDhEmi,
        {"dhMes"},
        {
            {
                "AmostraMes",
                each Table.FirstN(Table.Sort(_, {{"dhEmi", Order.Ascending}, {"nfe_id", Order.Ascending}}), 5)
            }
        }
    ),
    ListaAmostras = GruposMes[AmostraMes],
    AmostraMensal = if List.Count(ListaAmostras) = 0 then Table.FirstN(Fonte, 0) else Table.Combine(ListaAmostras),
    SortAmostra = Table.Sort(AmostraMensal, {{"dhEmi", Order.Ascending}, {"nfe_id", Order.Ascending}}),
    Resultado = Table.RemoveColumns(SortAmostra, {"dhMes"})
in
    Resultado
