let
    Fonte = Table.Buffer(#"103_Amostra_NFe_5"),
    Base = Table.SelectColumns(Fonte, {"nfe_id", "Name", "XmlTable"}),
    AddTags = Table.AddColumn(Base, "TagsArquivo", each fnTagsNFeOtimizado([XmlTable]), type list),
    AddCamposTopo = Table.AddColumn(Base, "CamposTopo", each fnNomeTodosCampos([XmlTable]), type list),
    ListaTags = List.Buffer(List.Combine(AddTags[TagsArquivo])),
    ListaCamposTopo = List.Buffer(List.Combine(AddCamposTopo[CamposTopo])),
    TagsUnicas = List.Sort(List.Distinct(List.Combine({ListaTags, ListaCamposTopo})), Order.Ascending),
    TabelaTags = Table.FromList(TagsUnicas, Splitter.SplitByNothing(), {"Tag"}, null, ExtraValues.Error),
    Resultado = Table.SelectRows(TabelaTags, each [Tag] <> null and Text.Trim(Text.From([Tag])) <> "")
in
    Resultado
