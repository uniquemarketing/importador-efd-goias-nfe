let
    Fonte = #table(
        type table [
            Tabela = text,
            ArquivoCsv = text,
            PastaRelativa = text,
            Delimiter = text,
            Encoding = Int64.Type,
            HasHeaders = logical,
            Cultura = text,
            QueryDestino = text,
            Observacao = text
        ],
        {
            {
                "tb_pais",
                "tb_pais.csv",
                "Auxiliares",
                ";",
                65001,
                true,
                "pt-BR",
                "tb_pais",
                "Tabela de países da EFD."
            },
            {
                "tb_bacen_pais",
                "tb_bacen_pais.csv",
                "Auxiliares",
                ";",
                65001,
                true,
                "pt-BR",
                "tb_bacen_pais",
                "Tabela de países da NF-e."
            },
            {
                "tb_municipios",
                "tb_municipios.csv",
                "Auxiliares",
                ";",
                65001,
                true,
                "pt-BR",
                "tb_municipios",
                "Tabela IBGE de municípios."
            },
            {"tb_cfop", "tb_cfop.csv", "Auxiliares", ";", 65001, true, "pt-BR", "tb_cfop", "Tabela CFOP."},
            {
                "tb_cst_efd",
                "tb_cst_efd.csv",
                "Auxiliares",
                ";",
                65001,
                true,
                "pt-BR",
                "tb_cst_efd",
                "Tabela oficial CST ICMS da EFD."
            },
            {
                "tb_orig_nfe",
                "tb_orig_nfe.csv",
                "Auxiliares",
                ";",
                65001,
                true,
                "pt-BR",
                "tb_orig_nfe",
                "Tabela de origem da mercadoria na NF-e."
            },
            {
                "tb_cst_nfe",
                "tb_cst_nfe.csv",
                "Auxiliares",
                ";",
                65001,
                true,
                "pt-BR",
                "tb_cst_nfe",
                "Tabela CST de 2 dígitos da NF-e."
            },
            {
                "tb_csosn_nfe",
                "tb_csosn_nfe.csv",
                "Auxiliares",
                ";",
                65001,
                true,
                "pt-BR",
                "tb_csosn_nfe",
                "Tabela CSOSN da NF-e."
            },
            {"tb_cest", "tb_cest.csv", "Auxiliares", ";", 65001, true, "pt-BR", "tb_cest", "Tabela CEST."},
            {
                "tb_modelo_doc",
                "tb_modelo_doc.csv",
                "Auxiliares",
                ";",
                65001,
                true,
                "pt-BR",
                "tb_modelo_doc",
                "Tabela 4.1.1 da EFD."
            },
            {
                "tb_situacao_doc",
                "tb_situacao_doc.csv",
                "Auxiliares",
                ";",
                65001,
                true,
                "pt-BR",
                "tb_situacao_doc",
                "Tabela 4.1.2 da EFD."
            },
            {
                "tb_cod_aj_apur_icms",
                "tb_cod_aj_apur_icms.csv",
                "Auxiliares",
                ";",
                65001,
                true,
                "pt-BR",
                "tb_cod_aj_apur_icms",
                "Tabela 5.1.1 - código do ajuste da apuração do ICMS."
            },
            {
                "tb_aj_info_val_doc_fiscal",
                "tb_aj_info_val_doc_fiscal.csv",
                "Auxiliares",
                ";",
                65001,
                true,
                "pt-BR",
                "tb_aj_info_val_doc_fiscal",
                "Tabela de informações adicionais de valores / ajustes do documento fiscal."
            }
        }
    )
in
    Fonte
