(xmlTable as table, optional layoutIn as nullable record) as record =>
    let
        layout = if layoutIn = null then LAYOUT_NFE_BASE else layoutIn,
        fields = List.Buffer(Record.FieldOrDefault(layout, "Fields", {})),
        derivados = List.Buffer(Record.FieldOrDefault(layout, "Derivados", {})),
        aliasesCampos = List.Buffer(List.Transform(fields, each _[Alias])),
        aliasesDerivados = List.Buffer(List.Transform(derivados, each _[Name])),
        colunas = List.Buffer(aliasesCampos & aliasesDerivados),
        recNulo = Record.FromList(List.Repeat({null}, List.Count(colunas)), colunas),
        fnSet = (r as record, nome as text, valor as any) as record => Record.Combine({r, Record.FromList({valor}, {nome})}),
        fnValorPath = (linhaRec as any, path as list) as any =>
            let
                pathCount = List.Count(path)
            in
                if linhaRec = null then
                    null
                else if pathCount = 0 then
                    linhaRec
                else if pathCount = 1 and Value.Is(linhaRec, type record) then
                    Record.FieldOrDefault(linhaRec, Text.From(path{0}), null)
                else
                    fnGetNestedValue(linhaRec, path),
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
        recBasico =
            if List.IsEmpty(aliasesCampos) then
                []
            else
                Record.FromList(
                    List.Transform(
                        fields,
                        each fnParseKind(fnValorPath(linha, _[Path]), _[Kind])
                    ),
                    aliasesCampos
                ),
        basico = Record.Combine({recNulo, recBasico}),
        final = List.Accumulate(
            derivados,
            basico,
            (state, current) => fnSet(state, current[Name], try current[Fn](state) otherwise null)
        )
    in
        final
