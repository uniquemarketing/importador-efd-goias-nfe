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
    // Chave primária técnica por item da nota
    ID_Produto = Table.AddColumn(
        Expandir, "ID_Produto", each Text.From([nfe_id]) & "_" & Text.From([Item]), type text
    ),
    ParesTipoCamposProd = List.Transform(CamposProd, each {_[Alias], fnParseKind(null, _[Kind], "type")}),
    ParesTipoDerivadosProd = List.Transform(DerivadosProd, each {_[Name], fnParseKind(null, _[Kind], "type")}),
    ParesTipoCamposICMS = List.Transform(CamposICMS, each {_[Alias], fnParseKind(null, _[Kind], "type")}),
    ParesTipoFixos = {
        {"Chave de Acesso", type text},
        {"Chave_Acesso_44", type text},
        {"Tag de Origem ICMS", type text},
        {"ID_Produto", type text}
    },
    RegrasTipo = List.Distinct(List.Combine({ParesTipoFixos, ParesTipoCamposProd, ParesTipoDerivadosProd, ParesTipoCamposICMS})),
    ColunasAtuais = Table.ColumnNames(ID_Produto),
    RegrasTipoAtivas = List.Select(RegrasTipo, each List.Contains(ColunasAtuais, _{0})),
    Tipada = Table.TransformColumnTypes(ID_Produto, RegrasTipoAtivas, "pt-BR")
in
    Tipada
