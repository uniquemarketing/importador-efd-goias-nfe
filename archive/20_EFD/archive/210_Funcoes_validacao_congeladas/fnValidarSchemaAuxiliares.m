(Schema as table) as table =>
let
    // espera colunas: Tabela, Coluna, Tipo, Chave, Nullable, Descricao (Descricao opcional)
    Schema2 =
        Table.TransformColumnTypes(
            Schema,
            {
                {"Tabela", type text},
                {"Coluna", type text},
                {"Tipo", type text},
                {"Chave", type text},
                {"Nullable", type logical}
            },
            "pt-BR"
        ),

    // lista tabelas distintas citadas no schema
    Tabelas = List.Distinct(Schema2[Tabela]),

    // para cada tabela, pega a lista real de colunas via #shared
    CheckPorTabela =
        List.Transform(
            Tabelas,
            (t as text) =>
                let
                    obj = try Record.Field(#shared, t) otherwise null,
                    isTable = obj <> null and Value.Is(obj, type table),
                    colsReais = if isTable then Table.ColumnNames(obj) else {},
                    // schema esperado daquela tabela
                    schT = Table.SelectRows(Schema2, each [Tabela] = t),
                    // valida existência das colunas
                    add =
                        Table.AddColumn(
                            schT,
                            "ExisteNaTabela",
                            each List.Contains(colsReais, [Coluna]),
                            type logical
                        ),
                    // marca erro quando tabela não existe ou coluna não existe
                    add2 =
                        Table.AddColumn(
                            add,
                            "Erro",
                            each
                                if not isTable then "Tabela não existe no contexto: " & t
                                else if [ExisteNaTabela] <> true then "Coluna não existe na tabela"
                                else null,
                            type text
                        )
                in
                    add2
        ),

    Unificado = Table.Combine(CheckPorTabela),
    ApenasErros = Table.SelectRows(Unificado, each [Erro] <> null)
in
    ApenasErros

