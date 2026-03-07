let
    source = #"102_NFE_Arquivos",
    LayoutBase = LAYOUT_NFE_BASE,
    CamposBase = LayoutBase[Fields],
    DerivadosBase = Record.FieldOrDefault(LayoutBase, "Derivados", {}),
    TodasColunas = List.Transform(CamposBase, each _[Alias]) & List.Transform(DerivadosBase, each _[Name]),
    AddConteudoBase = Table.AddColumn(
        source,
        "ConteudoBase",
        each
            fnNFeProcessarTotaisXmlTable(
                try Xml.Tables(File.Contents([FullPath])) otherwise #table({}, {}),
                LayoutBase
            ),
        type record
    ),
    Expandir = Table.ExpandRecordColumn(AddConteudoBase, "ConteudoBase", TodasColunas, TodasColunas),
    SemDuplicadas = Table.Distinct(Expandir, {"Chave de Acesso"}),
    RegrasTipo = List.Transform(
        CamposBase & DerivadosBase,
        each
            {
                if _[Alias]? <> null then _[Alias] else _[Name],
                try fnParseKind(null, _[Kind], "type") otherwise type any
            }
    ),
    TabelaTipada = if List.IsEmpty(RegrasTipo) then SemDuplicadas else Table.TransformColumnTypes(SemDuplicadas, RegrasTipo)
in
    TabelaTipada
