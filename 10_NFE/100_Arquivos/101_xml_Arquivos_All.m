let
    // ============================================================
    // xml_Arquivos_All (enxuto, mas COM XmlTable)
    // Saída:
    //   PastaTipo, PastaPath, Name, FullPath, TipoArquivo, XmlTable
    // ============================================================
    // Helper
    fnTipoFromXmlTable = (xmlTable as table) as text =>
        let
            // Se tabela vazia → desconhecido
            Tipo =
                if xmlTable = null or Table.IsEmpty(xmlTable) then
                    "Desconhecido"
                else
                    let
                        cols = Table.ColumnNames(xmlTable),
                        HasNFe = List.Contains(List.Transform(cols, each Text.Lower(_)), "nfe"),
                        HasEvento = List.Contains(List.Transform(cols, each Text.Lower(_)), "evento")
                    in
                        if HasNFe then
                            "NFe"
                        else if HasEvento then
                            "Evento"
                        else
                            "Desconhecido"
        in
            Tipo,
    Cfg = Config,
    PastasRaw = try Cfg[Pastas] otherwise #table({"PastaTipo", "Importar", "PastaPath"}, {}),
    PastasFiltradas = Table.SelectRows(
        PastasRaw,
        each
            (try [Importar] otherwise false) = true
            and (try [PastaPath] otherwise null) <> null
            and Text.Trim(Text.From([PastaPath])) <> ""
    ),
    AddFiles = Table.AddColumn(
        PastasFiltradas,
        "Files",
        (r as record) as table =>
            let
                p = r[PastaPath],
                t = try Folder.Files(p) otherwise #table({}, {}),
                tXml =
                    if Table.IsEmpty(t) then
                        t
                    else
                        Table.SelectRows(t, each Text.Lower(Text.From([Extension])) = ".xml")
            in
                tXml,
        type table
    ),
    // Expande só o Name (Folder Path fica redundante nesse desenho)
    ExpandFiles = Table.ExpandTableColumn(AddFiles, "Files", {"Name"}, {"Name"}),
    // FullPath baseado no PastaPath (contrato do sistema)
    AddFullPath = Table.AddColumn(ExpandFiles, "FullPath", each Text.From([PastaPath]) & Text.From([Name]), type text),
    // XmlTable (mantido por requisito)
    AddXmlTable = Table.AddColumn(
        AddFullPath,
        "XmlTable",
        each
            let
                bin = try Binary.Buffer(File.Contents([FullPath])) otherwise null,
                xt = try if bin = null then #table({}, {}) else Xml.Tables(bin) otherwise #table({}, {})
            in
                xt,
        type table
    ),
    AddTipo = Table.AddColumn(AddXmlTable, "TipoArquivo", each fnTipoFromXmlTable([XmlTable]), type text),
    Final = Table.SelectColumns(AddTipo, {"PastaTipo", "Name", "FullPath", "TipoArquivo", "XmlTable"})
in
    Final
