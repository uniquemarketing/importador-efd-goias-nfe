let
    source = #"NFE_Processado_Base",
    LayoutBase = LAYOUT_NFE_BASE,
    CamposBase = LayoutBase[Fields],
    DerivadosBase = Record.FieldOrDefault(LayoutBase, "Derivados", {}),
    TodasColunas = List.Transform(CamposBase, each _[Alias]) & List.Transform(DerivadosBase, each _[Name]),
    Expandir = Table.ExpandRecordColumn(source, "ConteudoBase", TodasColunas, TodasColunas),
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
