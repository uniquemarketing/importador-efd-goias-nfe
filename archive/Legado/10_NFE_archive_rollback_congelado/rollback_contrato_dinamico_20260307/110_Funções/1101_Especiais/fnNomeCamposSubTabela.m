(ColunaDaTabela as list, optional Prefixo as text) =>
    let
        prfx = if Prefixo = null then "" else Prefixo & ".",
        SomenteTabelas = List.Select(ColunaDaTabela, each _ is table),
        ListaNomesColuna = List.Transform(SomenteTabelas, each Table.ColumnNames(_)),
        CombinaRemoveDuplicatas = if List.IsEmpty(ListaNomesColuna) then {} else List.Union(ListaNomesColuna),
        Prefixa = List.Transform(CombinaRemoveDuplicatas, each prfx & _)
    in
        Prefixa
