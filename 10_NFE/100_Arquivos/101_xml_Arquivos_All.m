let
    // ============================================================
    // xml_Arquivos_All (enxuto e sem parse completo de XML)
    // Saída:
    //   PastaTipo, Name, FullPath, TipoArquivo
    // ============================================================
    // Helper
    fnTipoFromPath = (fullPath as text) as text =>
        let
            bin = try File.Contents(fullPath) otherwise null,
            headBin = if bin = null then null else try Binary.Range(bin, 0, 65536) otherwise null,
            headTxtUtf8 = if headBin = null then null else try Text.FromBinary(headBin, TextEncoding.Utf8) otherwise null,
            headTxtAnsi = if headTxtUtf8 = null and headBin <> null then try Text.FromBinary(headBin, 1252) otherwise null else headTxtUtf8,
            s = Text.Lower(if headTxtAnsi = null then "" else headTxtAnsi),
            Tipo =
                if Text.Contains(s, "<nfeproc") or Text.Contains(s, "<nfe ") or Text.Contains(s, "<nfe>") then
                    "NFe"
                else if Text.Contains(s, "<proceventonfe") or Text.Contains(s, "<evento") then
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
    AddTipo = Table.AddColumn(AddFullPath, "TipoArquivo", each fnTipoFromPath([FullPath]), type text),
    Final = Table.SelectColumns(AddTipo, {"PastaTipo", "Name", "FullPath", "TipoArquivo"})
in
    Final
