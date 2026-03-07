let
    source = #"102_NFE_Arquivos",
    // Sua consulta que lista os arquivos da pasta
    AddTabelaNF = Table.AddColumn(source, "ConteudoProcessado", each fnNFeProcessarXmlTable([XmlTable])),
    CamposBase = LAYOUT_NFE_BASE[Fields],
    DerivadosBase = Record.FieldOrDefault(LAYOUT_NFE_BASE, "Derivados", {}),
    TodasColunas = List.Transform(CamposBase, each _[Alias]) & List.Transform(DerivadosBase, each _[Name]),
    Expandir = Table.ExpandTableColumn(AddTabelaNF, "ConteudoProcessado", TodasColunas),
    SemDuplicadas = Table.Distinct(Expandir, {"Chave de Acesso"})
in
    SemDuplicadas
