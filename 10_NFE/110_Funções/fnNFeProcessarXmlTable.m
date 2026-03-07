(xmlTable as table) as table =>
    let
        xmlRoot = xmlTable{0},
        fnProcessarLayout = (layout as record, nodeContext as any) =>
            let
                targetNode = fnGetNestedValue(nodeContext, Record.FieldOrDefault(layout, "RootPath", {})),
                fnExtrairLinha = (linha) =>
                    let
                        // Extrai e converte cada campo individualmente
                        camposBasicos = List.Accumulate(
                            layout[Fields],
                            [],
                            (state, current) =>
                                let
                                    valorRaw = fnGetNestedValue(linha, current[Path]),
                                    valorConvertido = fnParseKind(valorRaw, current[Kind])
                                in
                                    Record.AddField(state, current[Alias], valorConvertido)
                        ),
                        listaDerivados = Record.FieldOrDefault(layout, "Derivados", {}),
                        camposFinais = List.Accumulate(
                            listaDerivados,
                            camposBasicos,
                            (state, current) =>
                                Record.AddField(state, current[Name], try current[Fn](state) otherwise null)
                        )
                    in
                        camposFinais,
                resultado =
                    if targetNode = null then
                        if layout[Multiplicidade] = "1:1" then
                            fnExtrairLinha([])
                        else
                            {}
                    else if layout[Multiplicidade] = "1:1" then
                        fnExtrairLinha(
                            if Value.Is(targetNode, type table) then try targetNode{0} otherwise [] else targetNode
                        )
                    else
                        let
                            tabelaAlvo =
                                if Value.Is(targetNode, type table) then
                                    targetNode
                                else
                                    Table.FromRecords({targetNode})
                        in
                            Table.TransformRows(tabelaAlvo, each fnExtrairLinha(_))
            in
                resultado,
        // Execução: Cabeçalho
        BaseData = fnProcessarLayout(LAYOUT_NFE_BASE, xmlRoot),
        // Execução: Itens
        TabelaItensNode = fnGetNestedValue(xmlRoot, {"NFe", "infNFe", "det"}),
        TabelaItens =
            if TabelaItensNode = null then
                Table.FromRecords({})
            else if Value.Is(TabelaItensNode, type table) then
                TabelaItensNode
            else
                Table.FromRecords({TabelaItensNode}),
        ProcessarLinhas = Table.AddColumn(
            TabelaItens,
            "DadosFinal",
            (linhaAtual) =>
                let
                    LayoutProdAdaptado = Record.Combine({LAYOUT_NFE_PROD, [RootPath = {}, Multiplicidade = "1:1"]}),
                    ProdData = fnProcessarLayout(LayoutProdAdaptado, linhaAtual),
                    // ICMS Dinâmico e Blindado
                    impostoNode = fnGetNestedValue(linhaAtual, {"imposto", "ICMS"}),
                    IcmsData = fnScanAndRenameICMS(impostoNode, LAYOUT_NFE_PROD[ICMS_Layout])
                in
                    Record.Combine({BaseData, ProdData, IcmsData})
        )
    in
        if Table.RowCount(ProcessarLinhas) = 0 then
            #table({}, {})
        else
            Table.FromRecords(ProcessarLinhas[DadosFinal])
