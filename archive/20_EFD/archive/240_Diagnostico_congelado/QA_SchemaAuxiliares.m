let
    Dominios = schemaDominiosAuxiliares,
    Projecoes = schemaProjecoesAuxiliares,
    Campos = schemaCamposLayoutAuxiliares,
    Fontes = schemaFontesAuxiliares,
    EstruturaErro = type table [Tipo = text, Chave = text, Erro = text],
    ErrosProjecoesSemDominio =
        Table.FromRecords(
            List.Transform(
                Table.ToRecords(
                    Table.SelectRows(Projecoes, each not List.Contains(Dominios[Dominio], [Dominio]))
                ),
                each [Tipo = "schemaProjecoesAuxiliares", Chave = _[Dominio], Erro = "Dominio ausente em schemaDominiosAuxiliares"]
            ),
            EstruturaErro
        ),
    ErrosCamposSemDominio =
        Table.FromRecords(
            List.Transform(
                Table.ToRecords(
                    Table.SelectRows(Campos, each not List.Contains(Dominios[Dominio], [Dominio]))
                ),
                each [Tipo = "schemaCamposLayoutAuxiliares", Chave = _[RegistroOuGrupo] & "." & _[Campo], Erro = "Dominio ausente em schemaDominiosAuxiliares"]
            ),
            EstruturaErro
        ),
    ErrosFontesSemProjecao =
        Table.FromRecords(
            List.Transform(
                Table.ToRecords(
                    Table.SelectRows(Fontes, each not List.Contains(Projecoes[TabelaFisica], [QueryDestino]))
                ),
                each [Tipo = "schemaFontesAuxiliares", Chave = _[Tabela], Erro = "QueryDestino nao encontrado em schemaProjecoesAuxiliares[TabelaFisica]"]
            ),
            EstruturaErro
        ),
    ErrosCanonicaDivergente =
        Table.FromRecords(
            List.Transform(
                Table.ToRecords(
                    Table.SelectRows(
                        Projecoes,
                        each
                            let
                                LinhaDominio = try Table.SelectRows(Dominios, (d) => d[Dominio] = [Dominio]){0} otherwise null
                            in
                                LinhaDominio <> null and LinhaDominio[TabelaCanonica] <> [TabelaCanonica]
                    )
                ),
                each [Tipo = "schemaProjecoesAuxiliares", Chave = _[Dominio], Erro = "TabelaCanonica divergente do schemaDominiosAuxiliares"]
            ),
            EstruturaErro
        ),
    Erros =
        Table.Combine(
            {
                ErrosProjecoesSemDominio,
                ErrosCamposSemDominio,
                ErrosFontesSemProjecao,
                ErrosCanonicaDivergente
            }
        )
in
    Erros

