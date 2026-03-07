let
    Source = #"102_NFE_Arquivos",
    Base = Table.SelectColumns(Source, {"PastaTipo", "Name", "FullPath", "TipoArquivo", "dhEmi", "nfe_id"}),
    AddConteudoProcessado = Table.AddColumn(
        Base,
        "ConteudoProcessado",
        each fnNFeProcessarXmlTable(try Xml.Tables(File.Contents([FullPath])) otherwise #table({}, {})),
        type table
    ),
    Resultado = AddConteudoProcessado
in
    Resultado
