(xmlTable as table, optional layoutIn as nullable record) as record =>
    let
        layout = if layoutIn = null then LAYOUT_NFE_BASE else layoutIn,
        fields = List.Buffer(Record.FieldOrDefault(layout, "Fields", {})),
        derivados = List.Buffer(Record.FieldOrDefault(layout, "Derivados", {})),
        colunas = List.Buffer(List.Transform(fields, each _[Alias]) & List.Transform(derivados, each _[Name])),
        recNulo = Record.FromList(List.Repeat({null}, List.Count(colunas)), colunas),
        fnSet = (r as record, nome as text, valor as any) as record => Record.Combine({r, Record.FromList({valor}, {nome})}),
        xmlRoot = try xmlTable{0} otherwise null,
        targetNode =
            if xmlRoot = null then
                null
            else
                fnGetNestedValue(xmlRoot, Record.FieldOrDefault(layout, "RootPath", {})),
        linha =
            if targetNode = null then
                []
            else if Value.Is(targetNode, type table) then
                try targetNode{0} otherwise []
            else
                targetNode,
        basico = List.Accumulate(
            fields,
            recNulo,
            (state, current) =>
                let
                    valorRaw = fnGetNestedValue(linha, current[Path]),
                    valorConvertido = fnParseKind(valorRaw, current[Kind])
                in
                    fnSet(state, current[Alias], valorConvertido)
        ),
        final = List.Accumulate(
            derivados,
            basico,
            (state, current) => fnSet(state, current[Name], try current[Fn](state) otherwise null)
        )
    in
        final
