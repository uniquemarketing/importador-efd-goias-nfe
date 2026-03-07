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
    // A tipagem já vem pronta de dentro da fnNFeProcessarXmlTable
    TabelaTipada = Expandir,
    // Chave única para o relacionamento
    ID_Produto = Table.AddColumn(
        TabelaTipada, "ID_Produto", each [Chave de Acesso] & "_" & Text.From([Item]), type text
    )
in
    ID_Produto
