let
    // =========================================================
    // cfg_projeto
    // Configuração global do projeto (EFD + NFe)
    // Lê "Named Ranges" da planilha (ex.: Config) via Excel.CurrentWorkbook()
    // =========================================================
    //Helpers
    fnGetNamedRangeValue = (nm as text) as any =>
        let
            t = try Excel.CurrentWorkbook(){[Name = nm]}[Content] otherwise null,
            v = if t = null then null else try Record.Field(t{0}, Table.ColumnNames(t){0}) otherwise null
        in
            v,
    fnToLogical = (v as any) as nullable logical =>
        let
            out =
                if v = null then
                    null
                else if Value.Is(v, type logical) then
                    v
                else
                    let
                        s = Text.Upper(Text.Trim(Text.From(v)))
                    in
                        if s = "VERDADEIRO" or s = "TRUE" or s = "1" then
                            true
                        else if s = "FALSO" or s = "FALSE" or s = "0" then
                            false
                        else
                            null
        in
            out,
    fnToTextTrim = (v as any) as nullable text => let out = if v = null then null else Text.Trim(Text.From(v)) in out,
    fnEnsureTrailingSlash = (p as nullable text) as nullable text =>
        let
            out = if p = null then null else if Text.End(p, 1) = "\" or Text.End(p, 1) = "/" then p else p & "\"
        in
            out,
    // Lendo as Células nomeadas
    pathEFD = fnEnsureTrailingSlash(fnToTextTrim(fnGetNamedRangeValue("pathEFD"))),
    enableImportEFD = fnToLogical(fnGetNamedRangeValue("enableImportEFD")),
    pathNFeRecebida = fnEnsureTrailingSlash(fnToTextTrim(fnGetNamedRangeValue("pathNFeRecebida"))),
    enableImportNFeRecebida = fnToLogical(fnGetNamedRangeValue("enableImportNFeRecebida")),
    pathNFeExpedida = fnEnsureTrailingSlash(fnToTextTrim(fnGetNamedRangeValue("pathNFeExpedida"))),
    enableImportNFeExpedida = fnToLogical(fnGetNamedRangeValue("enableImportNFeExpedida")),
    // Tabela normalizada de pastas (útil para consultas subsequentes)
    Pastas = #table(
        type table [PastaTipo = text, PastaPath = nullable text, Importar = nullable logical],
        {
            {"EFD", pathEFD, enableImportEFD},
            {"Expedida", pathNFeExpedida, enableImportNFeExpedida},
            {"Recebida", pathNFeRecebida, enableImportNFeRecebida}
        }
    ),
    // Registro de saída (configuração global)
    Out = [
        Pastas = Pastas
    ]
in
    Out
