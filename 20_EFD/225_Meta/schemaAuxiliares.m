let
    // Schemas_Auxiliares
    // Preencha as linhas com as colunas reais de cada tabela.
    // Tipo: "text" | "int" | "number" | "date" | "datetime" | "logical"
    // Chave: "PK" | "FK" | "" (vazio)
    Schema =
        #table(
            type table [
                Tabela = text,
                Coluna = text,
                Tipo = text,
                Chave = text,
                Nullable = logical
            ],
            {
                // ===== tb_cest =====
                {"tb_cest","Código","text","PK",false},
                {"tb_cest","Descrição","text","",false},
                {"tb_cest","Início","date","",false},
                {"tb_cest","Fim","date","",true},

                // ===== tb_cfop =====
                {"tb_cfop","Código","text","PK",false},
                {"tb_cfop","Descrição","text","",false},
                {"tb_cfop","Início","date","",false},
                {"tb_cfop","Fim","date","",true},

                // tb_cod_receita
                {"tb_cod_receita","Código","text","PK",false},
                {"tb_cod_receita","Descrição","text","",false},
                {"tb_cod_receita","Início","date","",false},
                {"tb_cod_receita","Fim","date","",true},

                //tb_cst  
                {"tb_cst","Código","text","PK",false},
                {"tb_cst","Descrição","text","",false},
                {"tb_cst","Início","date","",false},
                {"tb_cst","Fim","date","",true},

                // tb_4_1_1_modelo_doc
                {"tb_4_1_1_modelo_doc","Código","text","PK",false},
                {"tb_4_1_1_modelo_doc","Descrição","text","",false},
                {"tb_4_1_1_modelo_doc","Início","date","",false},
                {"tb_4_1_1_modelo_doc","Fim","date","",true},

                // tb_4_1_2_situacao_doc
                {"tb_4_1_2_situacao_doc","Código","text","PK",false},
                {"tb_4_1_2_situacao_doc","Descrição","text","",false},
                {"tb_4_1_2_situacao_doc","Início","date","",false},
                {"tb_4_1_2_situacao_doc","Fim","date","",true},

                // tb_4_5_5_classific_contrib_ipi
                {"tb_4_5_5_classific_contrib_ipi","Código","text","PK",false},
                {"tb_4_5_5_classific_contrib_ipi","Descrição","text","",false},
                {"tb_4_5_5_classific_contrib_ipi","Início","date","",false},
                {"tb_4_5_5_classific_contrib_ipi","Fim","date","",true},

                // tb_5_1_1_cod_aj_apur_icms
                {"tb_5_1_1_cod_aj_apur_icms","Código","text","PK",false},
                {"tb_5_1_1_cod_aj_apur_icms","Descrição","text","",false},
                {"tb_5_1_1_cod_aj_apur_icms","Início","date","",false},
                {"tb_5_1_1_cod_aj_apur_icms","Fim","date","",true},

                // tb_5_3_aj_info_val_doc_fiscal
                {"tb_5_3_aj_info_val_doc_fiscal","Código","text","PK",false},
                {"tb_5_3_aj_info_val_doc_fiscal","Descrição","text","",false},
                {"tb_5_3_aj_info_val_doc_fiscal","Início","date","",false},
                {"tb_5_3_aj_info_val_doc_fiscal","Fim","date","",true},

                // tb_municipios
                 {"tb_municipios","UF","text","",false},
                 {"tb_municipios","Nome_UF","text","",false},
                 {"tb_municipios","Codigo_Municipio","text","PK",false},
                 {"tb_municipios","Nome_Municipio","text","",false},

                 // tb_3_2_1_pais
                 {"tb_3_2_1_pais","COD_PAIS","text","PK",false},
                 {"tb_3_2_1_pais","NOME_PAIS","text","",false},
                 {"tb_3_2_1_pais","SITUACAO","text","",true},
                 {"tb_3_2_1_pais","INICIO","date","",false},
                 {"tb_3_2_1_pais","FIM","date","",true},

                 // tb_4_2_1_gen_mercadoria
                 {"tb_4_2_1_gen_mercadoria","Código","text","PK",false},
                 {"tb_4_2_1_gen_mercadoria","Descrição","text","",false}
            }
        )
in
    Schema

