let
    Cfg = Config,
    PastasRaw =
        let
            EmptyPastas = #table(type table [PastaTipo = text, PastaPath = nullable text, Importar = nullable logical], {}),
            PastasFromConfig =
                if Value.Is(Cfg, type table) then
                    Cfg
                else if Value.Is(Cfg, type record) then
                    try Cfg[Pastas] otherwise EmptyPastas
                else
                    EmptyPastas,
            NormalizedPastas = try
                Table.SelectColumns(PastasFromConfig, {"PastaTipo", "PastaPath", "Importar"}, MissingField.UseNull)
            otherwise
                EmptyPastas
        in
            NormalizedPastas,
    PastasEFD = Table.SelectRows(
        PastasRaw,
        each
            let
                tipo = try Text.Upper(Text.Trim(Text.From([PastaTipo]))) otherwise "",
                importar = try [Importar] otherwise false,
                path = try Text.Trim(Text.From([PastaPath])) otherwise ""
            in
                tipo = "EFD" and importar = true and path <> ""
    ),
    EFDPath = try Text.From(PastasEFD{0}[PastaPath]) otherwise null,
    EmptyFolderFiles = #table(
        type table [
            Content = binary,
            Name = text,
            Extension = text,
            #"Date accessed" = nullable datetime,
            #"Date modified" = nullable datetime,
            #"Date created" = nullable datetime,
            Attributes = record,
            #"Folder Path" = text
        ],
        {}
    ),
    Source = if EFDPath = null then EmptyFolderFiles else try Folder.Files(EFDPath) otherwise EmptyFolderFiles,
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

