let
    Fonte = Table.Buffer(#"103_Amostra_NFe_5"),
    Base = Table.SelectColumns(Fonte, {"nfe_id", "Name", "FullPath"}),
    AddXmlTable = Table.AddColumn(
        Base,
        "XmlTable",
        each try Xml.Tables(File.Contents([FullPath])) otherwise #table({}, {}),
        type table
    ),
    AddTags = Table.AddColumn(AddXmlTable, "TagsArquivo", each fnTagsNFeOtimizado([XmlTable]), type list),
    AddCamposTopo = Table.AddColumn(AddXmlTable, "CamposTopo", each fnNomeTodosCampos([XmlTable]), type list),
    ListaTags = List.Buffer(List.Combine(AddTags[TagsArquivo])),
    ListaCamposTopo = List.Buffer(List.Combine(AddCamposTopo[CamposTopo])),
    TagsUnicas = List.Sort(List.Distinct(List.Combine({ListaTags, ListaCamposTopo})), Order.Ascending),
    TabelaTags = Table.FromList(TagsUnicas, Splitter.SplitByNothing(), {"Tag"}, null, ExtraValues.Error),
    Resultado = Table.SelectRows(TabelaTags, each [Tag] <> null and Text.Trim(Text.From([Tag])) <> "")
in
    Resultado
