let
    Fonte = #table(
        type table [
            Dominio = text,
            Sistema = text,
            Compartilhado = logical,
            TabelaCanonica = text,
            ChaveCanonica = text,
            TipoCanonico = text,
            TamanhoCanonico = Int64.Type,
            PossuiVigencia = logical,
            OrigemOficial = text,
            Observacao = text
        ],
        {
            {
                "PAIS",
                "EFD_ICMS_IPI",
                false,
                "dim_pais",
                "COD_PAIS",
                "text",
                5,
                true,
                "EFD tabela 3.2.1",
                "Tabela de países no padrão EFD."
            },
            {
                "PAIS_BACEN_NFE",
                "NFE",
                false,
                "dim_bacen_pais",
                "cPais",
                "text",
                4,
                false,
                "BACEN / Portal NF-e",
                "Tabela de países no padrão NF-e."
            },
            {
                "MUNICIPIO",
                "AMBOS",
                true,
                "dim_municipio",
                "Codigo_Municipio",
                "text",
                7,
                false,
                "IBGE",
                "Tabela de municípios IBGE."
            },
            {
                "CFOP",
                "AMBOS",
                true,
                "dim_cfop",
                "CFOP",
                "text",
                4,
                true,
                "Tabela CFOP",
                "Código Fiscal de Operações e Prestações."
            },
            {
                "CST_ICMS_EFD",
                "EFD_ICMS_IPI",
                false,
                "dim_cst_efd",
                "CST_ICMS",
                "text",
                3,
                true,
                "Tabela 4.3.1 EFD",
                "Tabela oficial de CST ICMS usada pela EFD."
            },
            {
                "ORIG_NFE",
                "NFE",
                false,
                "dim_orig_nfe",
                "orig",
                "text",
                1,
                false,
                "Anexo I NF-e",
                "Origem da mercadoria na NF-e."
            },
            {
                "CST_NFE",
                "NFE",
                false,
                "dim_cst_nfe",
                "CST",
                "text",
                2,
                false,
                "Anexo I NF-e",
                "CST de 2 dígitos da NF-e regime normal."
            },
            {
                "CSOSN_NFE",
                "NFE",
                false,
                "dim_csosn_nfe",
                "CSOSN",
                "text",
                3,
                false,
                "Anexo I NF-e",
                "CSOSN da NF-e para CRT=1."
            },
            {
                "CEST",
                "AMBOS",
                true,
                "dim_cest",
                "CEST",
                "text",
                7,
                true,
                "Tabela CEST",
                "Código Especificador da Substituição Tributária."
            },
            {
                "MODELO_DOC",
                "EFD_ICMS_IPI",
                false,
                "dim_modelo_doc",
                "Código",
                "text",
                2,
                true,
                "Tabela 4.1.1 EFD",
                "Modelo do documento fiscal."
            },
            {
                "SITUACAO_DOC",
                "EFD_ICMS_IPI",
                false,
                "dim_situacao_doc",
                "Código",
                "text",
                2,
                true,
                "Tabela 4.1.2 EFD",
                "Situação do documento fiscal."
            },
            {
                "COD_AJ_APUR_ICMS",
                "EFD_ICMS_IPI",
                false,
                "dim_cod_aj_apur_icms",
                "COD_AJ_APUR",
                "text",
                8,
                false,
                "Tabela 5.1.1 EFD",
                "Código do ajuste da apuração e dedução do ICMS."
            },
            {
                "AJ_INFO_VAL_DOC_FISCAL",
                "EFD_ICMS_IPI",
                false,
                "dim_aj_info_val_doc_fiscal",
                "COD_INF_ADIC",
                "text",
                8,
                false,
                "Tabela 5.2/5.3 EFD",
                "Código da informação adicional de valores declaratórios / ajustes vinculados ao documento fiscal."
            }
        }
    )
in
    Fonte
