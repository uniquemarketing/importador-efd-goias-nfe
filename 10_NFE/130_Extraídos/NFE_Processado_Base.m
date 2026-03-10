let
    // OTI-5 (alto risco): materializa toda a tabela para tentar reduzir reavaliações.
    // Se houver aumento de memória ou piora de UI, voltar para false.
    AtivarBufferOTI5 = true,
    Source = #"102_NFE_Arquivos",
    Base = Table.SelectColumns(Source, {"PastaTipo", "Name", "FullPath", "TipoArquivo", "dhEmi", "nfe_id"}),
    LayoutBase = LAYOUT_NFE_BASE,
    AddXmlTable = Table.AddColumn(
        Base,
        "XmlTable",
        each try Xml.Tables(File.Contents([FullPath])) otherwise #table({}, {}),
        type table
    ),
    AddConteudoBase = Table.AddColumn(
        AddXmlTable,
        "ConteudoBase",
        each fnNFeProcessarTotaisXmlTable([XmlTable], LayoutBase),
        type record
    ),
    AddConteudoProcessado = Table.AddColumn(
        AddConteudoBase,
        "ConteudoProcessado",
        each fnNFeProcessarXmlTable([XmlTable]),
        type table
    ),
    ResultadoSemXml = Table.RemoveColumns(AddConteudoProcessado, {"XmlTable"}),
    Resultado = if AtivarBufferOTI5 then Table.Buffer(ResultadoSemXml) else ResultadoSemXml
in
    Resultado
