let
    Fonte = #table(
        type table [
            Sistema = text,
            RegistroOuGrupo = text,
            Campo = text,
            Dominio = text,
            ColunaCanonicaDestino = text,
            NormalizarAntesDoJoin = logical,
            ExpandirDescricao = logical,
            ColunaDescricao = text,
            Observacao = text
        ],
        {
            {
                "EFD_ICMS_IPI",
                "0150",
                "COD_PAIS",
                "PAIS",
                "COD_PAIS",
                true,
                true,
                "NOME_PAIS",
                "Tabela de países da EFD."
            },
            {
                "EFD_ICMS_IPI",
                "0150",
                "COD_MUN",
                "MUNICIPIO",
                "Codigo_Municipio",
                true,
                true,
                "Nome_Municipio",
                "Tabela IBGE de municípios."
            },
            {"EFD_ICMS_IPI", "0200", "CEST", "CEST", "CEST", true, true, "Descricao", "CEST do item."},
            {"EFD_ICMS_IPI", "C100", "COD_MOD", "MODELO_DOC", "Código", true, true, "Descrição", "Tabela 4.1.1."},
            {"EFD_ICMS_IPI", "C100", "COD_SIT", "SITUACAO_DOC", "Código", true, true, "Descrição", "Tabela 4.1.2."},
            {"EFD_ICMS_IPI", "C170", "CFOP", "CFOP", "CFOP", true, true, "Descrição", "CFOP do item."},
            {
                "EFD_ICMS_IPI",
                "C170",
                "CST_ICMS",
                "CST_ICMS_EFD",
                "CST_ICMS",
                true,
                true,
                "DESC_CST",
                "CST ICMS da EFD."
            },
            {"EFD_ICMS_IPI", "C190", "CFOP", "CFOP", "CFOP", true, true, "Descrição", "CFOP do agrupamento."},
            {
                "EFD_ICMS_IPI",
                "C190",
                "CST_ICMS",
                "CST_ICMS_EFD",
                "CST_ICMS",
                true,
                true,
                "DESC_CST",
                "CST ICMS da EFD."
            },
            {
                "EFD_ICMS_IPI",
                "E111",
                "COD_AJ_APUR",
                "COD_AJ_APUR_ICMS",
                "COD_AJ_APUR",
                true,
                true,
                "DESCRICAO",
                "Tabela 5.1.1 - ajuste da apuração do ICMS."
            },
            {
                "EFD_ICMS_IPI",
                "E311",
                "COD_AJ_APUR",
                "COD_AJ_APUR_ICMS",
                "COD_AJ_APUR",
                true,
                true,
                "DESCRICAO",
                "Tabela 5.1.1 - ajuste da apuração do ICMS em sub-apuração."
            },
            {
                "EFD_ICMS_IPI",
                "E115",
                "COD_INF_ADIC",
                "AJ_INFO_VAL_DOC_FISCAL",
                "COD_INF_ADIC",
                true,
                true,
                "DESCRICAO",
                "Tabela de informação adicional de valores declaratórios."
            },
            {
                "NFE",
                "emit/enderEmit",
                "cPais",
                "PAIS_BACEN_NFE",
                "cPais",
                true,
                true,
                "PaisNome",
                "País do emitente na NF-e."
            },
            {
                "NFE",
                "emit/enderEmit",
                "cMun",
                "MUNICIPIO",
                "Codigo_Municipio",
                true,
                true,
                "Nome_Municipio",
                "Município do emitente."
            },
            {
                "NFE",
                "dest/enderDest",
                "cPais",
                "PAIS_BACEN_NFE",
                "cPais",
                true,
                true,
                "PaisNome",
                "País do destinatário na NF-e."
            },
            {
                "NFE",
                "dest/enderDest",
                "cMun",
                "MUNICIPIO",
                "Codigo_Municipio",
                true,
                true,
                "Nome_Municipio",
                "Município do destinatário."
            },
            {"NFE", "prod", "CFOP", "CFOP", "CFOP", true, true, "Descrição", "CFOP do item da NF-e."},
            {"NFE", "prod", "CEST", "CEST", "CEST", true, true, "Descricao", "CEST do item da NF-e."},
            {"NFE", "ICMS", "orig", "ORIG_NFE", "orig", true, true, "descOrig", "Origem da mercadoria."},
            {"NFE", "ICMS", "CST", "CST_NFE", "CST", true, true, "descCST", "CST de 2 dígitos da NF-e normal."},
            {
                "NFE",
                "ICMS",
                "CSOSN",
                "CSOSN_NFE",
                "CSOSN",
                true,
                true,
                "descCSOSN",
                "CSOSN da NF-e Simples Nacional."
            }
        }
    )
in
    Fonte
