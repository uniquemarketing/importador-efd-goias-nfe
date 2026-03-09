let
    Fonte = #table(
        type table [
            Dominio = text,
            Sistema = text,
            TabelaFisica = text,
            TabelaCanonica = text,
            ColunaChaveFisica = text,
            TipoFisico = text,
            TamanhoFisico = Int64.Type,
            RegraNormalizacaoEntrada = text,
            RegraFormatacaoSaida = text,
            ColunaDescricao = text
        ],
        {
            {
                "PAIS",
                "EFD_ICMS_IPI",
                "tb_pais",
                "dim_pais",
                "COD_PAIS",
                "text",
                5,
                "Padronizar para 5 dígitos.",
                "[COD_PAIS]",
                "NOME_PAIS"
            },
            {
                "PAIS_BACEN_NFE",
                "NFE",
                "tb_bacen_pais",
                "dim_bacen_pais",
                "cPais",
                "text",
                4,
                "Padronizar para 4 dígitos.",
                "[cPais]",
                "PaisNome"
            },
            {
                "MUNICIPIO",
                "AMBOS",
                "tb_municipios",
                "dim_municipio",
                "Codigo_Municipio",
                "text",
                7,
                "Padronizar para 7 dígitos.",
                "[Codigo_Municipio]",
                "Nome_Municipio"
            },
            {
                "CFOP",
                "AMBOS",
                "tb_cfop",
                "dim_cfop",
                "CFOP",
                "text",
                4,
                "Padronizar para 4 dígitos.",
                "[CFOP]",
                "Descrição"
            },
            {
                "CST_ICMS_EFD",
                "EFD_ICMS_IPI",
                "tb_cst_efd",
                "dim_cst_efd",
                "CST_ICMS",
                "text",
                3,
                "Padronizar para 3 dígitos.",
                "[CST_ICMS]",
                "DESC_CST"
            },
            {
                "ORIG_NFE",
                "NFE",
                "tb_orig_nfe",
                "dim_orig_nfe",
                "orig",
                "text",
                1,
                "Padronizar para 1 dígito.",
                "[orig]",
                "descOrig"
            },
            {
                "CST_NFE",
                "NFE",
                "tb_cst_nfe",
                "dim_cst_nfe",
                "CST",
                "text",
                2,
                "Padronizar para 2 dígitos.",
                "[CST]",
                "descCST"
            },
            {
                "CSOSN_NFE",
                "NFE",
                "tb_csosn_nfe",
                "dim_csosn_nfe",
                "CSOSN",
                "text",
                3,
                "Padronizar para 3 dígitos.",
                "[CSOSN]",
                "descCSOSN"
            },
            {
                "CEST",
                "AMBOS",
                "tb_cest",
                "dim_cest",
                "CEST",
                "text",
                7,
                "Padronizar para 7 dígitos.",
                "[CEST]",
                "Descricao"
            },
            {
                "MODELO_DOC",
                "EFD_ICMS_IPI",
                "tb_modelo_doc",
                "dim_modelo_doc",
                "Código",
                "text",
                2,
                "Padronizar para 2 dígitos.",
                "[Código]",
                "Descrição"
            },
            {
                "SITUACAO_DOC",
                "EFD_ICMS_IPI",
                "tb_situacao_doc",
                "dim_situacao_doc",
                "Código",
                "text",
                2,
                "Padronizar para 2 dígitos.",
                "[Código]",
                "Descrição"
            },
            {
                "COD_AJ_APUR_ICMS",
                "EFD_ICMS_IPI",
                "tb_cod_aj_apur_icms",
                "dim_cod_aj_apur_icms",
                "COD_AJ_APUR",
                "text",
                8,
                "Padronizar para 8 caracteres.",
                "[COD_AJ_APUR]",
                "DESCRICAO"
            },
            {
                "AJ_INFO_VAL_DOC_FISCAL",
                "EFD_ICMS_IPI",
                "tb_aj_info_val_doc_fiscal",
                "dim_aj_info_val_doc_fiscal",
                "COD_INF_ADIC",
                "text",
                8,
                "Padronizar para 8 caracteres.",
                "[COD_INF_ADIC]",
                "DESCRICAO"
            }
        }
    )
in
    Fonte
