(xmlTable as table) as table =>
    let
        xmlRoot = try xmlTable{0} otherwise null,
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
        fnProcessarLayout = (layout as record, nodeContext as any) as any =>
            let
                rootPath = Record.FieldOrDefault(layout, "RootPath", {}),
                multiplicidade = Record.FieldOrDefault(layout, "Multiplicidade", "1:1"),
                fields = List.Buffer(Record.FieldOrDefault(layout, "Fields", {})),
                derivados = List.Buffer(Record.FieldOrDefault(layout, "Derivados", {})),
                aliases = List.Buffer(List.Transform(fields, each _[Alias])),
                targetNode = fnGetNestedValue(nodeContext, rootPath),
                fnExtrairLinha = (linha as any) as record =>
                    let
                        linhaRec =
                            if Value.Is(linha, type record) then
                                linha
                            else if Value.Is(linha, type table) then
                                try linha{0} otherwise []
                            else
                                [],
                        valoresBasicos =
                            List.Transform(
                                fields,
                                each fnParseKind(fnValorPath(linhaRec, _[Path]), _[Kind])
                            ),
                        camposBasicos =
                            if List.IsEmpty(aliases) then
                                []
                            else
                                Record.FromList(valoresBasicos, aliases),
                        camposFinais =
                            List.Accumulate(
                                derivados,
                                camposBasicos,
                                (state as record, current as record) =>
                                    Record.AddField(state, current[Name], try current[Fn](state) otherwise null)
                            )
                    in
                        camposFinais,
                resultado =
                    if targetNode = null then
                        if multiplicidade = "1:1" then
                            fnExtrairLinha([])
                        else
                            {}
                    else if multiplicidade = "1:1" then
                        fnExtrairLinha(
                            if Value.Is(targetNode, type table) then try targetNode{0} otherwise [] else targetNode
                        )
                    else
                        let
                            tabelaAlvo =
                                if Value.Is(targetNode, type table) then
                                    targetNode
                                else if Value.Is(targetNode, type record) then
                                    Table.FromRecords({targetNode})
                                else
                                    #table({}, {})
                        in
                            Table.TransformRows(tabelaAlvo, each fnExtrairLinha(_))
            in
                resultado,
        BaseData =
            if xmlRoot = null then
                []
            else
                fnProcessarLayout(LAYOUT_NFE_BASE, xmlRoot),
        TabelaItensNode =
            if xmlRoot = null then
                null
            else
                fnGetNestedValue(xmlRoot, {"NFe", "infNFe", "det"}),
        TabelaItens =
            if TabelaItensNode = null then
                #table({}, {})
            else if Value.Is(TabelaItensNode, type table) then
                TabelaItensNode
            else if Value.Is(TabelaItensNode, type record) then
                Table.FromRecords({TabelaItensNode})
            else
                #table({}, {}),
        LayoutProdAdaptado = Record.Combine({LAYOUT_NFE_PROD, [RootPath = {}, Multiplicidade = "1:1"]}),
        IcmsLayout = LAYOUT_NFE_PROD[ICMS_Layout],
        RegistrosProcessados =
            Table.TransformRows(
                TabelaItens,
                (linhaAtual as record) =>
                    let
                        ProdData = fnProcessarLayout(LayoutProdAdaptado, linhaAtual),
                        impostoNode = fnGetNestedValue(linhaAtual, {"imposto", "ICMS"}),
                        IcmsData = fnScanAndRenameICMS(impostoNode, IcmsLayout)
                    in
                        Record.Combine({BaseData, ProdData, IcmsData})
            )
    in
        if List.IsEmpty(RegistrosProcessados) then
            #table({}, {})
        else
            Table.FromRecords(RegistrosProcessados)
