let
    source = #"NFE_Processado_Base",
    ContratoBase = NFE_Contrato_Ativo_BASE,
    CamposBase = ContratoBase[Fields],
    DerivadosBase = Record.FieldOrDefault(ContratoBase, "Derivados", {}),
    TodasColunas = List.Transform(CamposBase, each _[Alias]) & List.Transform(DerivadosBase, each _[Name]),
    Expandir = Table.ExpandTableColumn(source, "ConteudoProcessado", TodasColunas),
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
