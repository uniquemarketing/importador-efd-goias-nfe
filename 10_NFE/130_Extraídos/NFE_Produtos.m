let
    source = #"NFE_Processado_Base",
    LayoutProd = LAYOUT_NFE_PROD,
    CamposProd = LayoutProd[Fields],
    DerivadosProd = Record.FieldOrDefault(LayoutProd, "Derivados", {}),
    CamposICMS = LayoutProd[ICMS_Layout],
    // Monta a lista de nomes que o Power Pivot espera ver
    ColunasParaExpandir = List.Distinct(
        {"Chave de Acesso", "Chave_Acesso_44"}
            & List.Transform(CamposProd, each _[Alias])
            & List.Transform(DerivadosProd, each _[Name])
            & List.Transform(CamposICMS, each _[Alias])
            & {"Tag de Origem ICMS"}
    ),
    // Expande garantindo que todas as colunas existam na tabela final
    Expandir = Table.ExpandTableColumn(source, "ConteudoProcessado", ColunasParaExpandir),
    RegrasTipo = List.Distinct(
        List.Combine(
            {
                List.Transform(
                    CamposProd & DerivadosProd,
                    each
                        {
                            if _[Alias]? <> null then _[Alias] else _[Name],
                            try fnParseKind(null, _[Kind], "type") otherwise type any
                        }
                ),
                List.Transform(
                    CamposICMS,
                    each
                        {
                            _[Alias],
                            try fnParseKind(null, _[Kind], "type") otherwise type any
                        }
                ),
                {
                    {"Chave de Acesso", fnParseKind(null, "text", "type")},
                    {"Chave_Acesso_44", fnParseKind(null, "text", "type")}
                },
                {{"Tag de Origem ICMS", fnParseKind(null, "text", "type")}}
            }
        )
    ),
    TabelaTipada = if List.IsEmpty(RegrasTipo) then Expandir else Table.TransformColumnTypes(Expandir, RegrasTipo),
    // Chave primária técnica por item da nota
    ID_Produto = Table.AddColumn(
        TabelaTipada, "ID_Produto", each Text.From([nfe_id]) & "_" & Text.From([Item]), type text
    )
in
    ID_Produto
