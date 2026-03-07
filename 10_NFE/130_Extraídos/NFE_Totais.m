let
    source = #"102_NFE_Arquivos",
    // Sua consulta que lista os arquivos da pasta
    AddTabelaNF = Table.AddColumn(source, "ConteudoProcessado", each fnNFeProcessarXmlTable([XmlTable])),
    CamposBase = LAYOUT_NFE_BASE[Fields],
    DerivadosBase = Record.FieldOrDefault(LAYOUT_NFE_BASE, "Derivados", {}),
    TodasColunas = List.Transform(CamposBase, each _[Alias]) & List.Transform(DerivadosBase, each _[Name]),
    Expandir = Table.ExpandTableColumn(AddTabelaNF, "ConteudoProcessado", TodasColunas),
    SemDuplicadas = Table.Distinct(Expandir, {"Chave de Acesso"}),
    // Tipagem Dinâmica
    Regras = List.Transform(
        CamposBase & List.Buffer(DerivadosBase),
        each
            {
                if _[Alias]? <> null then
                    _[Alias]
                else
                    _[Name],
                if _[Kind] = "number" then
                    type number
                else if _[Kind] = "date" then
                    type datetime
                else
                    type text
            }
    ),
    TabelaTipada = Table.TransformColumnTypes(SemDuplicadas, Regras),
    // Chave Primária Numérica (SK)
    ID_Nota = Table.AddIndexColumn(TabelaTipada, "ID_Nota", 1, 1, Int64.Type)
in
    ID_Nota
