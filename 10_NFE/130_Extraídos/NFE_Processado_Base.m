let
    Source = #"102_NFE_Arquivos",
    Base = Table.SelectColumns(
        Source,
        {"PastaTipo", "Name", "FullPath", "TipoArquivo", "XmlTable", "dhEmi", "nfe_id"}
    ),
    AddConteudoProcessado = Table.AddColumn(Base, "ConteudoProcessado", each fnNFeProcessarXmlTable([XmlTable]), type table),
    Resultado = Table.Buffer(AddConteudoProcessado)
in
    Resultado
