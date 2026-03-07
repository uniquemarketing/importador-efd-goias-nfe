let
    Fonte = #"NFE_Totais",
    FonteBuffered = Table.Buffer(Fonte),
    TotalLinhas = Table.RowCount(FonteBuffered),
    NomesColunas = Table.ColumnNames(FonteBuffered),
    DiagnosticoColunas = Table.FromRecords(
        List.Transform(
            NomesColunas,
            (nomeColuna) =>
                let
                    valoresColuna = List.Buffer(Table.Column(FonteBuffered, nomeColuna)),
                    qtNulos = List.Count(List.Select(valoresColuna, each _ = null)),
                    qtNaoNulos = List.Count(List.RemoveNulls(valoresColuna)),
                    pctNulos = if TotalLinhas = 0 then null else Number.From(qtNulos) / Number.From(TotalLinhas)
                in
                    [
                        Coluna = nomeColuna,
                        Linhas = TotalLinhas,
                        Nulos = qtNulos,
                        NaoNulos = qtNaoNulos,
                        PctNulos = pctNulos,
                        ColunaTotalmenteNula = if TotalLinhas = 0 then false else qtNulos = TotalLinhas
                    ]
        )
    ),
    QtColunasTotalmenteNulas = List.Count(
        Table.SelectRows(DiagnosticoColunas, each [ColunaTotalmenteNula] = true)[Coluna]
    ),
    Resumo = #table(
        {"Metrica", "Valor"},
        {
            {"Tabela", "NFE_Totais"},
            {"TotalLinhas", Number.From(TotalLinhas)},
            {"TotalColunas", Number.From(List.Count(NomesColunas))},
            {"Colunas100PctNulas", Number.From(QtColunasTotalmenteNulas)},
            {
                "PctColunas100PctNulas",
                if List.Count(NomesColunas) = 0 then
                    null
                else
                    Number.From(QtColunasTotalmenteNulas) / Number.From(List.Count(NomesColunas))
            }
        }
    ),
    Resultado = [Resumo = Resumo, Colunas = DiagnosticoColunas]
in
    Resultado
