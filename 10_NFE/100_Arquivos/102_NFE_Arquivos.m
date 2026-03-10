let
    Fonte = #"101_xml_Arquivos_All",
    // Helper: extrai dhEmi/dEmi por leitura parcial de texto (evita Xml.Tables em massa aqui).
    fnDataEmitNfeFromPath = (fullPath as text) as nullable datetime =>
        let
            bin = try File.Contents(fullPath) otherwise null,
            headBin = if bin = null then null else try Binary.Range(bin, 0, 262144) otherwise null,
            headTxtUtf8 = if headBin = null then null else try Text.FromBinary(headBin, TextEncoding.Utf8) otherwise null,
            headTxtAnsi = if headTxtUtf8 = null and headBin <> null then try Text.FromBinary(headBin, 1252) otherwise null else headTxtUtf8,
            txt = if headTxtAnsi = null then "" else headTxtAnsi,
            dhEmiTxt =
                let
                    a = try Text.Trim(Text.BetweenDelimiters(txt, "<dhEmi>", "</dhEmi>")) otherwise null,
                    b = try Text.Trim(Text.BetweenDelimiters(txt, "<dEmi>", "</dEmi>")) otherwise null
                in
                    if a <> null and a <> "" then a else if b <> null and b <> "" then b else null,
            // Parse robusto: dhEmi costuma vir ISO com timezone; dEmi costuma vir date.
            dt =
                try
                    if dhEmiTxt = null then
                        null
                    else
                        let
                            z = DateTimeZone.FromText(dhEmiTxt), noZone = DateTimeZone.RemoveZone(z)
                        in
                            noZone
                    otherwise try if dhEmiTxt = null then null else DateTime.FromText(dhEmiTxt) otherwise null
        in
            dt,
    Filtra = Table.SelectRows(Fonte, each (try [TipoArquivo] otherwise null) = "NFe"),
    AddDhEmi = Table.AddColumn(Filtra, "dhEmi", each fnDataEmitNfeFromPath([FullPath]), type datetime),
    // Ordenação fiscal: mais antiga primeiro
    Sort = Table.Sort(AddDhEmi, {{"dhEmi", Order.Ascending}, {"FullPath", Order.Ascending}}),
    // PK técnica cronológica
    AddNfeId = Table.AddIndexColumn(Sort, "nfe_id", 1, 1, Int64.Type)
in
    AddNfeId
