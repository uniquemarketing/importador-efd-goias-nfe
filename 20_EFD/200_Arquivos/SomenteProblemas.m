let
    FolderPath =
        let
            rngTry = try Excel.CurrentWorkbook(){[Name="patch_EFD"]}[Content] otherwise null,
            raw = if rngTry = null then null else try Text.From(rngTry{0}[Column1]) otherwise null,
            v = if raw = null then null else Text.Trim(raw),
            path = if Text.EndsWith(v, "\") then v else v & "\"
        in
            path,

    Source = Folder.Files(FolderPath),
    OnlyTxt = Table.SelectRows(Source, each Text.Lower([Extension]) = ".txt"),
    AddPaths = Table.AddColumn(OnlyTxt, "Paths", each [Folder Path] & [Name], type text),

    Teste =
        Table.AddColumn(
            AddPaths,
            "Retorno_fnSPEDTabela",
            each
                let
                    r = try fnSPEDTabela([Paths])
                in
                    if r[HasError] then
                        "ERRO: " & r[Error][Message]
                    else if Value.Is(r[Value], type table) then
                        "OK (table) - linhas=" & Text.From(Table.RowCount(r[Value]))
                    else
                        "RETORNO NÃO É TABELA: " & Text.From(r[Value]),
            type text
        ),

    SomenteProblemas = Table.SelectRows(Teste, each Text.StartsWith([Retorno_fnSPEDTabela], "ERRO") or Text.StartsWith([Retorno_fnSPEDTabela], "RETORNO NÃO É TABELA"))
in
    SomenteProblemas

