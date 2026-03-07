(obj as any, path as list) as any =>
    let
        out = List.Accumulate(
            path,
            obj,
            (state as any, current as any) =>
                let
                    // Se for Tabela, pega a linha 0. Se for nulo, mantém nulo.
                    estadoAtual = if Value.Is(state, type table) then try state{0} otherwise null else state
                in
                    if estadoAtual <> null and Value.Is(estadoAtual, type record) then
                        Record.FieldOrDefault(estadoAtual, Text.From(current), null)
                    else
                        null
        )
    in
        out
