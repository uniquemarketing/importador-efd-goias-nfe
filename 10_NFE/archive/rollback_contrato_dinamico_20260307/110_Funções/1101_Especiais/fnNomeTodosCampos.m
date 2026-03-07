(valor as any, optional Prefixo as nullable text) as list =>
    let
        prfx = if Prefixo = null or Prefixo = "" then "" else Prefixo & ".",
        nomesBrutos =
            if Value.Is(valor, type table) then
                Table.ColumnNames(valor)
            else if Value.Is(valor, type record) then
                Record.FieldNames(valor)
            else if Value.Is(valor, type list) then
                let
                    itensComplexos = List.Select(
                        valor, each Value.Is(_, type table) or Value.Is(_, type record)
                    ),
                    nomesPorItem = List.Transform(
                        itensComplexos, each if Value.Is(_, type table) then Table.ColumnNames(_) else Record.FieldNames(_)
                    )
                in
                    if List.IsEmpty(nomesPorItem) then {} else List.Union(nomesPorItem)
            else
                {},
        nomesDistintos = List.Distinct(nomesBrutos),
        nomesPrefixados = List.Transform(nomesDistintos, each prfx & _)
    in
        nomesPrefixados
