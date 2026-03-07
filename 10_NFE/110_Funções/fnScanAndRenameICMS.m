(impostoNode as any, layoutICMS as list) as record =>
    let
        // Se o nó vier como Table, extrai o primeiro Record
        input = if Value.Is(impostoNode, type table) then try impostoNode{0} otherwise [] else impostoNode,
        icmsTagNames = if input <> null and Value.Is(input, type record) then Record.FieldNames(input) else {},
        icmsContentRaw = if List.IsEmpty(icmsTagNames) then null else Record.Field(input, icmsTagNames{0}),
        // Scalarização da tag interna (ex: ICMS00)
        icmsContent =
            if Value.Is(icmsContentRaw, type table) then
                try icmsContentRaw{0} otherwise []
            else
                icmsContentRaw,
        camposExtraidos = List.Accumulate(
            layoutICMS,
            [],
            (state, current) =>
                let
                    valorRaw = if icmsContent = null then null else Record.FieldOrDefault(
                        icmsContent, current[Tag], null
                    ),
                    // Converte o valor do ICMS usando o Kind definido no layout
                    valorConvertido = fnParseKind(valorRaw, current[Kind])
                in
                    Record.AddField(state, current[Alias], valorConvertido)
        ),
        resultado = Record.AddField(
            camposExtraidos, "Tag de Origem ICMS", if List.IsEmpty(icmsTagNames) then
                "Não Encontrado"
            else
                icmsTagNames{0}
        )
    in
        resultado
