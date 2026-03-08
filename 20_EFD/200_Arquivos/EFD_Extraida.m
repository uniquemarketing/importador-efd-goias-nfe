let
    FolderPath =

        let
            rngTry = try Excel.CurrentWorkbook(){[Name="patch_EFD"]}[Content] otherwise null,
            raw = if rngTry = null then null else try Text.From(rngTry{0}[Column1]) otherwise null,
            v = if raw = null then null else Text.Trim(raw),
            path =
                if v = null or v = "" then
                    error "Configuração ausente: preencha o named range 'rngFolderEFD' com o caminho da pasta dos arquivos SPED."
                else if Text.EndsWith(v, "\") then
                    v
                else
                    v & "\"
        in
            path,

    Source = Folder.Files(FolderPath),

    OnlyTxt = Table.SelectRows(Source, each Text.Lower([Extension]) = ".txt"),

    DuplicateColumnName = Table.DuplicateColumn(OnlyTxt, "Name", "Nome"),

   CombineColumnsPaths = Table.CombineColumns(DuplicateColumnName,{"Folder Path", "Name"},Combiner.CombineTextByDelimiter("", QuoteStyle.None),"Paths"),

    SelectColumnsNomePath = Table.SelectColumns(CombineColumnsPaths,{"Nome", "Paths"}),

    // Blindagem de CPU: Força o processamento do arquivo de forma isolada e trava o resultado tabular na memória
    AddCustomColumnColunaTabelasSped = Table.AddColumn(SelectColumnsNomePath, "ColunaTabelasSped", each Table.Buffer(fnSPEDTabela([Paths]))),

    // 1) Extrai a dataInicial da tabela aninhada (1x por arquivo)
    AddDataInicialArquivo =
        Table.AddColumn(
            AddCustomColumnColunaTabelasSped,
            "dataInicialArquivo",
            (r as record) as nullable date =>
                let
                    t = r[ColunaTabelasSped],
                    d = try List.First(List.RemoveNulls(t[DataInicial])) otherwise null
                in
                    d,
            type date
        ),

    // 2) Ordena os arquivos por essa data
    Ordenado =
        Table.Sort(AddDataInicialArquivo, {{"dataInicialArquivo", Order.Ascending}}),

    AddArquivoId = Table.AddIndexColumn(Ordenado, "ArquivoId", 1, 1, Int64.Type),

    

    RemoveColunas = Table.SelectColumns(AddArquivoId,{"Nome", "ArquivoId", "ColunaTabelasSped"}),

    // 3. EXPANDE TRAZENDO AS COLUNAS DE HIERARQUIA
    Expande = Table.ExpandTableColumn(
        RemoveColunas,
        "ColunaTabelasSped",
        {"LinhaId", "Linha_Pai", "Periodo", "Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8", "Column9", "Column10", "Column11", "Column12", "Column13", "Column14", "Column15", "Column16", "Column17", "Column18", "Column19", "Column20", "Column21", "Column22", "Column23", "Column24", "Column25", "Column26", "Column27", "Column28", "Column29", "Column30", "Column31", "Column32", "Column33", "Column34", "Column35", "Column36", "Column37", "Column38", "Column39", "Column40"},
        {"LinhaId", "Linha_Pai", "Periodo", "C001", "C002", "C003", "C004", "C005", "C006", "C007", "C008", "C009", "C010", "C011", "C012", "C013", "C014", "C015", "C016", "C017", "C018", "C019", "C020", "C021", "C022", "C023", "C024", "C025", "C026", "C027", "C028", "C029", "C030", "C031", "C032", "C033", "C034", "C035", "C036", "C037", "C038", "C039"}
    ),
    
    AlteraTipo = Table.TransformColumnTypes(Expande,{{"LinhaId", Int64.Type}, {"Linha_Pai", Int64.Type}}),

    // =================================================================
    // 4. A FABRICAÇÃO DAS CHAVES RELACIONAIS
    // =================================================================
    
    // -> Chave Primária (Primary Key): ID do Arquivo + ID da Linha
    AdicionaChaveLinha = Table.AddColumn(AlteraTipo, "Chave_Linha", each Text.From([ArquivoId]) & "-" & Text.From([LinhaId]), type text),
    
    // -> Chave Estrangeira (Foreign Key): ID do Arquivo + ID da Linha do Pai
    AdicionaChavePai = Table.AddColumn(AdicionaChaveLinha, "Chave_Pai", each if [Linha_Pai] <> null then Text.From([ArquivoId]) & "-" & Text.From([Linha_Pai]) else null, type text),
    
  // ... restante do código acima ...
    // 5. LIMPEZA FINAL
    RemoveTemporarias = Table.RemoveColumns(AdicionaChavePai,{"Linha_Pai"}),
    Reordena01 = Table.ReorderColumns(RemoveTemporarias,{"Nome", "Periodo", "ArquivoId", "LinhaId", "Chave_Linha", "Chave_Pai", "C001", "C002", "C003", "C004", "C005", "C006", "C007", "C008", "C009", "C010", "C011", "C012", "C013", "C014", "C015", "C016", "C017", "C018", "C019", "C020", "C021", "C022", "C023", "C024", "C025", "C026", "C027", "C028", "C029", "C030", "C031", "C032", "C033", "C034", "C035", "C036", "C037", "C038", "C039"}),

    // =================================================================
    // 6. BLINDAGEM CONTRA N+1 (COMPARTILHAMENTO DE CACHE)
    // =================================================================
    // Força o Mashup Engine a ler os 50 arquivos UMA única vez.
    // As tabelas R0000, R0150, etc., lerão instantaneamente desta RAM.
    Staging_Na_Memoria = Reordena01
in
    Staging_Na_Memoria

