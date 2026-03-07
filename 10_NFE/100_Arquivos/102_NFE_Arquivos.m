let
    Fonte = #"101_xml_Arquivos_All",
    // Helper
    fnDataEmitNfeFromXmlTable = (xmlTable as table) as nullable datetime =>
        let
            xmlRoot = try xmlTable{0} otherwise null,
            ideNode = if xmlRoot = null then null else fnGetNestedValue(xmlRoot, {"NFe", "infNFe", "ide"}),
            ideRec =
                if ideNode = null then
                    null
                else if Value.Is(ideNode, type table) then
                    try ideNode{0} otherwise null
                else if Value.Is(ideNode, type record) then
                    ideNode
                else
                    null,
            dhEmiTxt =
                if ideRec = null then
                    null
                else
                    let
                        a = try fnGetNestedValue(ideRec, {"dhEmi"}) otherwise null,
                        b = try fnGetNestedValue(ideRec, {"dEmi"}) otherwise null
                    in
                        if a <> null and Text.Trim(Text.From(a)) <> "" then
                            Text.From(a)
                        else if b <> null and Text.Trim(Text.From(b)) <> "" then
                            Text.From(b)
                        else
                            null,
            // Parse robusto: dhEmi costuma vir ISO com timezone.
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
    AddXmlTable = Table.AddColumn(
        Filtra,
        "XmlTable",
        each try Xml.Tables(File.Contents([FullPath])) otherwise #table({}, {}),
        type table
    ),
    AddDhEmi = Table.AddColumn(AddXmlTable, "dhEmi", each fnDataEmitNfeFromXmlTable([XmlTable]), type datetime),
    // Ordenação fiscal: mais antiga primeiro
    Sort = Table.Sort(AddDhEmi, {{"dhEmi", Order.Ascending}, {"FullPath", Order.Ascending}}),
    // PK técnica cronológica
    AddNfeId = Table.AddIndexColumn(Sort, "nfe_id", 1, 1, Int64.Type)
in
    AddNfeId
