(tabela as table) =>
    let
        ColunasComTabelas = fnColunaContemTabela(tabela),
        ExecutaSomenteSeHaTabelasExplodir =
            if List.IsEmpty(ColunasComTabelas) then
                tabela
            else
                (
                    let
                        ColunaPassagemAtual = ColunasComTabelas{0},
                        ColunaTratar = Table.Column(tabela, ColunaPassagemAtual),
                        ColunasExpandir = fnNomeCamposSubTabela(ColunaTratar),
                        ColunasExpandirPrefixadas = fnNomeCamposSubTabela(ColunaTratar, ColunaPassagemAtual),
                        ColunasExpandidas =
                            if List.IsEmpty(ColunasExpandir) then
                                tabela
                            else
                                Table.ExpandTableColumn(
                                    tabela, ColunaPassagemAtual, ColunasExpandir, ColunasExpandirPrefixadas
                                ),
                        ListaColunasTratarEstaVazia = List.IsEmpty(fnColunaContemTabela(ColunasExpandidas)),
                        out = if ListaColunasTratarEstaVazia then ColunasExpandidas else @fnExplodeXML(
                            ColunasExpandidas
                        )
                    in
                        out
                )
    in
        ExecutaSomenteSeHaTabelasExplodir
