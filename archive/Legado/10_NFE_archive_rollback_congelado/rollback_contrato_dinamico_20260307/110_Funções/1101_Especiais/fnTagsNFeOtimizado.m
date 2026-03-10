(xml as any) as list =>
    let
        EstadoInicial = [Fila = {[Caminho = "", Valor = xml]}, Tags = {}],
        Iteracoes = List.Generate(
            () => EstadoInicial,
            each not List.IsEmpty([Fila]),
            each
                let
                    atual = [Fila]{0},
                    restante = List.RemoveFirstN([Fila], 1),
                    valorAtual = atual[Valor],
                    caminhoAtual = atual[Caminho],
                    nomesDiretos = fnNomeTodosCampos(valorAtual),
                    tagsDiretas = List.Transform(
                        nomesDiretos, each if caminhoAtual = "" then _ else caminhoAtual & "." & _
                    ),
                    filhos =
                        if Value.Is(valorAtual, type table) then
                            let
                                tb = Table.Buffer(valorAtual),
                                colunas = fnNomeTodosCampos(tb),
                                porColuna = List.Transform(
                                    colunas,
                                    (c) =>
                                        let
                                            valoresColuna = List.Buffer(Table.Column(tb, c)),
                                            itensComplexos = List.Select(
                                                valoresColuna,
                                                each Value.Is(_, type table) or Value.Is(_, type record) or Value.Is(_, type list)
                                            ),
                                            caminhoFilho = if caminhoAtual = "" then c else caminhoAtual & "." & c
                                        in
                                            List.Transform(itensComplexos, each [Caminho = caminhoFilho, Valor = _])
                                )
                            in
                                List.Combine(porColuna)
                        else if Value.Is(valorAtual, type record) then
                            let
                                campos = fnNomeTodosCampos(valorAtual),
                                porCampo = List.Transform(
                                    campos,
                                    (c) =>
                                        let
                                            v = Record.FieldOrDefault(valorAtual, c, null),
                                            caminhoFilho = if caminhoAtual = "" then c else caminhoAtual & "." & c
                                        in
                                            if Value.Is(v, type table) or Value.Is(v, type record) or Value.Is(v, type list) then
                                                {[Caminho = caminhoFilho, Valor = v]}
                                            else
                                                {}
                                )
                            in
                                List.Combine(porCampo)
                        else if Value.Is(valorAtual, type list) then
                            let
                                lista = List.Buffer(valorAtual),
                                itensComplexos = List.Select(
                                    lista, each Value.Is(_, type table) or Value.Is(_, type record) or Value.Is(_, type list)
                                )
                            in
                                List.Transform(itensComplexos, each [Caminho = caminhoAtual, Valor = _])
                        else
                            {},
                    novaFila = List.Buffer(List.Combine({restante, filhos})),
                    tagsAtualizadas = List.Buffer(List.Distinct(List.Combine({[Tags], tagsDiretas})))
                in
                    [Fila = novaFila, Tags = tagsAtualizadas],
            each [Tags]
        ),
        tagsFinais = if List.IsEmpty(Iteracoes) then {} else List.Last(Iteracoes),
        resultado = List.Sort(List.Distinct(tagsFinais), Order.Ascending)
    in
        resultado
