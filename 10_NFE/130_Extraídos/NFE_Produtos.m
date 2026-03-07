let
    source = #"102_NFE_Arquivos",
    // Processa os XMLs usando o Layout fixo e a função de processamento
    AddTabelaNF = Table.AddColumn(source, "ConteudoProcessado", each fnNFeProcessarXmlTable([XmlTable])),
    ContratoProd = NFE_Contrato_Ativo_PROD,
    CamposProd = ContratoProd[Fields],
    DerivadosProd = Record.FieldOrDefault(ContratoProd, "Derivados", {}),
    CamposICMS = ContratoProd[ICMS_Layout],
    // Monta a lista de nomes que o Power Pivot espera ver
    ColunasParaExpandir = List.Distinct(
        {"Chave de Acesso"}
            & List.Transform(CamposProd, each _[Alias])
            & List.Transform(DerivadosProd, each _[Name])
            & List.Transform(CamposICMS, each _[Alias])
            & {"Tag de Origem ICMS"}
    ),
    // Expande garantindo que todas as colunas existam na tabela final
    Expandir = Table.ExpandTableColumn(AddTabelaNF, "ConteudoProcessado", ColunasParaExpandir),
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
                {{"Tag de Origem ICMS", fnParseKind(null, "text", "type")}}
            }
        )
    ),
    TabelaTipada = if List.IsEmpty(RegrasTipo) then Expandir else Table.TransformColumnTypes(Expandir, RegrasTipo),
    // Chave única para o relacionamento
    ID_Produto = Table.AddColumn(
        TabelaTipada, "ID_Produto", each [Chave de Acesso] & "_" & Text.From([Item]), type text
    )
in
    ID_Produto
