// Power Query from: Importador_EFD_1.23.xlsx
// Pathname: d:\SEFAZ\01_IMPORTA_EFD_GOIAS\VERSOES_IMPORTADOR\v_1.2.3\Importador_EFD_1.23.xlsx
// Extracted: 2026-03-07T23:26:10.857Z

section Section1;

shared tb_cest = let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_cest"]}[Content],
    #"Tipo Alterado" = Table.TransformColumnTypes(Fonte,{{"Código", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}})
in
    #"Tipo Alterado";

shared tb_cfop = let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_cfop"]}[Content],
    #"Tipo Alterado" = Table.TransformColumnTypes(Fonte,{{"CFOP", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}}),
    #"Colunas Renomeadas" = Table.RenameColumns(#"Tipo Alterado",{{"CFOP", "Código"}})
in
    #"Colunas Renomeadas";

shared tb_cod_receita = let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_cod_receita"]}[Content],
    #"Tipo Alterado" = Table.TransformColumnTypes(Fonte,{{"Código", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}})
in
    #"Tipo Alterado";

shared tb_cst = let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_cst"]}[Content],
    #"Colunas Renomeadas" = Table.RenameColumns(Fonte,{{"CST_ICMS", "Código"}, {"DESC_CST", "Descrição"}, {"INICIO", "Início"}, {"FIM", "Fim"}}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Colunas Renomeadas",{{"Código", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}})
in
    #"Tipo Alterado";

shared tb_municipios = let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_municipios"]}[Content],
    #"Tipo Alterado" = Table.TransformColumnTypes(Fonte,{{"UF", type text}, {"Nome_UF", type text}, {"Codigo_Municipio", type text}, {"Nome_Municipio", type text}})
in
    #"Tipo Alterado";

shared tb_3_2_1_pais = let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_3_2_1_pais"]}[Content],
    #"Tipo Alterado" = Table.TransformColumnTypes(Fonte,{{"COD_PAIS", type text}, {"NOME_PAIS", type text}, {"SITUACAO", type text}, {"DATA_INICIO", type date}, {"DATA_FIM", type date}}),
    #"Colunas Renomeadas" = Table.RenameColumns(#"Tipo Alterado",{{"DATA_INICIO", "INICIO"}, {"DATA_FIM", "FIM"}})
in
    #"Colunas Renomeadas";

shared tb_4_1_1_modelo_doc = let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_4_1_1_modelo_doc"]}[Content],
    #"Colunas Renomeadas" = Table.RenameColumns(Fonte,{{"COD_MOD", "Código"}, {"DESC_MOD", "Descrição"}, {"INICIO", "Início"}, {"FIM", "Fim"}}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Colunas Renomeadas",{{"Código", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}})
in
    #"Tipo Alterado";

shared tb_4_1_2_situacao_doc = let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_4_1_2_situacao_doc"]}[Content],
    #"Colunas Renomeadas" = Table.RenameColumns(Fonte,{{"COD_SIT", "Código"}, {"DESC_SIT", "Descrição"}, {"INICIO", "Início"}, {"FIM", "Fim"}}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Colunas Renomeadas",{{"Código", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}})
in
    #"Tipo Alterado";

shared tb_4_2_1_gen_mercadoria = let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_4_2_1_gen_mercadoria"]}[Content],
    #"Tipo Alterado" = Table.TransformColumnTypes(Fonte,{{"Código", type text}, {"Descrição", type text}})
in
    #"Tipo Alterado";

shared tb_4_5_5_classific_contrib_ipi = let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_4_5_5_classific_contrib_ipi"]}[Content],
    #"Colunas Renomeadas" = Table.RenameColumns(Fonte,{{"COD_ESTAB_IND", "Código"}, {"DESCRICAO_TIPO_ATIVIDADE_IPI", "Descrição"}, {"INICIO", "Início"}, {"FIM", "Fim"}}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Colunas Renomeadas",{{"Código", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}})
in
    #"Tipo Alterado";

shared tb_5_1_1_cod_aj_apur_icms = let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_5_1_1_cod_aj_apur_icms"]}[Content],
    #"Colunas Renomeadas" = Table.RenameColumns(Fonte,{{"Descricao_do_ajuste", "Descrição"}}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Colunas Renomeadas",{{"Código", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}})
in
    #"Tipo Alterado";

shared tb_5_3_aj_info_val_doc_fiscal = let
    Fonte = Excel.CurrentWorkbook(){[Name="tb_5_3_aj_info_val_doc_fiscal"]}[Content],
    #"Colunas Renomeadas" = Table.RenameColumns(Fonte,{{"Descrição do ajustes/benefício/incentivo", "Descrição"}}),
    #"Colunas Removidas" = Table.RemoveColumns(#"Colunas Renomeadas",{"B", "B - Reflexo na Apuração", "C", "C - Tipo de Apuração", "D", "D - Responsabilidade", "E", "E - Influência no Recolhimento", "F", "F -Origem da Tributação", "GGG", "GGG - Ajuste de ICMS", "UF"}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Colunas Removidas",{{"Código", type text}, {"Descrição", type text}, {"Início", type date}, {"Fim", type date}})
in
    #"Tipo Alterado";

shared Meta_Registros = let
    Fonte = #table(
        type table [
            Registro = text,
            Nivel = Int64.Type,
            Bloco = text,
            PaiEsperado = nullable text,
            Descricao = text,
            Ocorrencia = text,
            ativo = logical
        ],

            // =====================
            // Bloco 0
            // =====================
        {
            {"0000", 0, "0", null,  "Abertura do Arquivo Digital e Identificação da entidade", "1", true},
            {"0001", 1, "0", "0000","Abertura do Bloco 0", "1",   true},
            {"0002", 2, "0", "0001","Classificação do Estabelecimento Industrial ou Equiparado a Industrial", "1", true},
            {"0005", 2, "0", "0001","Dados Complementares da entidade",  "1", false},
            {"0015", 2, "0", "0001","Dados do Contribuinte Substituto ou Responsável pelo ICMS Destino", "V", true},
            {"0100", 2, "0", "0001","Dados do Contabilista", "1", false},
            {"0150", 2, "0", "0001","Tabela de Cadastro do Participante", "V", true},
            {"0175", 3, "0", "0150","Alteração da Tabela de Cadastro de Participante", "1:N", true},
            {"0190", 2, "0", "0001","Identificação das unidades de medida", "V", true},
            {"0200", 2, "0", "0001","Tabela de Identificação do Item (Produtos e Serviços)", "V", true},
            {"0205", 3, "0", "0200","Alteração do Item", "1:N", true},
            {"0206", 3, "0", "0200","Código do produto conforme Tabela ANP", "1:1", false},
            {"0210", 3, "0", "0200","Consumo Específico Padronizado", "1:N", false},
            {"0220", 3, "0", "0200","Fatores de Conversão de Unidades", "1:N", true},
            {"0221", 3, "0", "0200","Correlação entre códigos de itens comercializados", "1:N", true},
            {"0300", 2, "0", "0001","Cadastro de bens ou componentes do Ativo Imobilizado", "V", true},
            {"0305", 3, "0", "0300","Informação sobre a Utilização do Bem", "1:1", true},
            {"0400", 2, "0", "0001","Tabela de Natureza da Operação/ Prestação", "V", true},
            {"0450", 2, "0", "0001","Tabela de Informação Complementar do documento fiscal",  "V", true},
            {"0460", 2, "0", "0001","Tabela de Observações do Lançamento Fiscal", "V", true},
            {"0500", 2, "0", "0001","Plano de contas contábeis", "V", false},
            {"0600", 2, "0", "0001","Centro de custos", "V", false},
            {"0990", 1, "0", "0000","Encerramento do Bloco 0", "1", false},

            // =====================
            // Bloco B
            // =====================

            {"B001", 1, "B", "0000", "Abertura do Bloco B", "1", false},
            {"B020", 2, "B", "B001", "Nota Fiscal (código 01), Nota Fiscal de Serviços (código 03), Nota Fiscal de Serviços Avulsa (código 3B), Nota Fiscal de Produtor (código 04), Conhecimento de Transporte Rodoviário de Cargas (código 08), NF-e (código 55) e NFC-e (código 65)", "V", false},
            {"B025", 3, "B", "B020", "Detalhamento por combinação de alíquota e item da lista de serviços da Lei Complementar nº 116/2003", "1:N", false},
            {"B030", 2, "B", "B001", "Nota Fiscal de Serviços Simplificada (código 3A)", "V", false},
            {"B035", 3, "B", "B030", "Detalhamento por combinação de alíquota e item da lista de serviços da Lei Complementar nº 116/2003", "1:N", false},
            {"B350", 2, "B", "B001", "Serviços prestados por instituições financeiras", "V", false},
            {"B420", 2, "B", "B001", "Totalização dos valores de serviços prestados por combinação de alíquota e item da lista de serviços da Lei Complementar nº 116/2003", "V", false},
            {"B440", 2, "B", "B001", "Totalização dos valores retidos", "V", false},
            {"B460", 2, "B", "B001", "Deduções do ISS", "V", false},
            {"B470", 2, "B", "B001", "Apuração do ISS", "1", false},
            {"B500", 2, "B", "B001", "Apuração do ISS sociedade uniprofissional", "1", false},
            {"B510", 3, "B", "B500", "Uniprofissional – empregados e sócios", "V", false},
            {"B990", 1, "B", "0000", "Encerramento do Bloco B", "1", false},

            // =====================
            // Bloco C
            // =====================

            {"C001", 1, "C", "0000", "Abertura do Bloco C", "1", true},
            {"C100", 2, "C", "C001", "Documento - Nota Fiscal (código 01), Nota Fiscal Avulsa (código 1B), Nota Fiscal de Produtor (código 04), Nota Fiscal Eletrônica (código 55) e Nota Fiscal Eletrônica para Consumidor Final (código 65)", "V", true},

            {"C101", 3, "C", "C100", "Informação complementar dos documentos fiscais quando das operações interestaduais destinadas a consumidor final não contribuinte EC 87/15 (código 55)", "1:1", true},
            {"C105", 3, "C", "C100", "Operações com ICMS ST recolhido para UF diversa da destinatária do documento fiscal (Código 55)", "1:1", true},
            {"C110", 3, "C", "C100", "Complemento do Documento - Informação Complementar da Nota Fiscal (código 01, 1B, 55)", "1:N", true},
            {"C111", 4, "C", "C110", "Complemento do Documento - Processo referido", "1:N", true},
            {"C112", 4, "C", "C110", "Complemento do Documento - Documento de Arrecadação Referenciado", "1:N", true},
            {"C113", 4, "C", "C110", "Complemento do Documento - Documento Fiscal Referenciado", "1:N", true},
            {"C114", 4, "C", "C110", "Complemento do Documento - Cupom Fiscal Referenciado", "1:N", true},
            {"C115", 4, "C", "C110", "Local de coleta e/ou entrega (CÓDIGOS 01, 1B e 04)", "1:N", false},
            {"C116", 4, "C", "C110", "Cupom Fiscal Eletrônico - CF-e referenciado", "1:N", true},

            {"C120", 3, "C", "C100", "Complemento do Documento - Operações de Importação (código 01 e 55)", "1:N", true},
            {"C130", 3, "C", "C100", "Complemento do Documento - ISSQN, IRRF e Previdência Social", "1:1", false},
            {"C140", 3, "C", "C100", "Complemento do Documento - Fatura (código 01)", "1:N", false},
            {"C141", 4, "C", "C140", "Complemento do Documento - Vencimento da Fatura (código 01)", "1:1", false},
            {"C160", 3, "C", "C100", "Complemento de Documento - Volume Transportados (código 01 e 04) Exceto Combustíveis", "1:N", false},
            {"C165", 3, "C", "C100", "Complemento de Documento - Operações com combustíveis (código 01)", "1:N", false},

            {"C170", 3, "C", "C100", "Complemento do Documento - Itens do Documento (código 01, 1B, 04 e 55)", "1:N", true},
            {"C171", 4, "C", "C170", "Complemento de Item - Armazenamento de Combustíveis (código 01,55)", "1:N", false},
            {"C172", 4, "C", "C170", "Complemento de Item - Operações com ISSQN (código 01)", "1:N", false},
            {"C173", 4, "C", "C170", "Complemento de Item - Operações com Medicamentos (código 01,55)", "1:N", false},
            {"C174", 4, "C", "C170", "Complemento de Item - Operações com Armas de Fogo (código 01)", "1:N", false},
            {"C175", 4, "C", "C170", "Complemento de Item - Operações com Veículos Novos (código 01,55)", "1:N", false},
            {"C176", 4, "C", "C170", "Complemento de Item - Ressarcimento de ICMS em operações com Substituição Tributária (código 01,55)", "1:N", true},
            {"C177", 4, "C", "C170", "Complemento do Item – Outras informações (Cód. 01, 55) – (Válido a partir de 01/01/2019)", "1:1", true},
            {"C178", 4, "C", "C170", "Complemento do Item - Operações com Produtos Sujeitos a Tributação de IPI", "1:N", false},
            {"C179", 4, "C", "C170", "Complemento do Item - Informações Complementares ST (código 01)", "1:1", true},

            {"C180", 4, "C", "C170", "Informações complementares das operações de entrada de mercadorias sujeitas à substituição tributária (código 01, 1B, 04 e 55)", "1:1", true},
            {"C181", 4, "C", "C170", "Informações complementares das operações de devolução de saídas de mercadorias sujeitas à substituição tributária (código 01, 1B, 04 e 55)", "1:N", true},
            {"C185", 3, "C", "C100", "Informações complementares das operações de saída de mercadorias sujeitas à substituição tributária (código 01, 1B, 04 e 55)", "1:N", true},
            {"C186", 3, "C", "C100", "Informações complementares das operações de entrada de mercadorias sujeitas à substituição tributária (código 01, 1B, 04 e 55)", "1:N", true},
            {"C190", 3, "C", "C100", "Registro Analítico do Documento (código 01, 1B, 04, 55 e 65)", "1:N", true},
            {"C191", 4, "C", "C190", "Informações do Fundo de Combate a Pobreza – FCP – na NF-e (Código 55)", "1:1", true},
            {"C195", 3, "C", "C100", "Complemento do Registro Analítico - Observações do Lançamento Fiscal (código 01, 1B, 04 e 55)", "1:N", true},
            {"C197", 4, "C", "C195", "Outras Obrigações Tributárias, Ajustes e Informações provenientes de Documento Fiscal", "1:N", true},

            {"C300", 2, "C", "C001", "Documento - Resumo Diário das Notas Fiscais de Venda a Consumidor (código 02)", "V", true},
            {"C310", 3, "C", "C300", "Documentos Cancelados de Nota Fiscal de Venda a Consumidor (código 02)", "1:N", true},
            {"C320", 3, "C", "C300", "Registro Analítico das Notas Fiscais de Venda a Consumidor (código 02)", "1:N", true},
            {"C321", 4, "C", "C320", "Itens dos Resumos Diários dos Documentos (código 02)", "1:N", true},
            {"C330", 5, "C", "C321", "Informações complementares das operações de saída de mercadorias sujeitas à substituição tributária (código 02)", "1:1", true},

            {"C350", 2, "C", "C001", "Nota Fiscal de venda a consumidor (código 02)", "V", true},
            {"C370", 3, "C", "C350", "Itens do documento (código 02)", "1:N", true},
            {"C380", 4, "C", "C370", "Informações complementares das operações de saída de mercadorias sujeitas à substituição tributária (código 02)", "1:N", true},
            {"C390", 3, "C", "C350", "Registro Analítico das Notas Fiscais de Venda a Consumidor (código 02)", "1:N", true},

            {"C400", 2, "C", "C001", "Equipamento ECF (códigos 02, 2D e 60)", "V", false},
            {"C405", 3, "C", "C400", "Redução Z (código 02, 2D e 60)", "3", false},
            {"C410", 3, "C", "C400", "PIS e COFINS Totalizados no Dia (código 02 e 2D)", "1:1", false},
            {"C420", 4, "C", "C410", "Registro dos Totalizadores Parciais da Redução Z (código 02, 2D e 60)", "1:N", false},
            {"C425", 5, "C", "C420", "Resumo de itens do movimento diário (código 02 e 2D)", "1:N", false},
            {"C430", 4, "C", "C410", "Informações complementares das operações de saída de mercadorias sujeitas à substituição tributária (código 02, 2D e 60)", "1:N", false},
            {"C460", 4, "C", "C405", "Documento Fiscal Emitido por ECF (código 02, 2D e 60)", "1:N", false},
            {"C465", 5, "C", "C460", "Complemento do Cupom Fiscal Eletrônico Emitido por ECF - CF-e-ECF (código 60)", "1:1", false},
            {"C470", 5, "C", "C460", "Itens do Documento Fiscal Emitido por ECF (código 02 e 2D)", "1:N", false},
            {"C480", 6, "C", "C470", "Informações complementares das operações de saída de mercadorias sujeitas à substituição tributária (código 02 e 2D)", "1:N", false},
            {"C490", 4, "C", "C405", "Registro Analítico do movimento diário (código 02, 2D e 60)", "1:N", false},
            {"C495", 2, "C", "C001", "Resumo Mensal de Itens do ECF por estabelecimento (código 02, 2D e 2E)", "V", false},

            {"C500", 2, "C", "C001", "Nota Fiscal/Conta de Energia Elétrica (código 06), Nota Fiscal/Conta de fornecimento d'água canalizada (código 29) e Nota Fiscal/Conta de Fornecimento de Gás (Código 28)", "V", false},
            {"C510", 3, "C", "C500", "Itens do Documento - Nota Fiscal/Conta de Energia Elétrica (código 06), Nota Fiscal/Conta de fornecimento d'água canalizada (código 29) e Nota Fiscal/Conta Fornecimento de Gás (Código 28)", "1:N", false},
            {"C590", 3, "C", "C500", "Registro Analítico do Documento - Nota Fiscal/Conta de Energia Elétrica (código 06), Nota Fiscal de Energia Elétrica (código 66), Nota Fiscal/Conta de fornecimento d'água canalizada (código 29) e Nota Fiscal/Conta de Fornecimento de Gás (Código 28)", "1:N", false},
            {"C591", 4, "C", "C590", "Informações do Fundo de Combate à Pobreza – FCP – na NF-e (código 66)", "1:1", false},
            {"C595", 3, "C", "C500", "Observações do Lançamento Fiscal (códigos 06, 28, 29 e 66)", "1:N", false},
            {"C597", 4, "C", "C595", "Outras obrigações tributárias, ajustes e informações de valores provenientes de documento fiscal", "1:N", false},

            {"C600", 2, "C", "C001", "Consolidação Diária de Notas Fiscais/Contas de Energia Elétrica (Código 06), Nota Fiscal de Fornecimento de Gás (Código 28) e Nota Fiscal/Conta de Fornecimento d'água (Código 29) e Nota Fiscal/Conta de ICMS 115/03) (Empresas não obrigadas à Convenio ICMS 115/03)", "V", false},
            {"C601", 3, "C", "C600", "Documentos cancelados - Consolidação diária de notas fiscais/contas de energia elétrica (Código 06), nota fiscal/conta de fornecimento d'água (código 29) e nota fiscal/conta de fornecimento de gás (código 28)", "1:N", false},
            {"C610", 3, "C", "C600", "Itens do Documento Consolidado - Notas Fiscais/Contas de Energia Elétrica (Código 06), Nota Fiscal/Conta de fornecimento d'água (código 29) e Nota Fiscal/Conta de Fornecimento de Gás (Código 28) - (Empresas não obrigadas à Convenio ICMS 115/03)", "1:N", false},
            {"C690", 3, "C", "C600", "Registro Analítico dos Documentos - Notas Fiscais/Contas de Energia Elétrica (Código 06), Nota Fiscal/Conta de fornecimento d'água (código 29) e Nota Fiscal/Conta de Fornecimento de Gás (Código 28)", "1:N", false},

            {"C700", 2, "C", "C001", "Consolidação dos Documentos - Nota Fiscal/Conta Energia Elétrica (código 06) emitidas em via única - (Empresas obrigadas à entrega do arquivo previsto no Convênio ICMS 115/03), Nota Fiscal/Conta de Fornecimento de Gás Canalizado (Código 28) e NF-e (Código 55) - Documento Fiscal Eletrônico", "V", false},
            {"C790", 3, "C", "C700", "Registro Analítico dos Documentos (Códigos 06, 28 e 66)", "1:N", false},
            {"C791", 4, "C", "C790", "Registro de informações de ICMS ST por UF (Código 06 e 66)", "1:N", false},

            {"C800", 2, "C", "C001", "Registro Cupom Fiscal Eletrônico - CF-e (Código 59)", "V", false},
            {"C810", 3, "C", "C800", "Itens do documento do cupom fiscal eletrônico - SAT (CF-e-SAT) (código 59)", "1:N", false},
            {"C815", 4, "C", "C810", "Informações complementares das operações de saída de mercadorias sujeitas à substituição tributária (CF-e-SAT) (código 59)", "1:1", false},
            {"C850", 3, "C", "C800", "Registro Analítico do CF-e (Código 59)", "1:N", false},
            {"C855", 3, "C", "C800", "Observações do lançamento fiscal (Código 59)", "1:N", false},
            {"C857", 4, "C", "C855", "Outras obrigações tributárias, ajustes e informações de valores provenientes de documento fiscal", "1:N", false},

            {"C860", 2, "C", "C001", "Identificação do equipamento SAT-CF-e (Código 59)", "V", false},
            {"C870", 3, "C", "C860", "Itens do documento do cupom fiscal eletrônico - SAT (CF-e-SAT) (código 59)", "1:N", false},
            {"C880", 4, "C", "C870", "Informações complementares das operações de saída de mercadorias sujeitas à substituição tributária (CF-e-SAT) (código 59)", "1:N", false},
            {"C890", 3, "C", "C860", "Resumo diário do C-F-E (Código 59) por equipamento SAT-CF-e", "1:N", false},
            {"C895", 3, "C", "C860", "Observações do lançamento fiscal (Código 59)", "1:N", false},
            {"C897", 4, "C", "C895", "Outras obrigações tributárias, ajustes e informações de valores provenientes de documento fiscal", "1:N", false},

            {"C990", 1, "C", "0000", "Encerramento do Bloco C", "1", false},

            // =====================
            // Bloco D
            // =====================

            {"D001", 1, "D", "0000", "Abertura do Bloco D", "1", false},

            {"D100", 2, "D", "D001", "Nota Fiscal de Serviço de Transporte (código 07), Conhecimentos de Transporte Rodoviário de Cargas (código 08), Conhecimentos de Transporte de Cargas Avulso (código 8B), Aquaviário de Cargas (código 09), Aéreo (código 10), Ferroviário de Cargas (código 11), Multimodal de Cargas (código 26), Nota Fiscal de Transporte Ferroviário de Carga (código 27), Conhecimento de Transporte Eletrônico – CT-e (código 57), Conhecimento de Transporte Eletrônico para Outros Serviços – CT-e OS (código 67) e Bilhete de Passagem Eletrônico (código 63)", "V", false},

            {"D101", 3, "D", "D100", "Informação complementar dos documentos fiscais quando das prestações interestaduais destinadas a consumidor final não contribuinte EC 87/15 (código 57 e 67)", "1:1", false},
            {"D110", 3, "D", "D100", "Itens do documento - Nota Fiscal de Serviços de Transporte (código 07)", "1:N", false},
            {"D120", 4, "D", "D110", "Complemento da Nota Fiscal de Serviços de Transporte (código 07)", "1:N", false},
            {"D130", 3, "D", "D100", "Complemento do Conhecimento Rodoviário de Cargas (código 08) e Conhecimento de Transporte de Cargas Avulso (código 8B)", "1:N", false},
            {"D140", 3, "D", "D100", "Complemento do Conhecimento Aquaviário de Cargas (código 09)", "1:1", false},
            {"D150", 3, "D", "D100", "Complemento do Conhecimento Aéreo de Cargas (código 10)", "1:1", false},
            {"D160", 3, "D", "D100", "Carga Transportada (CÓDIGOS 08, 8B, 09, 10, 11, 26 E 27)", "1:N", false},
            {"D161", 4, "D", "D160", "Local de Coleta e Entrega (códigos 08, 8B, 09, 10, 11 e 26)", "1:1", false},
            {"D162", 4, "D", "D160", "Identificação dos documentos fiscais (códigos 08, 8B, 09, 10, 11, 26 e 27)", "1:N", false},
            {"D170", 3, "D", "D100", "Complemento do Conhecimento Multimodal de Cargas (código 26)", "1:1", false},
            {"D180", 3, "D", "D100", "Modais (código 26)", "1:N", false},
            {"D190", 3, "D", "D100", "Registro Analítico dos Documentos (CÓDIGOS 07, 08, 8B, 09, 10, 11, 26, 27, 57 e 67)", "1:N", false},
            {"D195", 3, "D", "D100", "Observações do lançamento (CÓDIGOS 07, 08, 8B, 09, 10, 11, 26, 27, 57 e 67)", "1:N", false},
            {"D197", 4, "D", "D195", "Outras obrigações tributárias, ajustes e informações de valores provenientes de documento fiscal", "1:N", false},

            {"D300", 2, "D", "D001", "Registro Analítico dos bilhetes consolidados de Passagem Rodoviário (código 13), de Passagem Aquaviário (código 14), de Passagem e Nota de Bagagem (código 15) e de Passagem Ferroviário (código 16)", "V", false},
            {"D301", 3, "D", "D300", "Documentos cancelados dos Bilhetes de Passagem Rodoviário (código 13), de Passagem Aquaviário (código 14), de Passagem e Nota de Bagagem (código 15) e de Passagem Ferroviário (código 16)", "1:N", false},
            {"D310", 3, "D", "D300", "Complemento dos Bilhetes (códigos 13, 14, 15 e 16)", "1:N", false},
            {"D350", 2, "D", "D001", "Equipamento ECF (Códigos 2E, 13, 14, 15 e 16)", "V", false},
            {"D355", 3, "D", "D350", "Redução Z (Códigos 2E, 13, 14, 15 e 16)", "1:N", false},
            {"D360", 4, "D", "D355", "PIS e COFINS Totalizados no Dia (Códigos 2E, 13, 14, 15 e 16)", "1:1", false},
            {"D365", 4, "D", "D355", "Registro dos Totalizadores Parciais da Redução Z (Códigos 2E, 13, 14, 15 e 16)", "1:N", false},
            {"D370", 5, "D", "D365", "Complemento dos documentos informados (Códigos 13, 14, 15 e 2E)", "1:N", false},
            {"D390", 4, "D", "D355", "Registro analítico do movimento diário (Códigos 13, 14, 15 e 2E)", "1:N", false},
            {"D400", 2, "D", "D001", "Resumo do Movimento Diário (código 18)", "V", false},
            {"D410", 3, "D", "D400", "Documentos Informados (Códigos 13, 14, 15 e 16)", "1:N", false},
            {"D411", 4, "D", "D410", "Documentos Cancelados dos Documentos Informados (Códigos 13, 14, 15 e 16)", "1:N", false},
            {"D420", 3, "D", "D400", "Complemento dos Documentos Informados (Códigos 13, 14, 15 e 16)", "1:N", false},

            {"D500", 2, "D", "D001", "Nota Fiscal de Serviço de Comunicação (código 21) e Serviço de Telecomunicação (código 22)", "V", false},
            {"D510", 3, "D", "D500", "Itens do Documento - Nota Fiscal de Serviço de Comunicação (código 21) e Serviço de Telecomunicação (código 22)", "1:N", false},
            {"D530", 3, "D", "D500", "Terminal Faturado", "1:N", false},
            {"D590", 3, "D", "D500", "Registro Analítico do Documento (códigos 21 e 22)", "1:N", false},
            {"D600", 2, "D", "D001", "Consolidação da Prestação de Serviços - Notas de Serviço de Comunicação (código 21) e de Serviço de Telecomunicação (código 22)", "V", false},
            {"D610", 3, "D", "D600", "Itens do Documento Consolidado (códigos 21 e 22)", "1:N", false},
            {"D690", 3, "D", "D600", "Registro Analítico dos Documentos (códigos 21 e 22)", "1:N", false},
            {"D695", 2, "D", "D001", "Consolidação da Prestação de Serviços - Notas de Serviço de Comunicação (código 21) e Serviço de Telecomunicação (código 22)", "V", false},
            {"D696", 3, "D", "D695", "Registro Analítico dos Documentos (códigos 21 e 22)", "1:N", false},
            {"D697", 4, "D", "D696", "Registro de informações de outras UFs, relativamente aos serviços “não-medidos” ou assinatura via satélite", "1:N", false},

            {"D700", 2, "D", "D001", "Nota Fiscal Fatura Eletrônica de Serviços de Comunicação – NFCom (Código 62)", "V", false},
            {"D730", 3, "D", "D700", "Registro analítico Nota Fiscal Fatura Eletrônica de Serviços de Comunicação – NFCom (Código 62)", "1:N", false},
            {"D731", 4, "D", "D730", "Informações do fundo de combate à pobreza – FCP – (Código 62)", "1:1", false},
            {"D735", 3, "D", "D700", "Observações do lançamento fiscal (Código 62)", "1:N", false},
            {"D737", 4, "D", "D735", "Outras obrigações tributárias, ajustes e informações de valores provenientes de documento fiscal", "1:N", false},
            {"D750", 2, "D", "D001", "Escrituração consolidada da Nota Fiscal Fatura Eletrônica de Serviços de Comunicação – NFCom (Código 62)", "1:N", false},
            {"D760", 3, "D", "D750", "Registro analítico da escrituração consolidada da Nota Fiscal Fatura Eletrônica de Serviços de Comunicação – NFCom (Código 62)", "1:N", false},
            {"D761", 4, "D", "D760", "Informações do fundo de combate à pobreza FCP – (Código 62)", "1:1", false},

            {"D990", 1, "D", "0000", "Encerramento do Bloco D", "1", false},

            // =====================
            // Bloco E
            // =====================

            {"E001", 1, "E", "0000", "Abertura do Bloco E", "1", true},

            {"E100", 2, "E", "E001", "Período de Apuração do ICMS", "V", true},
            {"E110", 3, "E", "E100", "Apuração do ICMS - Operações Próprias", "1:1", true},
            {"E111", 4, "E", "E110", "Ajuste/Benefício/Incentivo da Apuração do ICMS", "1:N", true},
            {"E112", 5, "E", "E111", "Informações Adicionais dos Ajustes da Apuração do ICMS", "1:N", true},
            {"E113", 5, "E", "E111", "Informações Adicionais dos Ajustes da Apuração do ICMS - Identificação dos documentos fiscais", "1:N", true},
            {"E115", 4, "E", "E110", "Informações Adicionais da Apuração do ICMS - Valores Declaratórios", "1:N", true},
            {"E116", 4, "E", "E110", "Obrigações do ICMS Recolhido ou a Recolher - Operações Próprias", "1:N", true},

            {"E200", 2, "E", "E001", "Período de Apuração do ICMS - Substituição Tributária", "V", true},
            {"E210", 3, "E", "E200", "Apuração do ICMS - Substituição Tributária", "1:1", true},
            {"E220", 4, "E", "E210", "Ajuste/Benefício/Incentivo da Apuração do ICMS - Substituição Tributária", "1:N", true},
            {"E230", 5, "E", "E220", "Informações Adicionais dos Ajustes da Apuração do ICMS Substituição Tributária", "1:N", true},
            {"E240", 5, "E", "E220", "Informações Adicionais dos Ajustes da Apuração do ICMS Substituição Tributária - Identificação dos documentos fiscais", "1:N", true},
            {"E250", 4, "E", "E210", "Obrigações do ICMS Recolhido ou a Recolher - Substituição Tributária", "1:N", true},

            {"E300", 2, "E", "E001", "Período de Apuração do ICMS Diferencial de Alíquota - UF Origem/Destino EC 87/15", "1:N", true},
            {"E310", 3, "E", "E300", "Apuração do ICMS Diferencial de Alíquota - UF Origem/Destino EC 87/15", "1:1", true},
            {"E311", 4, "E", "E310", "Ajuste/Benefício/Incentivo da Apuração do ICMS Diferencial de Alíquota - UF Origem/Destino EC 87/15", "1:N", true},
            {"E312", 5, "E", "E311", "Informações Adicionais dos Ajustes da Apuração do ICMS Diferencial de Alíquota - UF Origem/Destino EC 87/15", "1:N", true},
            {"E313", 5, "E", "E311", "Informações Adicionais da Apuração do ICMS Diferencial de Alíquota - UF Origem/Destino EC 87/15 Identificação dos Documentos Fiscais", "1:N", true},
            {"E316", 4, "E", "E310", "Obrigações do ICMS recolhido ou a recolher - Diferencial de Alíquota - UF Origem/Destino EC 87/15", "1:N", true},

            {"E500", 2, "E", "E001", "Período de Apuração do IPI", "V", false},
            {"E510", 3, "E", "E500", "Consolidação dos Valores de IPI", "3", false},
            {"E520", 3, "E", "E500", "Apuração do IPI", "1:1", false},
            {"E530", 4, "E", "E520", "Ajustes da Apuração do IPI", "1:N", false},
            {"E531", 5, "E", "E530", "Informações Adicionais dos Ajustes da Apuração do IPI - Identificação dos Documentos Fiscais (01 e 55)", "1:N", false},

            {"E990", 1, "E", "0000", "Encerramento do Bloco E", "1", false},

            // =====================
            // Bloco G
            // =====================
            {"G001", 1, "G", "0000", "Abertura do Bloco G", "1", true},
            {"G110", 2, "G", "G001", "ICMS – Ativo Permanente – CIAP", "V", true},
            {"G125", 3, "G", "G110", "Movimentação de Bem do Ativo Imobilizado", "1:N", true},
            {"G126", 4, "G", "G125", "Outros créditos CIAP", "1:N", true},
            {"G130", 4, "G", "G125", "Identificação do documento fiscal", "1:N", true},
            {"G140", 5, "G", "G130", "Identificação do item do documento fiscal", "1:N", true},
            {"G990", 1, "G", "0000", "Encerramento do Bloco G", "1", false},

            // =====================
            // Bloco H
            // =====================
            {"H001", 1, "H", "0000", "Abertura do Bloco H", "1", true},
            {"H005", 2, "H", "H001", "Totais do Inventário", "V", true},
            {"H010", 3, "H", "H005", "Inventário", "1:N", true},
            {"H020", 4, "H", "H010", "Informação complementar do Inventário", "1:N", true},
            {"H030", 4, "H", "H010", "Informações complementares do inventário das mercadorias sujeitas ao regime de substituição tributária", "1:1", true},
            {"H990", 1, "H", "0000", "Encerramento do Bloco H", "1", false},

            // =====================
            // Bloco K
            // =====================

            {"K001", 1, "K", "0000", "Abertura do Bloco K", "1", false},
            {"K010", 2, "K", "K001", "Informação sobre o Tipo de Leiaute (Simplificado / Completo)", "1", false},
            {"K100", 2, "K", "K001", "Período de Apuração ICMS/IPI", "V", false},

            {"K200", 3, "K", "K100", "Estoque Escriturado", "1:N", false},
            {"K210", 3, "K", "K100", "Desmontagem de mercadorias - Item de Origem", "1:N", false},
            {"K215", 4, "K", "K210", "Desmontagem de mercadorias - Item de Destino", "1:N", false},
            {"K220", 3, "K", "K100", "Outras Movimentações Internas entre Mercadorias", "1:N", false},

            {"K230", 3, "K", "K100", "Itens Produzidos", "1:N", false},
            {"K235", 4, "K", "K230", "Insumos Consumidos", "1:N", false},

            {"K250", 3, "K", "K100", "Industrialização Efetuada por Terceiros - Itens Produzidos", "1:N", false},
            {"K255", 4, "K", "K250", "Industrialização em Terceiros – Insumos Consumidos", "1:N", false},

            {"K260", 3, "K", "K100", "Reprocessamento/Reparo de Produto/Insumo", "1:N", false},
            {"K265", 4, "K", "K260", "Reprocessamento/Reparo – Mercadorias Consumidas e/ou Retornadas", "1:N", false},

            {"K270", 3, "K", "K100", "Correção de Apontamento dos Registros K210, K220, K230, K250 e K260", "1:N", false},
            {"K275", 4, "K", "K270", "Correção de Apontamento e Retorno de Insumos dos Registros K215, K220, K235, K255 e K265", "1:N", false},

            {"K280", 3, "K", "K100", "Correção de Apontamento – Estoque Escriturado", "1:N", false},

            {"K290", 3, "K", "K100", "Produção Conjunta – Ordem de Produção", "1:N", false},
            {"K291", 4, "K", "K290", "Produção Conjunta – Itens Produzidos", "1:N", false},
            {"K292", 4, "K", "K290", "Produção Conjunta – Insumos Consumidos", "1:N", false},

            {"K300", 3, "K", "K100", "Produção Conjunta – Industrialização Efetuada por Terceiros – Itens Produzidos", "1:N", false},
            {"K301", 4, "K", "K300", "Produção Conjunta – Industrialização Efetuada por Terceiros – Itens Produzidos Consumidos", "1:N", false},
            {"K302", 4, "K", "K300", "Produção Conjunta – Industrialização Efetuada por Terceiros – Insumos Consumidos", "1:N", false},

            {"K990", 1, "K", "0000", "Encerramento do Bloco K", "1", false},

            // =====================
            // Bloco L
            // =====================
            {"L001", 1, "L", "0000", "Abertura do Bloco L", "1", true},
            {"L100", 2, "L", "L001", "Identificação dos Períodos de Apuração do ICMS", "V", true},
            {"L200", 3, "L", "L100", "Crédito de ICMS do Ativo Permanente – CIAP – Controle por Documento Fiscal", "1:N", true},
            {"L210", 4, "L", "L200", "Controle do Crédito de ICMS do Ativo Permanente – CIAP", "1:N", true},
            {"L990", 1, "L", "0000", "Encerramento do Bloco L", "1", false},

            // =====================
            // Bloco 9
            // =====================
            {"9001", 1, "9", "0000", "Abertura do Bloco 9", "1", false},
            {"9900", 2, "9", "9001", "Registros do Arquivo", "1:N", false},
            {"9990", 1, "9", "0000", "Encerramento do Bloco 9", "1", false},
            {"9999", 0, "9", null, "Encerramento do Arquivo Digital", "1", false}
        }
    )
in
    Fonte;

shared fnFinalDate = let
    Fonte = (txt as nullable any) as nullable date =>
    let
        t = if txt = null then null else Text.Select(Text.From(txt), {"0".."9"}),
        d = if t = null or Text.Length(t) <> 8 then null else
            try #date(
                Number.FromText(Text.End(t, 4)),
                Number.FromText(Text.Middle(t, 2, 2)),
                Number.FromText(Text.Start(t, 2))
            ) otherwise null
    in
        d
in
    Fonte;

shared fnPeriodo = let
    Fonte = (
   ColDate as  date 
)=>
    let
        
        dataTransf = 
        try
            let
                Ano = Text.From(Date.Year(ColDate)),
                Mes = Text.PadStart(Text.From(Date.Month(ColDate)),2,"0"),
                
               Periodo = Number.From(Ano&Mes)
            in
        Periodo
    otherwise null

    in
        dataTransf
in
    Fonte;

shared EFD_Extraida = let
    FolderPath =

        let
            rngTry = try Excel.CurrentWorkbook(){[Name="patch_EFD"]}[Content] otherwise null,
            raw = if rngTry = null then null else try Text.From(rngTry{0}[Column1]) otherwise null,
            v = if raw = null then null else Text.Trim(raw),
            path =
                if v = null or v = "" then
                    error "Configuração ausente: preencha o named range 'rngFolderEFD' com o caminho da pasta dos arquivos SPED."
                else if Text.EndsWith(v, "\") then
                    v
                else
                    v & "\"
        in
            path,

    Source = Folder.Files(FolderPath),

    OnlyTxt = Table.SelectRows(Source, each Text.Lower([Extension]) = ".txt"),

    DuplicateColumnName = Table.DuplicateColumn(OnlyTxt, "Name", "Nome"),

   CombineColumnsPaths = Table.CombineColumns(DuplicateColumnName,{"Folder Path", "Name"},Combiner.CombineTextByDelimiter("", QuoteStyle.None),"Paths"),

    SelectColumnsNomePath = Table.SelectColumns(CombineColumnsPaths,{"Nome", "Paths"}),

    // Blindagem de CPU: Força o processamento do arquivo de forma isolada e trava o resultado tabular na memória
    AddCustomColumnColunaTabelasSped = Table.AddColumn(SelectColumnsNomePath, "ColunaTabelasSped", each Table.Buffer(fnSPEDTabela([Paths]))),

    // 1) Extrai a dataInicial da tabela aninhada (1x por arquivo)
    AddDataInicialArquivo =
        Table.AddColumn(
            AddCustomColumnColunaTabelasSped,
            "dataInicialArquivo",
            (r as record) as nullable date =>
                let
                    t = r[ColunaTabelasSped],
                    d = try List.First(List.RemoveNulls(t[DataInicial])) otherwise null
                in
                    d,
            type date
        ),

    // 2) Ordena os arquivos por essa data
    Ordenado =
        Table.Sort(AddDataInicialArquivo, {{"dataInicialArquivo", Order.Ascending}}),

    AddArquivoId = Table.AddIndexColumn(Ordenado, "ArquivoId", 1, 1, Int64.Type),

    

    RemoveColunas = Table.SelectColumns(AddArquivoId,{"Nome", "ArquivoId", "ColunaTabelasSped"}),

    // 3. EXPANDE TRAZENDO AS COLUNAS DE HIERARQUIA
    Expande = Table.ExpandTableColumn(
        RemoveColunas,
        "ColunaTabelasSped",
        {"LinhaId", "Linha_Pai", "Periodo", "Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8", "Column9", "Column10", "Column11", "Column12", "Column13", "Column14", "Column15", "Column16", "Column17", "Column18", "Column19", "Column20", "Column21", "Column22", "Column23", "Column24", "Column25", "Column26", "Column27", "Column28", "Column29", "Column30", "Column31", "Column32", "Column33", "Column34", "Column35", "Column36", "Column37", "Column38", "Column39", "Column40"},
        {"LinhaId", "Linha_Pai", "Periodo", "C001", "C002", "C003", "C004", "C005", "C006", "C007", "C008", "C009", "C010", "C011", "C012", "C013", "C014", "C015", "C016", "C017", "C018", "C019", "C020", "C021", "C022", "C023", "C024", "C025", "C026", "C027", "C028", "C029", "C030", "C031", "C032", "C033", "C034", "C035", "C036", "C037", "C038", "C039"}
    ),
    
    AlteraTipo = Table.TransformColumnTypes(Expande,{{"LinhaId", Int64.Type}, {"Linha_Pai", Int64.Type}}),

    // =================================================================
    // 4. A FABRICAÇÃO DAS CHAVES RELACIONAIS
    // =================================================================
    
    // -> Chave Primária (Primary Key): ID do Arquivo + ID da Linha
    AdicionaChaveLinha = Table.AddColumn(AlteraTipo, "Chave_Linha", each Text.From([ArquivoId]) & "-" & Text.From([LinhaId]), type text),
    
    // -> Chave Estrangeira (Foreign Key): ID do Arquivo + ID da Linha do Pai
    AdicionaChavePai = Table.AddColumn(AdicionaChaveLinha, "Chave_Pai", each if [Linha_Pai] <> null then Text.From([ArquivoId]) & "-" & Text.From([Linha_Pai]) else null, type text),
    
  // ... restante do código acima ...
    // 5. LIMPEZA FINAL
    RemoveTemporarias = Table.RemoveColumns(AdicionaChavePai,{"Linha_Pai"}),
    Reordena01 = Table.ReorderColumns(RemoveTemporarias,{"Nome", "Periodo", "ArquivoId", "LinhaId", "Chave_Linha", "Chave_Pai", "C001", "C002", "C003", "C004", "C005", "C006", "C007", "C008", "C009", "C010", "C011", "C012", "C013", "C014", "C015", "C016", "C017", "C018", "C019", "C020", "C021", "C022", "C023", "C024", "C025", "C026", "C027", "C028", "C029", "C030", "C031", "C032", "C033", "C034", "C035", "C036", "C037", "C038", "C039"}),

    // =================================================================
    // 6. BLINDAGEM CONTRA N+1 (COMPARTILHAMENTO DE CACHE)
    // =================================================================
    // Força o Mashup Engine a ler os 50 arquivos UMA única vez.
    // As tabelas R0000, R0150, etc., lerão instantaneamente desta RAM.
    Staging_Na_Memoria = Reordena01
in
    Staging_Na_Memoria;

shared fnSPEDTabela = let
    Fonte = (path as text) =>
    let
        // ====================================================================
        // 1. LEITURA FÍSICA OTIMIZADA VIA STREAMING (BLINDAGEM I/O)
        // ====================================================================
        Binario = Binary.Buffer(File.Contents(path)), 
        // O Binary.Buffer evita que o Mashup Engine vá ao disco múltiplas vezes pelo mesmo txt
        Tabela = Csv.Document(Binario,[Delimiter="|", Columns=40, Encoding=1252, QuoteStyle=QuoteStyle.None]),

        // ====================================================================
        // 2. EXTRAÇÃO DE METADADOS DO ARQUIVO (0000)
        // ... restante do código inalterado ...
        // ====================================================================
        Row0000 =
        try
            Table.First(
                Table.SelectRows(
                    Tabela,
                    each
                        let r = try Text.Upper(Text.Trim(Text.From([Column2]))) otherwise null
                        in r = "0000"
                )
            )
        otherwise
            null,

        DtIniTxt =
            if Row0000 = null then null
            else try Text.Trim(Text.From(Record.Field(Row0000, "Column5"))) otherwise null,

        DataInicial =
            if DtIniTxt = null or DtIniTxt = "" then null
            else if Text.Length(DtIniTxt) = 8 then fnFinalDate(DtIniTxt)
            else try Date.From(DtIniTxt) otherwise null,

        Periodo = fnPeriodo(DataInicial), 

        // ====================================================================
        // 3. LIMPEZA (FILTRO DE ASSINATURAS E LINHAS INVÁLIDAS)
        // ====================================================================
        SemLixo =
            Table.SelectRows(
                Tabela,
                each
                    let
                        r = try Text.Upper(Text.Trim(Text.From([Column2]))) otherwise null,
                        okLen = r <> null and Text.Length(r) = 4,
                        okChar =
                            okLen and
                            (
                                (Text.Select(r, {"0".."9"}) <> "" and Text.Start(r, 1) >= "0" and Text.Start(r, 1) <= "9")
                                or
                                (Text.Start(r, 1) >= "A" and Text.Start(r, 1) <= "Z")
                            )
                    in
                        okChar
            ),

        AddDataInicial = Table.AddColumn(SemLixo, "DataInicial", each DataInicial, type date),
        AddPeriodo = Table.AddColumn(AddDataInicial, "Periodo", each Periodo, type text),

        // ====================================================================
        // 4. PREPARAÇÃO DA HIERARQUIA
        // ====================================================================
        AddLinhaId = Table.AddIndexColumn(AddPeriodo, "LinhaId", 1, 1, Int64.Type),

        // Busca o nível do registro na tabela Meta
        JoinMeta = Table.NestedJoin(AddLinhaId, {"Column2"}, Meta_Registros, {"Registro"}, "Meta", JoinKind.LeftOuter),
        ExpandMeta = Table.ExpandTableColumn(JoinMeta, "Meta", {"Nivel"}, {"Nivel"}),

        // ⚠️ GARANTIA DE ORDENAÇÃO: Impede que o Join anterior bagunce o FillDown
        SortFisico = Table.Sort(ExpandMeta, {{"LinhaId", Order.Ascending}}),

        // ====================================================================
        // 5. O MOTOR DE HIERARQUIA (SCD TIPO 2 - PARENT/CHILD)
        // ====================================================================
        // Criação das Gavetas apontando para a tabela ordenada (SortFisico)
        L0 = Table.AddColumn(SortFisico, "L0", each if [Nivel] = 0 then [LinhaId] else null, Int64.Type),
        L1 = Table.AddColumn(L0, "L1", each if [Nivel] = 1 then [LinhaId] else null, Int64.Type),
        L2 = Table.AddColumn(L1, "L2", each if [Nivel] = 2 then [LinhaId] else null, Int64.Type),
        L3 = Table.AddColumn(L2, "L3", each if [Nivel] = 3 then [LinhaId] else null, Int64.Type),
        L4 = Table.AddColumn(L3, "L4", each if [Nivel] = 4 then [LinhaId] else null, Int64.Type),
        L5 = Table.AddColumn(L4, "L5", each if [Nivel] = 5 then [LinhaId] else null, Int64.Type),
        L6 = Table.AddColumn(L5, "L6", each if [Nivel] = 6 then [LinhaId] else null, Int64.Type),

        // Preenchimento Global para baixo
        Preenche = Table.FillDown(L6, {"L0", "L1", "L2", "L3", "L4", "L5", "L6"}),

        // Define a Linha_Pai baseada na gaveta do nível imediatamente anterior
        AdcPai = Table.AddColumn(Preenche, "Linha_Pai", each 
            if [Nivel] = null or [Nivel] = 0 then null
            else if [Nivel] = 1 then [L0]
            else if [Nivel] = 2 then [L1]
            else if [Nivel] = 3 then [L2]
            else if [Nivel] = 4 then [L3]
            else if [Nivel] = 5 then [L4]
            else if [Nivel] = 6 then [L5]
            else null, Int64.Type
        ),

        // ====================================================================
        // 6. LIMPEZA E FORMATAÇÃO FINAL
        // ====================================================================
        Limpeza = Table.RemoveColumns(AdcPai, {"Nivel", "L0", "L1", "L2", "L3", "L4", "L5", "L6"}),

        Reordenadas = Table.ReorderColumns(Limpeza,{"LinhaId", "Linha_Pai", "DataInicial", "Periodo", "Column1", "Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8", "Column9", "Column10", "Column11", "Column12", "Column13", "Column14", "Column15", "Column16", "Column17", "Column18", "Column19", "Column20", "Column21", "Column22", "Column23", "Column24", "Column25", "Column26", "Column27", "Column28", "Column29", "Column30", "Column31", "Column32", "Column33", "Column34", "Column35", "Column36", "Column37", "Column38", "Column39", "Column40"})
    in
        Reordenadas
in
    Fonte;

shared EFD_TotalLinha = let
    Total = Table.RowCount(EFD_Extraida)
in
    Total;

shared Linhas_por_Arquivo = let
    t = EFD_Extraida,
    g = Table.Group(t, {"Periodo"}, {{"Linhas", each Table.RowCount(_), Int64.Type}}),
    s = Table.Sort(g, {{"Linhas", Order.Ascending}})
in
    s;

shared SomenteProblemas = let
    FolderPath =
        let
            rngTry = try Excel.CurrentWorkbook(){[Name="patch_EFD"]}[Content] otherwise null,
            raw = if rngTry = null then null else try Text.From(rngTry{0}[Column1]) otherwise null,
            v = if raw = null then null else Text.Trim(raw),
            path = if Text.EndsWith(v, "\") then v else v & "\"
        in
            path,

    Source = Folder.Files(FolderPath),
    OnlyTxt = Table.SelectRows(Source, each Text.Lower([Extension]) = ".txt"),
    AddPaths = Table.AddColumn(OnlyTxt, "Paths", each [Folder Path] & [Name], type text),

    Teste =
        Table.AddColumn(
            AddPaths,
            "Retorno_fnSPEDTabela",
            each
                let
                    r = try fnSPEDTabela([Paths])
                in
                    if r[HasError] then
                        "ERRO: " & r[Error][Message]
                    else if Value.Is(r[Value], type table) then
                        "OK (table) - linhas=" & Text.From(Table.RowCount(r[Value]))
                    else
                        "RETORNO NÃO É TABELA: " & Text.From(r[Value]),
            type text
        ),

    SomenteProblemas = Table.SelectRows(Teste, each Text.StartsWith([Retorno_fnSPEDTabela], "ERRO") or Text.StartsWith([Retorno_fnSPEDTabela], "RETORNO NÃO É TABELA"))
in
    SomenteProblemas;

shared Layouts_Index = let
    // Layouts_Index (catálogo de layouts prontos)
    // Cada layout é uma query separada: Layout_0000, Layout_C100, Layout_C170, etc.

    Itens = {
        { "0000", Layout_0000 },
        { "0001", Layout_0001 },
        { "0015", Layout_0015 },
        { "0150", Layout_0150 },
        { "0175", Layout_0175 },
        { "0190", Layout_0190 },
        { "0200", Layout_0200 },
        { "0205", Layout_0205 },
        { "C100", Layout_C100 }
        // { "0002", Layout_0002 },
        // { "C170", Layout_C170 }
    },

    T =
        #table(
            type table [Registro = text, Layout = nullable record],
            Itens
        )
in
    T;

shared Layout_0000 = let
    // Layout do Registro 0000 (SPED EFD ICMS/IPI)
    // Pos = número do campo conforme documentação oficial (campo 02 = Pos 2)

    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    L0000 =
        [
            Registro = "0000",
            Fields = {
                Field("COD_VER",     2,  "text"),
                Field("COD_FIN",     3,  "text"),
                Field("DT_INI",      4,  "date8"),
                Field("DT_FIN",      5,  "date8"),
                Field("NOME",        6,  "text"),
                Field("CNPJ",        7,  "text"),
                Field("CPF",         8,  "text"),
                Field("UF",          9,  "text"),
                Field("IE",          10, "text"),
                Field("COD_MUN",     11, "text"),   // manter text para não perder zeros à esquerda
                Field("IM",          12, "text"),
                Field("SUFRAMA",     13, "text"),
                Field("IND_PERFIL",  14, "text"),
                Field("IND_ATIV",    15, "text")
            },
            Derivados = {
                Deriv(
                    "FINALIDADE",
                    "text",
                    (r as record) as any =>
                        let c = try Text.From(r[COD_FIN]) otherwise null
                        in
                            if c = "0" then "Remessa do arquivo original"
                            else if c = "1" then "Remessa do arquivo substituto"
                            else if c = "2" then "Remessa do arquivo retificador"
                            else null
                ),
                Deriv(
                    "ATIVIDADE",
                    "text",
                    (r as record) as any =>
                        let a = try Text.From(r[IND_ATIV]) otherwise null
                        in
                            if a = "0" then "Industrial ou equiparado a industrial"
                            else if a = "1" then "Outros"
                            else null
                )
            }
        ]
in
    L0000;

shared Layout_0001 = let
    // Layout do Registro 0015 (SPED EFD ICMS/IPI)
    // Pos = número do campo conforme documentação oficial (campo 02 = Pos 2)

    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    L0001 =
        [
            Registro = "0001",
            Fields = {
                Field("IND_MOV", 2, "text")
                
            },
            Derivados = {
                Deriv(
                    "MOVIMENTO",
                    "text",
                    (r as record) as any =>
                        let c = try Text.From(r[IND_MOV]) otherwise null
                        in
                            if c = "0" then "Bloco com dados informados"
                            else if c = "1" then "Bloco sem dados informados"
                            else null
                )
            }
        ]
in
    L0001;

shared fnParseKind = (v as any, kind as text) as any =>
let
    t0 = try Text.Trim(Text.From(v)) otherwise null,
    t  = if t0 = "" then null else t0,
    k  = if kind = null then "text" else Text.Lower(Text.Trim(kind)),

    // helpers num pt-BR
    ToNumPt = (s as nullable text, dec as number) as nullable number =>
        let
            x0 = if s = null then null else Text.Trim(s),
            x1 = if x0 = null or x0 = "" then null else x0,
            // remove separador de milhar '.' e troca decimal ',' por '.'
            x2 = if x1 = null then null else Text.Replace(Text.Replace(x1, ".", ""), ",", "."),
            n  = if x2 = null then null else try Number.FromText(x2, "en-US") otherwise null,
            out = if n = null then null else Number.Round(n, dec)
        in
            out,

    Out =
        if t = null then null
        else if k = "text" then t

        else if k = "int" then
            try Int64.From(Number.FromText(t, "en-US")) otherwise try Int64.From(Number.FromText(Text.Replace(t, ",", "."), "en-US")) otherwise null

        else if k = "date8" then
            // espera "ddmmaaaa" (8 chars)
            if Text.Length(t) <> 8 then null
            else
                let
                    dd = try Number.FromText(Text.Start(t, 2), "en-US") otherwise null,
                    mm = try Number.FromText(Text.Range(t, 2, 2), "en-US") otherwise null,
                    yy = try Number.FromText(Text.End(t, 4), "en-US") otherwise null
                in
                    if dd = null or mm = null or yy = null then null else try #date(yy, mm, dd) otherwise null

        else if k = "num_pt" then ToNumPt(t, 0)
        else if k = "num_pt_2" then ToNumPt(t, 2)
        else if k = "num_pt_3" then ToNumPt(t, 3)
        else if k = "num_pt_4" then ToNumPt(t, 4)
        else if k = "num_pt_5" then ToNumPt(t, 5)

        else t
in
    Out;

shared fnExtraiRegistro = (EFD as table, registro as text) as table =>
let
    registroNorm = Text.Upper(Text.Trim(registro)),

    // ===== Layout =====
    row =
        try
            Table.First(
                Table.SelectRows(
                    Layouts_Index,
                    each Text.Upper(Text.Trim([Registro])) = registroNorm
                )
            )
        otherwise
            null,

    layout = if row = null then null else row[Layout],

    Out =
        if layout = null then
            #table(type table [], {})
        else
            let
                cols = Table.ColumnNames(EFD),

            // ===== Filtra REG = C001 =====
                Base0 = Table.SelectRows(EFD, each [C001] = registroNorm),

                // ===== Keys (somente as que existirem) =====
                WantedKeys = {"Nome","Periodo","ArquivoId","LinhaId","Chave_Linha","Chave_Pai"},
                KeepKeys = List.Select(WantedKeys, each List.Contains(cols, _)),

                // ===== Raw C columns (precisamos delas para extrair os campos) =====
                KeepRawC = List.Select(cols, each Text.StartsWith(_, "C")),

                // ===== Layout lists (limpa itens inválidos) =====
                rawFields = try layout[Fields] otherwise {},
                rawDerivs = try layout[Derivados] otherwise {},

                fields =
                    List.Select(
                        rawFields,
                        each
                            _ <> null
                            and Record.HasFields(_, {"Name","Pos","Kind"})
                            and _[Name] <> null
                            and Text.Trim(Text.From(_[Name])) <> ""
                    ),

                derivs =
                    List.Select(
                        rawDerivs,
                        each
                            _ <> null
                            and Record.HasFields(_, {"Name","Kind","Fn"})
                            and _[Name] <> null
                            and Text.Trim(Text.From(_[Name])) <> ""
                            and Value.Is(_[Fn], type function)
                    ),

                FieldNames = List.Transform(fields, each Text.From(_[Name])),
                DerivNames = List.Transform(derivs, each Text.From(_[Name])),

                // ===== Base de trabalho: KEYS + Cxxx (depois removemos Cxxx no final) =====
                Base =
                    Table.SelectColumns(
                        Base0,
                        List.Distinct(List.Combine({KeepKeys, KeepRawC})),
                        MissingField.UseNull
                    ),

                // ===== Materializa Fields (Pos -> C{Pos}) =====
                AddFields =
                    List.Accumulate(
                        fields,
                        Base,
                        (state as table, f as record) =>
                            let
                                nm   = Text.From(f[Name]),
                                pos  = Number.From(f[Pos]),
                                kind = Text.From(f[Kind]),
                                col  = "C" & Text.PadStart(Text.From(pos), 3, "0")
                            in
                                Table.AddColumn(
                                    state,
                                    nm,
                                    each fnParseKind(try Record.Field(_, col) otherwise null, kind),
                                    type any
                                )
                    ),

                // ===== Derivados (record limpo = só Fields) =====
                AddDerivs =
                    List.Accumulate(
                        derivs,
                        AddFields,
                        (state as table, d as record) =>
                            let
                                nm   = Text.From(d[Name]),
                                kind = Text.From(d[Kind]),
                                fn   = d[Fn]
                            in
                                Table.AddColumn(
                                    state,
                                    nm,
                                    each
                                        let
                                            r0 = Record.SelectFields(_, FieldNames, MissingField.UseNull),
                                            v  = try fn(r0)
                                        in
                                            if v[HasError] then null else fnParseKind(v[Value], kind),
                                    type any
                                )
                    ),

                // ===== Tipagem final (colunas do layout + derivadas) =====
                KindToType = (k as any) as type =>
                    let
                        kk = if k = null then "" else Text.Lower(Text.Trim(Text.From(k)))
                    in
                        if kk = "text" then type text
                        else if kk = "date8" then type date
                        else if kk = "int" then Int64.Type
                        else if Text.StartsWith(kk, "num_pt") then type number
                        else type any,

                TypePairs_Fields = List.Transform(fields, each { Text.From(_[Name]), KindToType(_[Kind]) }),
                TypePairs_Derivs = List.Transform(derivs, each { Text.From(_[Name]), KindToType(_[Kind]) }),

                Typed =
                    Table.TransformColumnTypes(
                        AddDerivs,
                        List.Combine({TypePairs_Fields, TypePairs_Derivs}),
                        "pt-BR"
                    ),

                // ===== Seleção final (remove Cxxx e qualquer coisa fora do layout) =====
                FinalCols = List.Distinct(List.Combine({KeepKeys, FieldNames, DerivNames})),
                Final = Table.SelectColumns(Typed, FinalCols, MissingField.UseNull)
            in
                Final
in
    Out;

shared R0000_base = let
    R0000_Base = fnExtraiRegistro(EFD_Extraida, "0000")
in
    R0000_Base;

shared schemaAuxiliares = let
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
    Schema;

shared fnValidarSchemaAuxiliares = (Schema as table) as table =>
let
    // espera colunas: Tabela, Coluna, Tipo, Chave, Nullable, Descricao (Descricao opcional)
    Schema2 =
        Table.TransformColumnTypes(
            Schema,
            {
                {"Tabela", type text},
                {"Coluna", type text},
                {"Tipo", type text},
                {"Chave", type text},
                {"Nullable", type logical}
            },
            "pt-BR"
        ),

    // lista tabelas distintas citadas no schema
    Tabelas = List.Distinct(Schema2[Tabela]),

    // para cada tabela, pega a lista real de colunas via #shared
    CheckPorTabela =
        List.Transform(
            Tabelas,
            (t as text) =>
                let
                    obj = try Record.Field(#shared, t) otherwise null,
                    isTable = obj <> null and Value.Is(obj, type table),
                    colsReais = if isTable then Table.ColumnNames(obj) else {},
                    // schema esperado daquela tabela
                    schT = Table.SelectRows(Schema2, each [Tabela] = t),
                    // valida existência das colunas
                    add =
                        Table.AddColumn(
                            schT,
                            "ExisteNaTabela",
                            each List.Contains(colsReais, [Coluna]),
                            type logical
                        ),
                    // marca erro quando tabela não existe ou coluna não existe
                    add2 =
                        Table.AddColumn(
                            add,
                            "Erro",
                            each
                                if not isTable then "Tabela não existe no contexto: " & t
                                else if [ExisteNaTabela] <> true then "Coluna não existe na tabela"
                                else null,
                            type text
                        )
                in
                    add2
        ),

    Unificado = Table.Combine(CheckPorTabela),
    ApenasErros = Table.SelectRows(Unificado, each [Erro] <> null)
in
    ApenasErros;

shared QA_SchemaAuxiliares = let
    Erros = fnValidarSchemaAuxiliares(schemaAuxiliares)
in
    Erros;

shared R0001_base = let
    R0001_Base = fnExtraiRegistro(EFD_Extraida, "0001")
in
    R0001_Base;

shared Layout_0015 = let
    // Layout do Registro 0015 (SPED EFD ICMS/IPI)
    // Pos = número do campo conforme documentação oficial (campo 02 = Pos 2)

    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    L0015 =
        [
            Registro = "0015",
            Fields = {
                Field("UF_ST", 2, "text"),
                Field("IE_ST", 3, "text")
            },
            Derivados = {}
        ]
in
    L0015;

shared R0015_base = let
    R0015_Base = fnExtraiRegistro(EFD_Extraida, "0015")
in
    R0015_Base;

shared Layout_0150 = let
    // ======================================================
    // Layout_0150 — Tabela de Cadastro do Participante
    // Regra do projeto:
    //   Pos = número do campo conforme documentação oficial SPED
    //   Pos mapeia diretamente para C{Pos} na staging (EFD_Extraida)
    // ======================================================

    // Helpers
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    // ======================================================
    // Registro 0150
    //
    // Campo 01 = REG  "0150"
    // Campo 02 = COD_PART
    // Campo 03 = NOME
    // Campo 04 = COD_PAIS
    // Campo 05 = CNPJ
    // Campo 06 = CPF
    // Campo 07 = IE
    // Campo 08 = COD_MUN
    // Campo 09 = SUFRAMA
    // Campo 10 = END
    // Campo 11 = NUM
    // Campo 12 = COMPL
    // Campo 13 = BAIRRO
    //
    // Observação técnica:
    // COD_MUN como "text" facilita enriquecimento posterior com tb_municipios (chave textual),
    // e preserva zeros à esquerda (se houver).
    // ======================================================
    L0150 =
        [
            Registro = "0150",
            Fields = {
                Field("COD_PART", 2, "text"),
                Field("NOME", 3, "text"),
                Field("COD_PAIS", 4, "text"),
                Field("CNPJ", 5, "text"),
                Field("CPF", 6, "text"),
                Field("IE", 7, "text"),
                Field("COD_MUN", 8, "text")
                
            },
            Derivados = {}
        ]
in
    L0150;

shared R0150_base = let
    R0150_Base = fnExtraiRegistro(EFD_Extraida, "0150")
in
    R0150_Base;

shared Layout_0175 = let
    // Layout do Registro 0175 (SPED EFD ICMS/IPI)
    // Pos = número do campo conforme documentação oficial (campo 02 = Pos 2)

    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    L0175 =
        [
            Registro = "0175",
            Fields = {
                Field("DT_ALT", 2, "date8"),
                Field("NR_CAMPO", 3, "text"),
                Field("CONT_ANT", 4, "text")
                
            },
            Derivados = {}
        ]
in
    L0175;

shared R0175_base = let
    R0175_Base = fnExtraiRegistro(EFD_Extraida, "0175")
in
    R0175_Base;

shared tb_participantes = let
    // ========================================================================
    // 1. CARREGAMENTO LEVE E EARLY COLUMN PRUNING 
    // ========================================================================
    Base0150 = Table.SelectColumns(R0150_base, {"ArquivoId", "Chave_Linha", "COD_PART", "NOME", "COD_PAIS", "COD_MUN", "IE", "CNPJ", "CPF"}, MissingField.Ignore),
    
    // BLINDAGEM: Buffer no lado DIREITO do Join (Impede a releitura do disco)
    Base0000_Buf = Table.Buffer(Table.SelectColumns(R0000_base, {"ArquivoId", "DT_INI", "DT_FIN"}, MissingField.Ignore)),

    Base0175_Raw = Table.SelectColumns(R0175_base, {"Chave_Pai", "DT_ALT", "NR_CAMPO", "CONT_ANT"}, MissingField.Ignore),
    Base0175 = Table.SelectRows(Base0175_Raw, each [NR_CAMPO] = "05" or [NR_CAMPO] = "06" or [NR_CAMPO] = "5" or [NR_CAMPO] = "6"),
    R0175_Norm = Table.AddColumn(Base0175, "NR_CAMPO_NORM", each if [NR_CAMPO] = null then "" else Text.PadStart(Text.Trim(Text.From([NR_CAMPO])), 2, "0"), type text),

    // BLINDAGEM: Buffer no lado DIREITO do Join
    R0175_Buf = Table.Buffer(R0175_Norm),

    // ========================================================================
    // 2. MESCLAGEM PRINCIPAL (Hash Joins puros em memória)
    // ========================================================================
    Join0000 = Table.NestedJoin(Base0150, {"ArquivoId"}, Base0000_Buf, {"ArquivoId"}, "R0000", JoinKind.Inner),
    Expand0000 = Table.ExpandTableColumn(Join0000, "R0000", {"DT_INI", "DT_FIN"}, {"DT_INI", "DT_FIN"}),
    Validos0150 = Table.SelectRows(Expand0000, each [DT_INI] <> null and [DT_FIN] <> null),

    Join0175 = Table.NestedJoin(Validos0150, {"Chave_Linha"}, R0175_Buf, {"Chave_Pai"}, "Tabela0175", JoinKind.LeftOuter),

    // ========================================================================
    // 3. MOTOR SCD2 (Restante igual...)
    // ========================================================================
    ResolveMes = Table.AddColumn(Join0175, "TimelineMes", each 
        let
            t0175 = [Tabela0175], TemAlteracao = t0175 <> null and not Table.IsEmpty(t0175),
            BaseRec = [COD_PART = [COD_PART], NOME = [NOME], COD_PAIS = [COD_PAIS], COD_MUN = [COD_MUN], IE = [IE]],
            Out = if not TemAlteracao then
                { Record.Combine({BaseRec, [CNPJ = [CNPJ], CPF = [CPF], DataInicial = [DT_INI], DataFinal = [DT_FIN]]}) }
            else
                let
                    LinhaCNPJ = try Table.SelectRows(t0175, (x) => x[NR_CAMPO_NORM] = "05"){0} otherwise null,
                    LinhaCPF  = try Table.SelectRows(t0175, (x) => x[NR_CAMPO_NORM] = "06"){0} otherwise null,
                    DtAltCNPJ = if LinhaCNPJ <> null then LinhaCNPJ[DT_ALT] else null,
                    AntCNPJ   = if LinhaCNPJ <> null then LinhaCNPJ[CONT_ANT] else null,
                    DtAltCPF  = if LinhaCPF <> null then LinhaCPF[DT_ALT] else null,
                    AntCPF    = if LinhaCPF <> null then LinhaCPF[CONT_ANT] else null,
                    Marcos = List.Sort(List.Distinct(List.RemoveNulls({[DT_INI], DtAltCNPJ, DtAltCPF, Date.AddDays([DT_FIN], 1)}))),
                    Intervalos = List.Transform({0..List.Count(Marcos)-2}, (i) => [Start = Marcos{i}, End = Date.AddDays(Marcos{i+1}, -1)]),
                    Fatias = List.Transform(Intervalos, (inv) => Record.Combine({BaseRec, [CNPJ = if DtAltCNPJ <> null and inv[Start] < DtAltCNPJ then AntCNPJ else [CNPJ], CPF = if DtAltCPF <> null and inv[Start] < DtAltCPF then AntCPF else [CPF], DataInicial = inv[Start], DataFinal = inv[End]]}))
                in Fatias
        in Out, type list),

    RemoveSobras = Table.SelectColumns(ResolveMes, {"TimelineMes"}),
    ExpandeLista = Table.ExpandListColumn(RemoveSobras, "TimelineMes"),
    ExpandeRecords = Table.ExpandRecordColumn(ExpandeLista, "TimelineMes", {"COD_PART", "NOME", "COD_PAIS", "COD_MUN", "IE", "CNPJ", "CPF", "DataInicial", "DataFinal"}),
    Ordenado = Table.Sort(ExpandeRecords, {{"COD_PART", Order.Ascending}, {"DataInicial", Order.Ascending}}),
    Consolidado = Table.Group(Ordenado, {"COD_PART", "NOME", "COD_PAIS", "COD_MUN", "IE", "CNPJ", "CPF"}, {{"DataInicial", each List.Min([DataInicial]), type date}, {"DataFinal", each List.Max([DataFinal]), type date}}, GroupKind.Local),

    AddTipoDoc = Table.AddColumn(Consolidado, "TIPO DOC", each if [CNPJ] <> null and Text.Trim([CNPJ]) <> "" then "CNPJ" else if [CPF] <> null and Text.Trim([CPF]) <> "" then "CPF" else "EXTERIOR", type text),
    AddNumDoc = Table.AddColumn(AddTipoDoc, "Numero DOC", each if [#"TIPO DOC"] = "CNPJ" then [CNPJ] else if [#"TIPO DOC"] = "CPF" then [CPF] else "EXTERIOR", type text),

    BufMunicipios = Table.Buffer(Table.SelectColumns(tb_municipios, {"Codigo_Municipio", "Nome_Municipio"}, MissingField.Ignore)),
    BufPais = Table.Buffer(Table.SelectColumns(tb_3_2_1_pais, {"COD_PAIS", "NOME_PAIS"}, MissingField.Ignore)),
    JoinMunicipios = Table.NestedJoin(AddNumDoc, {"COD_MUN"}, BufMunicipios, {"Codigo_Municipio"}, "Mun", JoinKind.LeftOuter),
    ExpandMunicipios = Table.ExpandTableColumn(JoinMunicipios, "Mun", {"Nome_Municipio"}, {"MUNICIPIO"}),
    JoinPais = Table.NestedJoin(ExpandMunicipios, {"COD_PAIS"}, BufPais, {"COD_PAIS"}, "PaisTbl", JoinKind.LeftOuter),
    ExpandPais = Table.ExpandTableColumn(JoinPais, "PaisTbl", {"NOME_PAIS"}, {"PAIS"}), 
    FinalCols = Table.SelectColumns(ExpandPais, {"COD_PART", "NOME", "TIPO DOC", "Numero DOC", "IE", "MUNICIPIO", "PAIS", "DataInicial", "DataFinal"}),
    TipagemFinal = Table.TransformColumnTypes(FinalCols, {{"COD_PART", type text}, {"NOME", type text}, {"TIPO DOC", type text}, {"Numero DOC", type text}, {"IE", type text}, {"MUNICIPIO", type text}, {"PAIS", type text}, {"DataInicial", type date}, {"DataFinal", type date}}, "pt-BR")
in
    TipagemFinal;

shared Diag_0150_0175_MudancaDocumento = let
    Fonte = Table.NestedJoin(R0000_base, {"Chave_Linha"}, R0001_base, {"Chave_Pai"}, "R0001_base", JoinKind.Inner),

    RemoveCols01 = Table.RemoveColumns(
        Fonte,
        {"Nome", "Periodo", "ArquivoId", "LinhaId", "Chave_Linha", "Chave_Pai",
         "COD_VER", "COD_FIN", "NOME", "CNPJ", "CPF", "UF", "IE",
         "COD_MUN", "IM", "SUFRAMA", "IND_PERFIL", "IND_ATIV",
         "FINALIDADE", "ATIVIDADE"}
    ),

    ExpandeR0001 = Table.ExpandTableColumn(
        RemoveCols01,
        "R0001_base",
        {"Chave_Linha"},
        {"R0001_base.Chave_Linha"}
    ),

    MesclaR0001_R0150 = Table.NestedJoin(
        ExpandeR0001,
        {"R0001_base.Chave_Linha"},
        R0150_base,
        {"Chave_Pai"},
        "R0150_base",
        JoinKind.Inner
    ),

    ExpandeR0150 = Table.ExpandTableColumn(
        MesclaR0001_R0150,
        "R0150_base",
        {"Nome", "Periodo", "Chave_Linha", "COD_PART", "CNPJ"},
        {"R0150_base.Nome", "R0150_base.Periodo", "R0150_base.Chave_Linha",
         "R0150_base.COD_PART", "R0150_base.CNPJ"}
    ),

    // 🔎 FILTRO ANTES DO JOIN (Alta performance)
    R0175_Filtrado =
        Table.SelectRows(
            R0175_base,
            each
                let v = try Text.Trim(Text.From([NR_CAMPO])) otherwise null
                in v = "05" or v = "06" or v = "5" or v = "6"
        ),

    MesclaR0150_R0175 = Table.NestedJoin(
        ExpandeR0150,
        {"R0150_base.Chave_Linha"},
        R0175_Filtrado,
        {"Chave_Pai"},
        "R0175_base",
        JoinKind.Inner
    ),

    RemoveCols02 = Table.RemoveColumns(
        MesclaR0150_R0175,
        {"R0001_base.Chave_Linha", "R0150_base.Nome", "R0150_base.Chave_Linha"}
    ),

    ExpandeR0175 = Table.ExpandTableColumn(
        RemoveCols02,
        "R0175_base",
        {"DT_ALT", "NR_CAMPO", "CONT_ANT"},
        {"R0175_base.DT_ALT", "R0175_base.NR_CAMPO", "R0175_base.CONT_ANT"}
    ),

    Renomea = Table.RenameColumns(
        ExpandeR0175,
        {
            {"DT_INI", "DT_INI_R0000"},
            {"DT_FIN", "DT_FIN_R0000"},
            {"R0150_base.Periodo", "PERIODO_R0150"},
            {"R0150_base.COD_PART", "COD_PART_R0150"},
            {"R0150_base.CNPJ", "CNPJ_R0150"},
            {"R0175_base.DT_ALT", "DT_ALT_R0175"},
            {"R0175_base.NR_CAMPO", "NR_CAMPO_R0175"},
            {"R0175_base.CONT_ANT", "CONT_ANT_R0175"}
        }
    )
in
    Renomea;

shared Diag_CNPJ_Inumeros_CodPart = let
    // =========================================================
    // QA: CNPJs associados a mais de um COD_PART (na cadeia 0000->0001->0150)
    // Retorna TODAS as combinações (CNPJ, COD_PART) apenas para CNPJs "problemáticos".
    // =========================================================

    // 1) Column pruning (performance)
    R0000_Min = Table.SelectColumns(R0000_base, {"Chave_Linha", "DT_INI", "DT_FIN"}),
    R0001_Min = Table.SelectColumns(R0001_base, {"Chave_Pai", "Chave_Linha"}),
    R0150_Min = Table.SelectColumns(R0150_base, {"Chave_Pai", "COD_PART", "CNPJ"}),

    // 2) 0000 -> 0001 (ponte hierárquica)
    J01 = Table.NestedJoin(
        R0000_Min, {"Chave_Linha"}, 
        R0001_Min, {"Chave_Pai"}, 
        "R0001_Aninhado", 
        JoinKind.Inner
    ),
    E01 = Table.ExpandTableColumn(J01, "R0001_Aninhado", 
        {"Chave_Linha"}, 
        {"Chave_Linha_R0001"}),

    // 3) 0001 -> 0150
    J0150 = Table.NestedJoin(
        E01,
        {"Chave_Linha_R0001"},
        R0150_Min,
        {"Chave_Pai"},
        "R0150",
        JoinKind.Inner
    ),
    E0150 = Table.ExpandTableColumn(J0150, "R0150", {"COD_PART", "CNPJ"}, {"COD_PART", "CNPJ"}),

    // 4) Normalização defensiva
    Norm = Table.TransformColumns(
        E0150,
        {
            {"COD_PART", each if _ = null then null else Text.Trim(Text.From(_)), type text},
            {"CNPJ",     each if _ = null then null else Text.Trim(Text.From(_)), type text}
        }
    ),

   // 5) Remove CNPJ nulo/vazio (não faz sentido na checagem)
    Validos = Table.SelectRows(Norm, each [CNPJ] <> null and [CNPJ] <> ""),

    // 6) Base única de pares (CNPJ, COD_PART) para contar corretamente
    // Mantemos isso igual, pois isolar as chaves é vital para a contagem exata.
    Pares = Table.Distinct(Table.SelectColumns(Validos, {"CNPJ", "COD_PART"}), {"CNPJ", "COD_PART"}),

    // 7) Conta quantos COD_PART distintos existem por CNPJ
    Agrupa = Table.Group(
        Pares,
        {"CNPJ"},
        {{"Qtde_COD_PART", each List.Count(List.Distinct([COD_PART])), Int64.Type}}
    ),

    // 8) Mantém só CNPJ com mais de um COD_PART
    CNPJ_Problema = Table.SelectRows(Agrupa, each [Qtde_COD_PART] > 1),

    // ========================================================================
    // 9) O PULO DO GATO: Join na tabela 'Validos' (que possui as datas)
    // ========================================================================
    // Usamos Inner Join para que a tabela CNPJ_Problema atue como um filtro massivo,
    // trazendo apenas as linhas da tabela Validos que estão com inconsistência.
    JoinDeVolta = Table.NestedJoin(
        CNPJ_Problema,
        {"CNPJ"},
        Validos, 
        {"CNPJ"},
        "Detalhes",
        JoinKind.Inner 
    ),

    // 10) Expande as colunas (agora temos acesso ao COD_PART e às Datas)
        Out = Table.ExpandTableColumn(JoinDeVolta, "Detalhes", {"COD_PART", "DT_INI", "DT_FIN"}, {"COD_PART", "DT_INI", "DT_FIN"}),

        // ========================================================================
        // 11) REDUÇÃO DE GRANULARIDADE (AGRUPAMENTO TEMPORAL)
        // ========================================================================
        // Substituímos o Distinct por Group. Isso "cola" os meses consecutivos do 
        // mesmo COD_PART e CNPJ, mostrando apenas o período total (Mínimo e Máximo).
        AgrupaFinal = Table.Group(
            Out,
            {"CNPJ", "Qtde_COD_PART", "COD_PART"},
            {
                {"DT_INI_Min", each List.Min([DT_INI]), type date},
                {"DT_FIN_Max", each List.Max([DT_FIN]), type date}
            }
        ),

        // 12) Ordenação final
        Final = Table.Sort(AgrupaFinal, {{"CNPJ", Order.Ascending}, {"DT_INI_Min", Order.Ascending}, {"COD_PART", Order.Ascending}})
in
    Final;

shared Diag_CodPart_Inumeros_CNPJ = let
    // =========================================================
    // QA: COD_PART associado a mais de um CNPJ 
    // Retorna as combinações (COD_PART, CNPJ) para códigos internos "problemáticos",
    // unificando o período total em que a anomalia ocorreu.
    // =========================================================

    // 1) Column pruning (performance) + Trazendo as datas e o ArquivoId
    R0000_Min = Table.SelectColumns(R0000_base, {"ArquivoId", "DT_INI", "DT_FIN"}),
    R0150_Min = Table.SelectColumns(R0150_base, {"ArquivoId", "COD_PART", "CNPJ"}),

    // 2) O Atalho: R0150 -> R0000 direto via ArquivoId
    J0150 = Table.NestedJoin(
        R0150_Min,
        {"ArquivoId"},
        R0000_Min,
        {"ArquivoId"},
        "R0000",
        JoinKind.Inner
    ),
    
    // 3) Expande as datas que faltavam
    E0150 = Table.ExpandTableColumn(J0150, "R0000", {"DT_INI", "DT_FIN"}, {"DT_INI", "DT_FIN"}),

    // 4) Normalização defensiva
    Norm = Table.TransformColumns(
        E0150,
        {
            {"COD_PART", each if _ = null then null else Text.Trim(Text.From(_)), type text},
            {"CNPJ",     each if _ = null then null else Text.Trim(Text.From(_)), type text}
        }
    ),

    // 5) Remove COD_PART vazio (não faz sentido na checagem)
    Validos = Table.SelectRows(
        Norm,
        each [COD_PART] <> null and [COD_PART] <> "" 
    ),

    // 6) Base única de pares (COD_PART, CNPJ) para contar corretamente
    Pares = Table.Distinct(Table.SelectColumns(Validos, {"COD_PART", "CNPJ"}), {"COD_PART", "CNPJ"}),

    // 7) Conta quantos CNPJs distintos existem por COD_PART
    Agrupa = Table.Group(
        Pares,
        {"COD_PART"},
        {{"Qtde_CNPJ", each List.Count(List.Distinct([CNPJ])), Int64.Type}}
    ),

    // 8) Mantém só COD_PART com mais de um CNPJ
    CODPART_Problema = Table.SelectRows(Agrupa, each [Qtde_CNPJ] > 1),

    // 9) Inner Join de volta para atuar como um filtro massivo (Pushdown)
    JoinDeVolta = Table.NestedJoin(
        CODPART_Problema,
        {"COD_PART"},
        Validos,
        {"COD_PART"},
        "Detalhes",
        JoinKind.Inner
    ),
    
    // 10) Expande as colunas (agora a tabela Detalhes possui DT_INI e DT_FIN)
    Out = Table.ExpandTableColumn(JoinDeVolta, "Detalhes", {"CNPJ", "DT_INI", "DT_FIN"}, {"CNPJ", "DT_INI", "DT_FIN"}),

    // ========================================================================
    // 11) REDUÇÃO DE GRANULARIDADE (AGRUPAMENTO TEMPORAL)
    // ========================================================================
    // Em vez de Distinct, usamos Group By para "colar" os meses consecutivos.
    // Assim, se o erro ocorreu de Jan a Mar, teremos 1 linha (01/01 a 31/03)
    // em vez de 3 linhas soltas.
    AgrupaFinal = Table.Group(
        Out,
        {"COD_PART", "Qtde_CNPJ", "CNPJ"},
        {
            {"DT_INI_Min", each List.Min([DT_INI]), type date},
            {"DT_FIN_Max", each List.Max([DT_FIN]), type date}
        }
    ),

    // 12) Ordenação final lógica (Primeiro o Código, depois a Data e o CNPJ)
    Final = Table.Sort(AgrupaFinal, {{"COD_PART", Order.Ascending}, {"DT_INI_Min", Order.Ascending},  {"CNPJ", Order.Ascending}})
in
    Final;

shared tb_empresa = let
    // ======================================================
    // 1) FONTE & EARLY COLUMN PRUNING (Otimização de Memória)
    // ======================================================
    Fonte = R0000_base,
    
    // Remove colunas que não agregam valor à dimensão o mais cedo possível
    ColsAtuais = Table.ColumnNames(Fonte),
    RemoverTecnicasIniciais = Table.RemoveColumns(
        Fonte,
        List.Intersect({ColsAtuais, {"Nome", "ArquivoId", "LinhaId"}}),
        MissingField.Ignore
    ),

    // ======================================================
    // 2) PREPARAÇÃO E MERGE (Hash Join em Memória)
    // ======================================================
    // O schemaAuxiliares dita que tb_municipios[Codigo_Municipio] é texto
    AddCOD_MUN_Key = Table.AddColumn(
        RemoverTecnicasIniciais,
        "COD_MUN_Key",
        each let v = try [COD_MUN] otherwise null in if v = null then null else Text.From(v),
        type text
    ),
    
    // Carrega a dimensão pequena na RAM
    BufMunicipios = Table.Buffer(tb_municipios),
    
    MergeMunicipio = Table.NestedJoin(
        AddCOD_MUN_Key, {"COD_MUN_Key"},
        BufMunicipios, {"Codigo_Municipio"},
        "Mun", JoinKind.LeftOuter
    ),
    
    ExpandMunicipio = Table.ExpandTableColumn(
        MergeMunicipio, "Mun", {"Nome_Municipio"}, {"NOME_MUNICIPIO"}
    ),

    // ======================================================
    // 3) SUBSTITUIÇÕES SEMÂNTICAS BLINDADAS
    // ======================================================
    ColsA = Table.ColumnNames(ExpandMunicipio),
    FixFINALIDADE = if List.Contains(ColsA, "FINALIDADE") then
        Table.RemoveColumns(ExpandMunicipio, List.Intersect({ColsA, {"COD_FIN"}}))
    else if List.Contains(ColsA, "COD_FIN") then
        Table.RenameColumns(ExpandMunicipio, {{"COD_FIN", "FINALIDADE"}}, MissingField.Ignore)
    else ExpandMunicipio,

    ColsB = Table.ColumnNames(FixFINALIDADE),
    FixATIVIDADE = if List.Contains(ColsB, "ATIVIDADE") then
        Table.RemoveColumns(FixFINALIDADE, List.Intersect({ColsB, {"IND_ATIV"}}))
    else if List.Contains(ColsB, "IND_ATIV") then
        Table.RenameColumns(FixFINALIDADE, {{"IND_ATIV", "ATIVIDADE"}}, MissingField.Ignore)
    else FixFINALIDADE,

    // Remove as chaves temporárias do JOIN
    RemoveCodMun = Table.RemoveColumns(
        FixATIVIDADE,
        List.Intersect({Table.ColumnNames(FixATIVIDADE), {"COD_MUN", "COD_MUN_Key"}})
    ),

    // ======================================================
    // 4) TIPAGEM MÍNIMA PARA ORDENAÇÃO ESTÁVEL
    // ======================================================
    TiposMinimos = Table.TransformColumnTypes(
        RemoveCodMun,
        {{"CNPJ", type text}, {"DT_INI", type date}, {"DT_FIN", type date}, {"Periodo", type text}},
        "pt-BR"
    ),
    
    // Helper para o sort cronológico
    AddPeriodoNum = Table.AddColumn(
        TiposMinimos,
        "PeriodoNum",
        each let p = try Text.Trim(Text.From([Periodo])) otherwise null in try Number.FromText(p) otherwise null,
        Int64.Type
    ),

    // ======================================================
    // 5) DEDUPLICAÇÃO: 1 LINHA POR CNPJ (Regra da Última Ocorrência)
    // ======================================================
    Ordenado = Table.Sort(
        AddPeriodoNum,
        {{"CNPJ", Order.Ascending}, {"DT_INI", Order.Descending}, {"PeriodoNum", Order.Descending}}
    ),
    
    Agrupado = Table.Group(
        Ordenado,
        {"CNPJ"},
        {{"_Top", each Table.FirstN(_, 1), type table}}
    ),
    
    Expandido = Table.ExpandTableColumn(
        Agrupado,
        "_Top",
        List.RemoveItems(Table.ColumnNames(Ordenado), {"CNPJ"}),
        List.RemoveItems(Table.ColumnNames(Ordenado), {"CNPJ"})
    ),

    // ======================================================
    // 6) AUDITORIA E CHAVE DO MODELO
    // ======================================================
    RenomeiaAuditoria = if List.Contains(Table.ColumnNames(Expandido), "Periodo") then
        Table.RenameColumns(Expandido, {{"Periodo", "Periodo_ULT"}}, MissingField.Ignore)
    else Expandido,

    RemoverTecnicasFinais = Table.RemoveColumns(
        RenomeiaAuditoria,
        List.Intersect({Table.ColumnNames(RenomeiaAuditoria), {"Chave_Linha", "Chave_Pai", "PeriodoNum"}})
    ),

    AddEmpresaKey = Table.AddColumn(RemoverTecnicasFinais, "EmpresaKey", each [CNPJ], type text),

    // ======================================================
    // 7) TIPAGEM FINAL E REORDENAÇÃO
    // ======================================================
    TiposFinais = Table.TransformColumnTypes(
        AddEmpresaKey,
        {
            {"EmpresaKey", type text}, {"CNPJ", type text}, {"Periodo_ULT", type text},
            {"COD_VER", type text}, {"FINALIDADE", type text}, {"DT_INI", type date}, {"DT_FIN", type date},
            {"NOME", type text}, {"CPF", type text}, {"UF", type text}, {"IE", type text},
            {"NOME_MUNICIPIO", type text}, {"IM", type text}, {"SUFRAMA", type text},
            {"IND_PERFIL", type text}, {"ATIVIDADE", type text}
        },
        "pt-BR"
    ),
    
    ColsOut = Table.ColumnNames(TiposFinais),
    OrdemPreferida = {"EmpresaKey", "CNPJ"},
    Final = Table.ReorderColumns(
        TiposFinais,
        List.Combine({OrdemPreferida, List.RemoveItems(ColsOut, OrdemPreferida)}),
        MissingField.Ignore
    )
in
    Final;

shared Layout_0190 = let
    // Layout do Registro 0190 (SPED EFD ICMS/IPI) - Identificação das unidades de medida
    // Pos = número do campo conforme documentação oficial (campo 02 = Pos 2)

    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    L0190 =
        [
            Registro = "0190",
            Fields = {
                Field("UNID", 2, "text"),
                Field("DESCR", 3, "text")
            },
            Derivados = {}
        ]
in
    L0190;

shared R0190_base = let
    // Materialização Dinâmica do Registro 0190 a partir da Staging Canônica
    R0190_Base = fnExtraiRegistro(EFD_Extraida, "0190")
in
    R0190_Base;

shared Layout_0200 = let
    // Funções auxiliares locais para definição de metadados
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    // Definição do Layout conforme Guia Prático da EFD ICMS/IPI
    L0200 =
        [
            Registro = "0200",
            Fields = {
                Field("COD_ITEM",      2,  "text"),
                Field("DESCR_ITEM",    3,  "text"),
                Field("COD_BARRA",     4,  "text"),
                Field("COD_ANT_ITEM",  5,  "text"),
                Field("UNID_INV",      6,  "text"),
                Field("TIPO_ITEM",     7,  "text"),
                Field("COD_NCM",       8,  "text"),
                Field("EX_IPI",        9,  "text"),
                Field("COD_GEN",       10, "text"),
                Field("COD_LST",       11, "text"),
                Field("ALIQ_ICMS",     12, "num_pt_2"),
                Field("CEST",          13, "text")
            },
            Derivados = {
                Deriv(
                    "TIPO_ITEM_DESC",
                    "text",
                    (r as record) as any =>
                        let 
                            raw = try Text.From(r[TIPO_ITEM]) otherwise null,
                            cod = if raw = null or Text.Trim(raw) = "" then null else Text.PadStart(Text.Trim(raw), 2, "0")
                        in
                            if cod = "00" then "Mercadoria para Revenda"
                            else if cod = "01" then "Matéria-prima"
                            else if cod = "02" then "Embalagem"
                            else if cod = "03" then "Produto em Processo"
                            else if cod = "04" then "Produto Acabado"
                            else if cod = "05" then "Subproduto"
                            else if cod = "06" then "Produto Intermediário"
                            else if cod = "07" then "Material de Uso e Consumo"
                            else if cod = "08" then "Ativo Imobilizado"
                            else if cod = "09" then "Serviços"
                            else if cod = "10" then "Outros insumos"
                            else if cod = "99" then "Outras"
                            else null
                )
            }
        ]
in
    L0200;

shared R0200_base = let
    // Materialização via motor genérico utilizando a staging EFD_Extraida
    // O grão desta tabela é [ArquivoId, LinhaId] (Chave_Linha)
    R0200_Base = fnExtraiRegistro(EFD_Extraida, "0200")
in
    R0200_Base;

shared Layout_0205 = let
    // Funções auxiliares locais para definição de metadados
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    // Definição do Layout conforme Guia Prático da EFD ICMS/IPI
    L0205 =
        [
            Registro = "0205",
            Fields = {
                Field("DESCR_ANT_ITEM", 2, "text"),
                Field("DT_INI",         3, "date8"),
                Field("DT_FIM",         4, "date8"),
                Field("COD_ANT_ITEM",   5, "text")
            },
            Derivados = {}
        ]
in
    L0205;

shared R0205_base = let
    // Materialização via motor genérico utilizando a staging canônica.
    // As chaves de relacionamento hierárquico (Chave_Pai -> aponta para o 0200) 
    // já são injetadas automaticamente pela fnExtraiRegistro.
    R0205_base = fnExtraiRegistro(EFD_Extraida, "0205")
in
    R0205_base;

shared tb_itens_mercadoria = let
    // ========================================================================
    // A) PREPARAR BASES LEVES (Early Column Pruning)
    // ========================================================================
    Base0200_Raw = Table.SelectColumns(R0200_base, {"ArquivoId", "Chave_Linha", "COD_ITEM", "DESCR_ITEM", "COD_BARRA", "COD_ANT_ITEM", "UNID_INV", "TIPO_ITEM", "TIPO_ITEM_DESC", "COD_NCM", "EX_IPI", "COD_GEN", "COD_LST", "ALIQ_ICMS", "CEST"}, MissingField.Ignore),
    Base0200 = if Table.HasColumns(Base0200_Raw, "TIPO_ITEM_DESC") then Base0200_Raw else Table.AddColumn(Base0200_Raw, "TIPO_ITEM_DESC", each null, type text),

    // BLINDAGEM: Buffer no lado DIREITO do Join
    Base0205_Buf = Table.Buffer(Table.SelectColumns(R0205_base, {"Chave_Pai", "DESCR_ANT_ITEM", "DT_INI", "DT_FIM", "COD_ANT_ITEM"}, MissingField.Ignore)),

    // ========================================================================
    // B) MOTOR SCD2 SET-BASED (Hash Join Imediato)
    // ========================================================================
    TabAtual = Table.AddColumn(Base0200, "Estado_Rec", each [ItemVersaoId = Text.From([ArquivoId]) & "-" & Text.From([COD_ITEM]) & "-C", DESCR_VIGENTE = [DESCR_ITEM], COD_ANT_ITEM_VIGENTE = [COD_ANT_ITEM], DtIni_Vigencia = null, DtFim_Vigencia = null, IsAtual = true], type record),
    TabAtual_Exp = Table.ExpandRecordColumn(TabAtual, "Estado_Rec", {"ItemVersaoId", "DESCR_VIGENTE", "COD_ANT_ITEM_VIGENTE", "DtIni_Vigencia", "DtFim_Vigencia", "IsAtual"}),

    JoinHist = Table.NestedJoin(Base0200, {"Chave_Linha"}, Base0205_Buf, {"Chave_Pai"}, "Tb0205", JoinKind.Inner),
    ExpandeHist = Table.ExpandTableColumn(JoinHist, "Tb0205", {"DESCR_ANT_ITEM", "DT_INI", "DT_FIM", "COD_ANT_ITEM"}, {"H_DESCR", "H_DT_INI", "H_DT_FIM", "H_COD_ANT"}),
    
    TabHist = Table.AddColumn(ExpandeHist, "Estado_Rec", each [ItemVersaoId = Text.From([ArquivoId]) & "-" & Text.From([COD_ITEM]) & "-H-" & (if [H_DT_INI] <> null then Date.ToText([H_DT_INI], "yyyyMMdd") else "NA"), DESCR_VIGENTE = [H_DESCR], COD_ANT_ITEM_VIGENTE = [H_COD_ANT], DtIni_Vigencia = [H_DT_INI], DtFim_Vigencia = [H_DT_FIM], IsAtual = if [H_DT_FIM] = null then true else false], type record),
    TabHist_Exp = Table.ExpandRecordColumn(TabHist, "Estado_Rec", {"ItemVersaoId", "DESCR_VIGENTE", "COD_ANT_ITEM_VIGENTE", "DtIni_Vigencia", "DtFim_Vigencia", "IsAtual"}),

    UniaoSCD2 = Table.Combine({Table.RemoveColumns(TabAtual_Exp, {"DESCR_ITEM", "COD_ANT_ITEM"}), Table.RemoveColumns(TabHist_Exp, {"DESCR_ITEM", "COD_ANT_ITEM", "H_DESCR", "H_DT_INI", "H_DT_FIM", "H_COD_ANT"})}),

    // ========================================================================
    // C) ENRIQUECIMENTOS DIMENSIONAIS 
    // ========================================================================
    AddChaves = Table.TransformColumns(UniaoSCD2, {{"COD_GEN", each if _ = null then null else Text.PadStart(Text.Trim(Text.From(_)), 2, "0"), type text}, {"UNID_INV", each if _ = null then null else Text.Trim(Text.From(_)), type text}}),

    DimUnid = Table.Buffer(Table.SelectColumns(R0190_base, {"ArquivoId", "UNID", "DESCR"}, MissingField.Ignore)),
    MergeUnid = Table.NestedJoin(AddChaves, {"ArquivoId", "UNID_INV"}, DimUnid, {"ArquivoId", "UNID"}, "TbUnid", JoinKind.LeftOuter),
    ExpandUnid = Table.ExpandTableColumn(MergeUnid, "TbUnid", {"DESCR"}, {"UNID_INV_DESC"}),

    DimGen = Table.Buffer(Table.SelectColumns(tb_4_2_1_gen_mercadoria, {"Código", "Descrição"}, MissingField.Ignore)),
    MergeGen = Table.NestedJoin(ExpandUnid, {"COD_GEN"}, DimGen, {"Código"}, "TbGen", JoinKind.LeftOuter),
    ExpandGen = Table.ExpandTableColumn(MergeGen, "TbGen", {"Descrição"}, {"COD_GEN_DESC"}),

    ColunasFinais = {"ItemVersaoId", "ArquivoId", "Chave_Linha", "COD_ITEM", "DESCR_VIGENTE", "COD_BARRA", "COD_ANT_ITEM_VIGENTE", "UNID_INV", "UNID_INV_DESC", "TIPO_ITEM", "TIPO_ITEM_DESC", "COD_NCM", "EX_IPI", "COD_GEN", "COD_GEN_DESC", "COD_LST", "ALIQ_ICMS", "CEST", "DtIni_Vigencia", "DtFim_Vigencia", "IsAtual"},
    SelecionaFinais = Table.SelectColumns(ExpandGen, ColunasFinais, MissingField.Ignore),
    TipagemFinal = Table.TransformColumnTypes(SelecionaFinais, {{"DtIni_Vigencia", type date}, {"DtFim_Vigencia", type date}, {"IsAtual", type logical}, {"ItemVersaoId", type text}, {"ArquivoId", Int64.Type}, {"COD_ITEM", type text}, {"DESCR_VIGENTE", type text}, {"UNID_INV_DESC", type text}, {"COD_GEN_DESC", type text}}, "pt-BR")
in
    TipagemFinal;

shared Layout_0220 = let
    // Funções auxiliares locais para definição de metadados
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    // Definição do Layout conforme Guia Prático da EFD ICMS/IPI
    L0220 =
        [
            Registro = "0220",
            Fields = {
                Field("UNID_CONV", 2, "text"),
                Field("FAT_CONV",  3, "num_pt_5")
            },
            Derivados = {}
        ]
in
    L0220;

shared R0220_base = let
    // Materialização via motor genérico utilizando a staging canônica.
    // As chaves de relacionamento hierárquico (Chave_Pai -> aponta para o 0200) 
    // já são injetadas automaticamente pela fnExtraiRegistro.
    R0220_Base = fnExtraiRegistro(EFD_Extraida, "0220")
in
    R0220_Base;

shared Layout_C100 = let
    // Layout do Registro C100 (SPED EFD ICMS/IPI)
    // Pos = número do campo conforme documentação oficial (campo 02 = Pos 2)

    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC100 =
        [
            Registro = "C100",
            Fields = {
                Field("IND_OPER",       2,  "text"),
                Field("IND_EMIT",       3,  "text"),
                Field("COD_PART",       4,  "text"),
                Field("COD_MOD",        5,  "text"),
                Field("COD_SIT",        6,  "text"),
                Field("SER",            7,  "text"),
                Field("NUM_DOC",        8,  "text"),
                Field("CHV_NFE",        9,  "text"),
                Field("DT_DOC",         10, "date8"),
                Field("DT_E_S",         11, "date8"),
                Field("VL_DOC",         12, "num_pt_2"),
                Field("IND_PGTO",       13, "text"),
                Field("VL_DESC",        14, "num_pt_2"),
                Field("VL_ABAT_NT",     15, "num_pt_2"),
                Field("VL_MERC",        16, "num_pt_2"),
                Field("IND_FRT",        17, "text"),
                Field("VL_FRT",         18, "num_pt_2"),
                Field("VL_SEG",         19, "num_pt_2"),
                Field("VL_OUT_DA",      20, "num_pt_2"),
                Field("VL_BC_ICMS",     21, "num_pt_2"),
                Field("VL_ICMS",        22, "num_pt_2"),
                Field("VL_BC_ICMS_ST",  23, "num_pt_2"),
                Field("VL_ICMS_ST",     24, "num_pt_2"),
                Field("VL_FCP",         25, "num_pt_2"),
                Field("VL_FCP_ST",      26, "num_pt_2"),
                Field("VL_FCP_ST_RET",  27, "num_pt_2"),
                Field("VL_IPI",         28, "num_pt_2"),
                Field("VL_PIS",         29, "num_pt_2"),
                Field("VL_COFINS",      30, "num_pt_2"),
                Field("VL_PIS_ST",      31, "num_pt_2"),
                Field("VL_COFINS_ST",   32, "num_pt_2")
            },
            Derivados = {
                Deriv(
                    "IND_OPER_DESC",
                    "text",
                    (r as record) as any =>
                        let c = try Text.From(r[IND_OPER]) otherwise null
                        in
                            if c = "0" then "Entrada"
                            else if c = "1" then "Saída"
                            else null
                ),
                Deriv(
                    "IND_EMIT_DESC",
                    "text",
                    (r as record) as any =>
                        let c = try Text.From(r[IND_EMIT]) otherwise null
                        in
                            if c = "0" then "Emissão própria"
                            else if c = "1" then "Terceiros"
                            else null
                ),
                Deriv(
                    "IND_PGTO_DESC",
                    "text",
                    (r as record) as any =>
                        let c = try Text.From(r[IND_PGTO]) otherwise null
                        in
                            if c = "0" then "À vista"
                            else if c = "1" then "A prazo"
                            else if c = "2" then "Outros"
                            else if c = "9" then "Sem pagamento"
                            else null
                ),
                Deriv(
                    "IND_FRT_DESC",
                    "text",
                    (r as record) as any =>
                        let c = try Text.From(r[IND_FRT]) otherwise null
                        in
                            if c = "0" then "Por conta do remetente (CIF)"
                            else if c = "1" then "Por conta do destinatário (FOB)"
                            else if c = "2" then "Por conta de terceiros"
                            else if c = "3" then "Transporte próprio por conta do remetente"
                            else if c = "4" then "Transporte próprio por conta do destinatário"
                            else if c = "9" then "Sem ocorrência de transporte"
                            else null
                )
            }
        ]
in
    LC100;

shared RC100_base = let
    // Materialização Dinâmica do Registro C100 a partir da Staging Canônica
    // As chaves de relacionamento hierárquico (Chave_Linha e Chave_Pai) 
    // já são injetadas automaticamente pela fnExtraiRegistro.
    RC100_Base = fnExtraiRegistro(EFD_Extraida, "C100")
in
    RC100_Base;

shared tb_Documentos_Fiscais = let
    // =====================================================================
    // 1) FONTE (FATO C100) + EARLY PRUNING
    // =====================================================================
    FonteC100 = RC100_base,

    ColsC100Desejadas = {
        "ArquivoId", "Chave_Linha",
        "IND_OPER", "IND_EMIT",
        "COD_PART", "COD_MOD", "COD_SIT",
        "SER", "NUM_DOC", "CHV_NFE",
        "DT_DOC", "VL_DOC"
    },

    PrunedC100 =
        Table.SelectColumns(
            FonteC100,
            List.Intersect({ColsC100Desejadas, Table.ColumnNames(FonteC100)}),
            MissingField.Ignore
        ),

    // Tipagem segura (somente colunas existentes)
    TiposC100Candidatos = {
        {"DT_DOC", type date},
        {"COD_PART", type text},
        {"COD_SIT", type text}
    },
    TiposC100Aplicaveis = List.Select(TiposC100Candidatos, each List.Contains(Table.ColumnNames(PrunedC100), _{0})),
    TipadoC100 =
        if List.Count(TiposC100Aplicaveis) = 0
        then PrunedC100
        else Table.TransformColumnTypes(PrunedC100, TiposC100Aplicaveis, "pt-BR"),

    // Normaliza chaves (trim) e COD_SIT com padstart se 1 dígito
    C100 =
        Table.TransformColumns(
            TipadoC100,
            List.Select(
                {
                    {"COD_PART", each if _ = null then null else Text.Trim(Text.From(_)), type text},
                    {"COD_SIT", each
                        let t = if _ = null then null else Text.Trim(Text.From(_))
                        in if t = null then null else if Text.Length(t) = 1 then Text.PadStart(t, 2, "0") else t,
                     type text}
                },
                each List.Contains(Table.ColumnNames(TipadoC100), _{0})
            ),
            null,
            MissingField.Ignore
        ),

    // =====================================================================
    // 2) DIMENSÃO PARTICIPANTES (SCD2) — SET-BASED
    // =====================================================================
    // Pruning da dimensão (inclui vigência)
    ColsPartDesejadas = {"COD_PART", "NOME", "TIPO DOC", "Numero DOC", "IE", "MUNICIPIO", "DataInicial", "DataFinal"},
    PartPruned =
        Table.SelectColumns(
            tb_participantes,
            List.Intersect({ColsPartDesejadas, Table.ColumnNames(tb_participantes)}),
            MissingField.Ignore
        ),

    // Tipagem mínima (se existir)
    TiposPartCandidatos = {
        {"COD_PART", type text},
        {"DataInicial", type date},
        {"DataFinal", type date}
    },
    TiposPartAplicaveis = List.Select(TiposPartCandidatos, each List.Contains(Table.ColumnNames(PartPruned), _{0})),
    PartTipado =
        if List.Count(TiposPartAplicaveis) = 0
        then PartPruned
        else Table.TransformColumnTypes(PartPruned, TiposPartAplicaveis, "pt-BR"),

    PartDim =
        if Table.HasColumns(PartTipado, "COD_PART")
        then Table.TransformColumns(PartTipado, {{"COD_PART", each if _ = null then null else Text.Trim(Text.From(_)), type text}}, null, MissingField.Ignore)
        else PartTipado,

    // Participantes é pequeno (369 linhas no seu teste): buffering aqui é seguro e acelera hash join
    PartBuffered = Table.Buffer(PartDim),

    // Merge + Expansão (gera uma linha por versão do participante)
    MergePart =
        Table.NestedJoin(
            C100, {"COD_PART"},
            PartBuffered, {"COD_PART"},
            "TbPart", JoinKind.LeftOuter
        ),

    ExpandePart =
        Table.ExpandTableColumn(
            MergePart,
            "TbPart",
            List.Intersect({{"NOME","TIPO DOC","Numero DOC","IE","MUNICIPIO","DataInicial","DataFinal"}, Table.ColumnNames(PartBuffered)}),
            {"NOME","TIPO DOC","Numero DOC","IE","MUNICIPIO","DataInicial","DataFinal"}
        ),

    // Se não houve match (DataInicial null), mantém a linha
    PartSemMatch = Table.SelectRows(ExpandePart, each [DataInicial] = null),

    // Filtra vigência em lote para os casos com match
    PartComMatch0 = Table.SelectRows(ExpandePart, each [DataInicial] <> null and [DT_DOC] <> null),

    PartComMatch =
        Table.SelectRows(
            PartComMatch0,
            each [DataInicial] <= [DT_DOC] and ([DataFinal] = null or [DT_DOC] < [DataFinal])
        ),

    // Combina (linhas sem match + linhas com match válido)
    PartUniao = Table.Combine({PartSemMatch, PartComMatch}),

    // Seleciona a versão correta: ordena por DataInicial DESC e dedup por documento
    PartOrdenado =
        Table.Sort(
            PartUniao,
            {{"ArquivoId", Order.Ascending}, {"Chave_Linha", Order.Ascending}, {"DataInicial", Order.Descending}}
        ),

    PartEscolhido =
        Table.Distinct(PartOrdenado, {"ArquivoId", "Chave_Linha"}),

    // Remove colunas técnicas da dimensão (vigência) após selecionar a versão
    PartLimpo =
        Table.RemoveColumns(PartEscolhido, {"DataInicial", "DataFinal"}, MissingField.Ignore),

    // =====================================================================
    // 3) DIMENSÃO SITUAÇÃO DO DOCUMENTO — SET-BASED AS-OF
    // =====================================================================
    ColsSitDesejadas = {"Código", "Descrição", "Início", "Fim"},
    SitPruned =
        Table.SelectColumns(
            tb_4_1_2_situacao_doc,
            List.Intersect({ColsSitDesejadas, Table.ColumnNames(tb_4_1_2_situacao_doc)}),
            MissingField.Ignore
        ),

    TiposSitCandidatos = {
        {"Código", type text},
        {"Início", type date},
        {"Fim", type date},
        {"Descrição", type text}
    },
    TiposSitAplicaveis = List.Select(TiposSitCandidatos, each List.Contains(Table.ColumnNames(SitPruned), _{0})),
    SitTipado =
        if List.Count(TiposSitAplicaveis) = 0
        then SitPruned
        else Table.TransformColumnTypes(SitPruned, TiposSitAplicaveis, "pt-BR"),

    SitDim =
        if Table.HasColumns(SitTipado, "Código")
        then Table.TransformColumns(SitTipado, {{"Código", each if _ = null then null else Text.Trim(Text.From(_)), type text}}, null, MissingField.Ignore)
        else SitTipado,

    // Situação é minúscula (13 linhas): buffering perfeito aqui
    SitBuffered = Table.Buffer(SitDim),
    SitHasFim = Table.HasColumns(SitBuffered, "Fim"),

    MergeSit =
        Table.NestedJoin(
            PartLimpo, {"COD_SIT"},
            SitBuffered, {"Código"},
            "TbSit", JoinKind.LeftOuter
        ),

    ExpandeSit =
        Table.ExpandTableColumn(
            MergeSit,
            "TbSit",
            List.Intersect({{"Descrição","Início","Fim"}, Table.ColumnNames(SitBuffered)}),
            {"DESC_SITUACAO","Sit_Inicio","Sit_Fim"}
        ),

    SitSemMatch = Table.SelectRows(ExpandeSit, each [Sit_Inicio] = null),

    SitComMatch0 = Table.SelectRows(ExpandeSit, each [Sit_Inicio] <> null and [DT_DOC] <> null),

    SitComMatch =
        if SitHasFim then
            Table.SelectRows(
                SitComMatch0,
                each [Sit_Inicio] <= [DT_DOC] and ([Sit_Fim] = null or [DT_DOC] < [Sit_Fim])
            )
        else
            Table.SelectRows(
                SitComMatch0,
                each [Sit_Inicio] <= [DT_DOC]
            ),

    SitUniao = Table.Combine({SitSemMatch, SitComMatch}),

    SitOrdenado =
        Table.Sort(
            SitUniao,
            {{"ArquivoId", Order.Ascending}, {"Chave_Linha", Order.Ascending}, {"Sit_Inicio", Order.Descending}}
        ),

    SitEscolhido =
        Table.Distinct(SitOrdenado, {"ArquivoId", "Chave_Linha"}),

    SitLimpo =
        Table.RemoveColumns(SitEscolhido, {"Sit_Inicio", "Sit_Fim", "Código"}, MissingField.Ignore),

    // =====================================================================
    // 4) TIPAGEM FINAL + REORDENAÇÃO
    // =====================================================================
    TiposFinaisCandidatos = {
        {"NOME", type text},
        {"TIPO DOC", type text},
        {"Numero DOC", type text},
        {"IE", type text},
        {"MUNICIPIO", type text},
        {"DESC_SITUACAO", type text}
    },
    TiposFinaisAplicaveis = List.Select(TiposFinaisCandidatos, each List.Contains(Table.ColumnNames(SitLimpo), _{0})),
    TipagemFinal =
        if List.Count(TiposFinaisAplicaveis) = 0
        then SitLimpo
        else Table.TransformColumnTypes(SitLimpo, TiposFinaisAplicaveis, "pt-BR"),

    ColsFinais = Table.ColumnNames(TipagemFinal),
    OrdemBase = {
        "ArquivoId", "Chave_Linha", "COD_PART", "COD_MOD", "COD_SIT", "SER", "NUM_DOC",
        "DT_DOC", "VL_DOC", "CHV_NFE", "IND_OPER", "IND_EMIT",
        "NOME", "TIPO DOC", "Numero DOC", "IE", "MUNICIPIO", "DESC_SITUACAO"
    },
    OrdemSegura = List.Distinct(List.Combine({List.Intersect({OrdemBase, ColsFinais}), ColsFinais})),
    ReordenaFinal = Table.ReorderColumns(TipagemFinal, OrdemSegura, MissingField.Ignore)
in
    ReordenaFinal;

shared #"NOVO META" = let
    Fonte = #table(
        type table [
            Registro = text,
            Nivel = Int64.Type,
            Bloco = text,
            PaiEsperado = nullable text,
            Descricao = text,
            Ocorrencia = text,
            ativo = logical
        ],

            // =====================
            // Bloco 0
            // =====================
        {
            {"0000", 0, "0", null,  "Abertura do Arquivo Digital e Identificação da entidade",                               "1",   false},
            {"0001", 1, "0", "0000","Abertura do Bloco 0",                                                                  "1",   false},
            {"0002", 2, "0", "0001","Classificação do Estabelecimento Industrial ou Equiparado a Industrial",             "1",   false},
            {"0005", 2, "0", "0001","Dados Complementares da entidade",                                                    "1",   false},
            {"0015", 2, "0", "0001","Dados do Contribuinte Substituto ou Responsável pelo ICMS Destino",                 "V",   false},
            {"0100", 2, "0", "0001","Dados do Contabilista",                                                              "1",   false},
            {"0150", 2, "0", "0001","Tabela de Cadastro do Participante",                                                "V",   false},
            {"0175", 3, "0", "0150","Alteração da Tabela de Cadastro de Participante",                                   "1:N", false},
            {"0190", 2, "0", "0001","Identificação das unidades de medida",                                              "V",   false},
            {"0200", 2, "0", "0001","Tabela de Identificação do Item (Produtos e Serviços)",                             "V",   false},
            {"0205", 3, "0", "0200","Alteração do Item",                                                                  "1:N", false},
            {"0206", 3, "0", "0200","Código do produto conforme Tabela ANP",                                             "1:1", false},
            {"0210", 3, "0", "0200","Consumo Específico Padronizado",                                                     "1:N", false},
            {"0220", 3, "0", "0200","Fatores de Conversão de Unidades",                                                  "1:N", false},
            {"0221", 3, "0", "0200","Correlação entre códigos de itens comercializados",                                 "1:N", false},
            {"0300", 2, "0", "0001","Cadastro de bens ou componentes do Ativo Imobilizado",                              "V",   false},
            {"0305", 3, "0", "0300","Informação sobre a Utilização do Bem",                                              "1:1", false},
            {"0400", 2, "0", "0001","Tabela de Natureza da Operação/ Prestação",                                         "V",   false},
            {"0450", 2, "0", "0001","Tabela de Informação Complementar do documento fiscal",                             "V",   false},
            {"0460", 2, "0", "0001","Tabela de Observações do Lançamento Fiscal",                                        "V",   false},
            {"0500", 2, "0", "0001","Plano de contas contábeis",                                                          "V",   false},
            {"0600", 2, "0", "0001","Centro de custos",                                                                   "V",   false},
            {"0990", 1, "0", "0000","Encerramento do Bloco 0",                                                            "1",   false},

            // =====================
            // Bloco B
            // =====================

            {"B001", 1, "B", "0000", "Abertura do Bloco B", "1", false},
            {"B020", 2, "B", "B001", "Nota Fiscal (código 01), Nota Fiscal de Serviços (código 03), Nota Fiscal de Serviços Avulsa (código 3B), Nota Fiscal de Produtor (código 04), Conhecimento de Transporte Rodoviário de Cargas (código 08), NF-e (código 55) e NFC-e (código 65)", "V", false},
            {"B025", 3, "B", "B020", "Detalhamento por combinação de alíquota e item da lista de serviços da Lei Complementar nº 116/2003", "1:N", false},
            {"B030", 2, "B", "B001", "Nota Fiscal de Serviços Simplificada (código 3A)", "V", false},
            {"B035", 3, "B", "B030", "Detalhamento por combinação de alíquota e item da lista de serviços da Lei Complementar nº 116/2003", "1:N", false},
            {"B350", 2, "B", "B001", "Serviços prestados por instituições financeiras", "V", false},
            {"B420", 2, "B", "B001", "Totalização dos valores de serviços prestados por combinação de alíquota e item da lista de serviços da Lei Complementar nº 116/2003", "V", false},
            {"B440", 2, "B", "B001", "Totalização dos valores retidos", "V", false},
            {"B460", 2, "B", "B001", "Deduções do ISS", "V", false},
            {"B470", 2, "B", "B001", "Apuração do ISS", "1", false},
            {"B500", 2, "B", "B001", "Apuração do ISS sociedade uniprofissional", "1", false},
            {"B510", 3, "B", "B500", "Uniprofissional – empregados e sócios", "V", false},
            {"B990", 1, "B", "0000", "Encerramento do Bloco B", "1", false},

            // =====================
            // Bloco C
            // =====================

            {"C001", 1, "C", "0000", "Abertura do Bloco C", "1", false},
            {"C100", 2, "C", "C001", "Documento - Nota Fiscal (código 01), Nota Fiscal Avulsa (código 1B), Nota Fiscal de Produtor (código 04), Nota Fiscal Eletrônica (código 55) e Nota Fiscal Eletrônica para Consumidor Final (código 65)", "V", false},

            {"C101", 3, "C", "C100", "Informação complementar dos documentos fiscais quando das operações interestaduais destinadas a consumidor final não contribuinte EC 87/15 (código 55)", "1:1", false},
            {"C105", 3, "C", "C100", "Operações com ICMS ST recolhido para UF diversa da destinatária do documento fiscal (Código 55)", "1:1", false},
            {"C110", 3, "C", "C100", "Complemento do Documento - Informação Complementar da Nota Fiscal (código 01, 1B, 55)", "1:N", false},
            {"C111", 4, "C", "C110", "Complemento do Documento - Processo referido", "1:N", false},
            {"C112", 4, "C", "C110", "Complemento do Documento - Documento de Arrecadação Referenciado", "1:N", false},
            {"C113", 4, "C", "C110", "Complemento do Documento - Documento Fiscal Referenciado", "1:N", false},
            {"C114", 4, "C", "C110", "Complemento do Documento - Cupom Fiscal Referenciado", "1:N", false},
            {"C115", 4, "C", "C110", "Local de coleta e/ou entrega (CÓDIGOS 01, 1B e 04)", "1:N", false},
            {"C116", 4, "C", "C110", "Cupom Fiscal Eletrônico - CF-e referenciado", "1:N", false},

            {"C120", 3, "C", "C100", "Complemento do Documento - Operações de Importação (código 01 e 55)", "1:N", false},
            {"C130", 3, "C", "C100", "Complemento do Documento - ISSQN, IRRF e Previdência Social", "1:1", false},
            {"C140", 3, "C", "C100", "Complemento do Documento - Fatura (código 01)", "1:N", false},
            {"C141", 4, "C", "C140", "Complemento do Documento - Vencimento da Fatura (código 01)", "1:1", false},
            {"C160", 3, "C", "C100", "Complemento de Documento - Volume Transportados (código 01 e 04) Exceto Combustíveis", "1:N", false},
            {"C165", 3, "C", "C100", "Complemento de Documento - Operações com combustíveis (código 01)", "1:N", false},

            {"C170", 3, "C", "C100", "Complemento do Documento - Itens do Documento (código 01, 1B, 04 e 55)", "1:N", false},
            {"C171", 4, "C", "C170", "Complemento de Item - Armazenamento de Combustíveis (código 01,55)", "1:N", false},
            {"C172", 4, "C", "C170", "Complemento de Item - Operações com ISSQN (código 01)", "1:N", false},
            {"C173", 4, "C", "C170", "Complemento de Item - Operações com Medicamentos (código 01,55)", "1:N", false},
            {"C174", 4, "C", "C170", "Complemento de Item - Operações com Armas de Fogo (código 01)", "1:N", false},
            {"C175", 4, "C", "C170", "Complemento de Item - Operações com Veículos Novos (código 01,55)", "1:N", false},
            {"C176", 4, "C", "C170", "Complemento de Item - Ressarcimento de ICMS em operações com Substituição Tributária (código 01,55)", "1:N", false},
            {"C177", 4, "C", "C170", "Complemento do Item – Outras informações (Cód. 01, 55) – (Válido a partir de 01/01/2019)", "1:1", false},
            {"C178", 4, "C", "C170", "Complemento do Item - Operações com Produtos Sujeitos a Tributação de IPI", "1:N", false},
            {"C179", 4, "C", "C170", "Complemento do Item - Informações Complementares ST (código 01)", "1:1", false},

            {"C180", 4, "C", "C100", "Informações complementares das operações de entrada de mercadorias sujeitas à substituição tributária (código 01, 1B, 04 e 55)", "1:1", false},
            {"C181", 4, "C", "C100", "Informações complementares das operações de devolução de saídas de mercadorias sujeitas à substituição tributária (código 01, 1B, 04 e 55)", "1:N", false},
            {"C185", 3, "C", "C100", "Informações complementares das operações de saída de mercadorias sujeitas à substituição tributária (código 01, 1B, 04 e 55)", "1:N", false},
            {"C186", 3, "C", "C100", "Informações complementares das operações de entrada de mercadorias sujeitas à substituição tributária (código 01, 1B, 04 e 55)", "1:N", false},
            {"C190", 3, "C", "C100", "Registro Analítico do Documento (código 01, 1B, 04, 55 e 65)", "1:N", false},
            {"C191", 4, "C", "C100", "Informações do Fundo de Combate a Pobreza – FCP – na NF-e (Código 55)", "1:1", false},
            {"C195", 3, "C", "C100", "Complemento do Registro Analítico - Observações do Lançamento Fiscal (código 01, 1B, 04 e 55)", "1:N", false},
            {"C197", 4, "C", "C195", "Outras Obrigações Tributárias, Ajustes e Informações provenientes de Documento Fiscal", "1:N", false},

            {"C300", 2, "C", "C001", "Documento - Resumo Diário das Notas Fiscais de Venda a Consumidor (código 02)", "V", false},
            {"C310", 3, "C", "C300", "Documentos Cancelados de Nota Fiscal de Venda a Consumidor (código 02)", "1:N", false},
            {"C320", 3, "C", "C300", "Registro Analítico das Notas Fiscais de Venda a Consumidor (código 02)", "1:N", false},
            {"C321", 4, "C", "C300", "Itens dos Resumos Diários dos Documentos (código 02)", "1:N", false},
            {"C330", 5, "C", "C321", "Informações complementares das operações de saída de mercadorias sujeitas à substituição tributária (código 02)", "1:1", false},

            {"C350", 2, "C", "C001", "Nota Fiscal de venda a consumidor (código 02)", "V", false},
            {"C370", 3, "C", "C350", "Itens do documento (código 02)", "1:N", false},
            {"C380", 4, "C", "C370", "Informações complementares das operações de saída de mercadorias sujeitas à substituição tributária (código 02)", "1:N", false},
            {"C390", 3, "C", "C350", "Registro Analítico das Notas Fiscais de Venda a Consumidor (código 02)", "1:N", false},

            {"C400", 2, "C", "C001", "Equipamento ECF (códigos 02, 2D e 60)", "V", false},
            {"C405", 3, "C", "C400", "Redução Z (código 02, 2D e 60)", "3", false},
            {"C410", 3, "C", "C400", "PIS e COFINS Totalizados no Dia (código 02 e 2D)", "1:1", false},
            {"C420", 4, "C", "C410", "Registro dos Totalizadores Parciais da Redução Z (código 02, 2D e 60)", "1:N", false},
            {"C425", 5, "C", "C420", "Resumo de itens do movimento diário (código 02 e 2D)", "1:N", false},
            {"C430", 4, "C", "C410", "Informações complementares das operações de saída de mercadorias sujeitas à substituição tributária (código 02, 2D e 60)", "1:N", false},
            {"C460", 4, "C", "C405", "Documento Fiscal Emitido por ECF (código 02, 2D e 60)", "1:N", false},
            {"C465", 5, "C", "C460", "Complemento do Cupom Fiscal Eletrônico Emitido por ECF - CF-e-ECF (código 60)", "1:1", false},
            {"C470", 5, "C", "C460", "Itens do Documento Fiscal Emitido por ECF (código 02 e 2D)", "1:N", false},
            {"C480", 6, "C", "C470", "Informações complementares das operações de saída de mercadorias sujeitas à substituição tributária (código 02 e 2D)", "1:N", false},
            {"C490", 4, "C", "C405", "Registro Analítico do movimento diário (código 02, 2D e 60)", "1:N", false},
            {"C495", 2, "C", "C490", "Resumo Mensal de Itens do ECF por estabelecimento (código 02, 2D e 2E)", "V", false},

            {"C500", 2, "C", "C001", "Nota Fiscal/Conta de Energia Elétrica (código 06), Nota Fiscal/Conta de fornecimento d'água canalizada (código 29) e Nota Fiscal/Conta de Fornecimento de Gás (Código 28)", "V", false},
            {"C510", 3, "C", "C500", "Itens do Documento - Nota Fiscal/Conta de Energia Elétrica (código 06), Nota Fiscal/Conta de fornecimento d'água canalizada (código 29) e Nota Fiscal/Conta Fornecimento de Gás (Código 28)", "1:N", false},
            {"C590", 3, "C", "C500", "Registro Analítico do Documento - Nota Fiscal/Conta de Energia Elétrica (código 06), Nota Fiscal de Energia Elétrica (código 66), Nota Fiscal/Conta de fornecimento d'água canalizada (código 29) e Nota Fiscal/Conta de Fornecimento de Gás (Código 28)", "1:N", false},
            {"C591", 4, "C", "C590", "Informações do Fundo de Combate à Pobreza – FCP – na NF-e (código 66)", "1:1", false},
            {"C595", 3, "C", "C500", "Observações do Lançamento Fiscal (códigos 06, 28, 29 e 66)", "1:N", false},
            {"C597", 4, "C", "C595", "Outras obrigações tributárias, ajustes e informações de valores provenientes de documento fiscal", "1:N", false},

            {"C600", 2, "C", "C001", "Consolidação Diária de Notas Fiscais/Contas de Energia Elétrica (Código 06), Nota Fiscal de Fornecimento de Gás (Código 28) e Nota Fiscal/Conta de Fornecimento d'água (Código 29) e Nota Fiscal/Conta de ICMS 115/03) (Empresas não obrigadas à Convenio ICMS 115/03)", "V", false},
            {"C601", 3, "C", "C600", "Documentos cancelados - Consolidação diária de notas fiscais/contas de energia elétrica (Código 06), nota fiscal/conta de fornecimento d'água (código 29) e nota fiscal/conta de fornecimento de gás (código 28)", "1:N", false},
            {"C610", 3, "C", "C600", "Itens do Documento Consolidado - Notas Fiscais/Contas de Energia Elétrica (Código 06), Nota Fiscal/Conta de fornecimento d'água (código 29) e Nota Fiscal/Conta de Fornecimento de Gás (Código 28) - (Empresas não obrigadas à Convenio ICMS 115/03)", "1:N", false},
            {"C690", 3, "C", "C600", "Registro Analítico dos Documentos - Notas Fiscais/Contas de Energia Elétrica (Código 06), Nota Fiscal/Conta de fornecimento d'água (código 29) e Nota Fiscal/Conta de Fornecimento de Gás (Código 28)", "1:N", false},

            {"C700", 2, "C", "C001", "Consolidação dos Documentos - Nota Fiscal/Conta Energia Elétrica (código 06) emitidas em via única - (Empresas obrigadas à entrega do arquivo previsto no Convênio ICMS 115/03), Nota Fiscal/Conta de Fornecimento de Gás Canalizado (Código 28) e NF-e (Código 55) - Documento Fiscal Eletrônico", "V", false},
            {"C790", 3, "C", "C700", "Registro Analítico dos Documentos (Códigos 06, 28 e 66)", "1:N", false},
            {"C791", 4, "C", "C790", "Registro de informações de ICMS ST por UF (Código 06 e 66)", "1:N", false},

            {"C800", 2, "C", "C001", "Registro Cupom Fiscal Eletrônico - CF-e (Código 59)", "V", false},
            {"C810", 3, "C", "C800", "Itens do documento do cupom fiscal eletrônico - SAT (CF-e-SAT) (código 59)", "1:N", false},
            {"C815", 4, "C", "C810", "Informações complementares das operações de saída de mercadorias sujeitas à substituição tributária (CF-e-SAT) (código 59)", "1:1", false},
            {"C850", 3, "C", "C800", "Registro Analítico do CF-e (Código 59)", "1:N", false},
            {"C855", 3, "C", "C800", "Observações do lançamento fiscal (Código 59)", "1:N", false},
            {"C857", 4, "C", "C855", "Outras obrigações tributárias, ajustes e informações de valores provenientes de documento fiscal", "1:N", false},

            {"C860", 2, "C", "C001", "Identificação do equipamento SAT-CF-e (Código 59)", "V", false},
            {"C870", 3, "C", "C860", "Itens do documento do cupom fiscal eletrônico - SAT (CF-e-SAT) (código 59)", "1:N", false},
            {"C880", 4, "C", "C870", "Informações complementares das operações de saída de mercadorias sujeitas à substituição tributária (CF-e-SAT) (código 59)", "1:N", false},
            {"C890", 3, "C", "C860", "Resumo diário do C-F-E (Código 59) por equipamento SAT-CF-e", "1:N", false},
            {"C895", 3, "C", "C860", "Observações do lançamento fiscal (Código 59)", "1:N", false},
            {"C897", 4, "C", "C895", "Outras obrigações tributárias, ajustes e informações de valores provenientes de documento fiscal", "1:N", false},

            {"C990", 1, "C", "0000", "Encerramento do Bloco C", "1", false},

            // =====================
            // Bloco D
            // =====================

            {"D001", 1, "D", "0000", "Abertura do Bloco D", "1", false},

            {"D100", 2, "D", "D001", "Nota Fiscal de Serviço de Transporte (código 07), Conhecimentos de Transporte Rodoviário de Cargas (código 08), Conhecimentos de Transporte de Cargas Avulso (código 8B), Aquaviário de Cargas (código 09), Aéreo (código 10), Ferroviário de Cargas (código 11), Multimodal de Cargas (código 26), Nota Fiscal de Transporte Ferroviário de Carga (código 27), Conhecimento de Transporte Eletrônico – CT-e (código 57), Conhecimento de Transporte Eletrônico para Outros Serviços – CT-e OS (código 67) e Bilhete de Passagem Eletrônico (código 63)", "V", false},

            {"D101", 3, "D", "D100", "Informação complementar dos documentos fiscais quando das prestações interestaduais destinadas a consumidor final não contribuinte EC 87/15 (código 57 e 67)", "1:1", false},
            {"D110", 3, "D", "D100", "Itens do documento - Nota Fiscal de Serviços de Transporte (código 07)", "1:N", false},
            {"D120", 4, "D", "D110", "Complemento da Nota Fiscal de Serviços de Transporte (código 07)", "1:N", false},
            {"D130", 3, "D", "D100", "Complemento do Conhecimento Rodoviário de Cargas (código 08) e Conhecimento de Transporte de Cargas Avulso (código 8B)", "1:N", false},
            {"D140", 3, "D", "D100", "Complemento do Conhecimento Aquaviário de Cargas (código 09)", "1:1", false},
            {"D150", 3, "D", "D100", "Complemento do Conhecimento Aéreo de Cargas (código 10)", "1:1", false},
            {"D160", 3, "D", "D100", "Carga Transportada (CÓDIGOS 08, 8B, 09, 10, 11, 26 E 27)", "1:N", false},
            {"D161", 4, "D", "D160", "Local de Coleta e Entrega (códigos 08, 8B, 09, 10, 11 e 26)", "1:1", false},
            {"D162", 4, "D", "D160", "Identificação dos documentos fiscais (códigos 08, 8B, 09, 10, 11, 26 e 27)", "1:N", false},
            {"D170", 3, "D", "D100", "Complemento do Conhecimento Multimodal de Cargas (código 26)", "1:1", false},
            {"D180", 3, "D", "D100", "Modais (código 26)", "1:N", false},
            {"D190", 3, "D", "D100", "Registro Analítico dos Documentos (CÓDIGOS 07, 08, 8B, 09, 10, 11, 26, 27, 57 e 67)", "1:N", false},
            {"D195", 3, "D", "D100", "Observações do lançamento (CÓDIGOS 07, 08, 8B, 09, 10, 11, 26, 27, 57 e 67)", "1:N", false},
            {"D197", 4, "D", "D195", "Outras obrigações tributárias, ajustes e informações de valores provenientes de documento fiscal", "1:N", false},

            {"D300", 2, "D", "D001", "Registro Analítico dos bilhetes consolidados de Passagem Rodoviário (código 13), de Passagem Aquaviário (código 14), de Passagem e Nota de Bagagem (código 15) e de Passagem Ferroviário (código 16)", "V", false},
            {"D301", 3, "D", "D300", "Documentos cancelados dos Bilhetes de Passagem Rodoviário (código 13), de Passagem Aquaviário (código 14), de Passagem e Nota de Bagagem (código 15) e de Passagem Ferroviário (código 16)", "1:N", false},
            {"D310", 3, "D", "D300", "Complemento dos Bilhetes (códigos 13, 14, 15 e 16)", "1:N", false},
            {"D350", 2, "D", "D001", "Equipamento ECF (Códigos 2E, 13, 14, 15 e 16)", "V", false},
            {"D355", 3, "D", "D350", "Redução Z (Códigos 2E, 13, 14, 15 e 16)", "1:N", false},
            {"D360", 4, "D", "D355", "PIS e COFINS Totalizados no Dia (Códigos 2E, 13, 14, 15 e 16)", "1:1", false},
            {"D365", 4, "D", "D355", "Registro dos Totalizadores Parciais da Redução Z (Códigos 2E, 13, 14, 15 e 16)", "1:N", false},
            {"D370", 5, "D", "D365", "Complemento dos documentos informados (Códigos 13, 14, 15 e 2E)", "1:N", false},
            {"D390", 4, "D", "D355", "Registro analítico do movimento diário (Códigos 13, 14, 15 e 2E)", "1:N", false},
            {"D400", 2, "D", "D001", "Resumo do Movimento Diário (código 18)", "V", false},
            {"D410", 3, "D", "D400", "Documentos Informados (Códigos 13, 14, 15 e 16)", "1:N", false},
            {"D411", 4, "D", "D410", "Documentos Cancelados dos Documentos Informados (Códigos 13, 14, 15 e 16)", "1:N", false},
            {"D420", 3, "D", "D400", "Complemento dos Documentos Informados (Códigos 13, 14, 15 e 16)", "1:N", false},

            {"D500", 2, "D", "D001", "Nota Fiscal de Serviço de Comunicação (código 21) e Serviço de Telecomunicação (código 22)", "V", false},
            {"D510", 3, "D", "D500", "Itens do Documento - Nota Fiscal de Serviço de Comunicação (código 21) e Serviço de Telecomunicação (código 22)", "1:N", false},
            {"D530", 3, "D", "D500", "Terminal Faturado", "1:N", false},
            {"D590", 3, "D", "D500", "Registro Analítico do Documento (códigos 21 e 22)", "1:N", false},
            {"D600", 2, "D", "D001", "Consolidação da Prestação de Serviços - Notas de Serviço de Comunicação (código 21) e de Serviço de Telecomunicação (código 22)", "V", false},
            {"D610", 3, "D", "D600", "Itens do Documento Consolidado (códigos 21 e 22)", "1:N", false},
            {"D690", 3, "D", "D600", "Registro Analítico dos Documentos (códigos 21 e 22)", "1:N", false},
            {"D695", 2, "D", "D001", "Consolidação da Prestação de Serviços - Notas de Serviço de Comunicação (código 21) e Serviço de Telecomunicação (código 22)", "V", false},
            {"D696", 3, "D", "D695", "Registro Analítico dos Documentos (códigos 21 e 22)", "1:N", false},
            {"D697", 4, "D", "D696", "Registro de informações de outras UFs, relativamente aos serviços “não-medidos” ou assinatura via satélite", "1:N", false},

            {"D700", 2, "D", "D001", "Nota Fiscal Fatura Eletrônica de Serviços de Comunicação – NFCom (Código 62)", "V", false},
            {"D730", 3, "D", "D700", "Registro analítico Nota Fiscal Fatura Eletrônica de Serviços de Comunicação – NFCom (Código 62)", "1:N", false},
            {"D731", 4, "D", "D730", "Informações do fundo de combate à pobreza – FCP – (Código 62)", "1:1", false},
            {"D735", 3, "D", "D700", "Observações do lançamento fiscal (Código 62)", "1:N", false},
            {"D737", 4, "D", "D735", "Outras obrigações tributárias, ajustes e informações de valores provenientes de documento fiscal", "1:N", false},
            {"D750", 2, "D", "D001", "Escrituração consolidada da Nota Fiscal Fatura Eletrônica de Serviços de Comunicação – NFCom (Código 62)", "1:N", false},
            {"D760", 3, "D", "D750", "Registro analítico da escrituração consolidada da Nota Fiscal Fatura Eletrônica de Serviços de Comunicação – NFCom (Código 62)", "1:N", false},
            {"D761", 4, "D", "D760", "Informações do fundo de combate à pobreza FCP – (Código 62)", "1:1", false},

            {"D990", 1, "D", "0000", "Encerramento do Bloco D", "1", false},

            // =====================
            // Bloco E
            // =====================

            {"E001", 1, "E", "0000", "Abertura do Bloco E", "1", false},

            {"E100", 2, "E", "E001", "Período de Apuração do ICMS", "V", false},
            {"E110", 3, "E", "E100", "Apuração do ICMS - Operações Próprias", "1:1", false},
            {"E111", 4, "E", "E110", "Ajuste/Benefício/Incentivo da Apuração do ICMS", "1:N", false},
            {"E112", 5, "E", "E111", "Informações Adicionais dos Ajustes da Apuração do ICMS", "1:N", false},
            {"E113", 5, "E", "E111", "Informações Adicionais dos Ajustes da Apuração do ICMS - Identificação dos documentos fiscais", "1:N", false},
            {"E115", 4, "E", "E110", "Informações Adicionais da Apuração do ICMS - Valores Declaratórios", "1:N", false},
            {"E116", 4, "E", "E110", "Obrigações do ICMS Recolhido ou a Recolher - Operações Próprias", "1:N", false},

            {"E200", 2, "E", "E001", "Período de Apuração do ICMS - Substituição Tributária", "V", false},
            {"E210", 3, "E", "E200", "Apuração do ICMS - Substituição Tributária", "1:1", false},
            {"E220", 4, "E", "E210", "Ajuste/Benefício/Incentivo da Apuração do ICMS - Substituição Tributária", "1:N", false},
            {"E230", 5, "E", "E220", "Informações Adicionais dos Ajustes da Apuração do ICMS Substituição Tributária", "1:N", false},
            {"E240", 5, "E", "E220", "Informações Adicionais dos Ajustes da Apuração do ICMS Substituição Tributária - Identificação dos documentos fiscais", "1:N", false},
            {"E250", 4, "E", "E210", "Obrigações do ICMS Recolhido ou a Recolher - Substituição Tributária", "1:N", false},

            {"E300", 2, "E", "E001", "Período de Apuração do ICMS Diferencial de Alíquota - UF Origem/Destino EC 87/15", "1:N", false},
            {"E310", 3, "E", "E300", "Apuração do ICMS Diferencial de Alíquota - UF Origem/Destino EC 87/15", "1:1", false},
            {"E311", 4, "E", "E310", "Ajuste/Benefício/Incentivo da Apuração do ICMS Diferencial de Alíquota - UF Origem/Destino EC 87/15", "1:N", false},
            {"E312", 5, "E", "E311", "Informações Adicionais dos Ajustes da Apuração do ICMS Diferencial de Alíquota - UF Origem/Destino EC 87/15", "1:N", false},
            {"E313", 5, "E", "E311", "Informações Adicionais da Apuração do ICMS Diferencial de Alíquota - UF Origem/Destino EC 87/15 Identificação dos Documentos Fiscais", "1:N", false},
            {"E316", 4, "E", "E310", "Obrigações do ICMS recolhido ou a recolher - Diferencial de Alíquota - UF Origem/Destino EC 87/15", "1:N", false},

            {"E500", 2, "E", "E001", "Período de Apuração do IPI", "V", false},
            {"E510", 3, "E", "E500", "Consolidação dos Valores de IPI", "3", false},
            {"E520", 3, "E", "E500", "Apuração do IPI", "1:1", false},
            {"E530", 4, "E", "E520", "Ajustes da Apuração do IPI", "1:N", false},
            {"E531", 5, "E", "E530", "Informações Adicionais dos Ajustes da Apuração do IPI - Identificação dos Documentos Fiscais (01 e 55)", "1:N", false},

            {"E990", 1, "E", "0000", "Encerramento do Bloco E", "1", false},

            // =====================
            // Bloco G
            // =====================
            {"G001", 1, "G", "0000", "Abertura do Bloco G", "1", false},
            {"G110", 2, "G", "G001", "ICMS – Ativo Permanente – CIAP", "V", false},
            {"G125", 3, "G", "G110", "Movimentação de Bem do Ativo Imobilizado", "1:N", false},
            {"G126", 4, "G", "G125", "Outros créditos CIAP", "1:N", false},
            {"G130", 4, "G", "G125", "Identificação do documento fiscal", "1:N", false},
            {"G140", 5, "G", "G130", "Identificação do item do documento fiscal", "1:N", false},
            {"G990", 1, "G", "0000", "Encerramento do Bloco G", "1", false},

            // =====================
            // Bloco H
            // =====================
            {"H001", 1, "H", "0000", "Abertura do Bloco H", "1", false},
            {"H005", 2, "H", "H001", "Totais do Inventário", "V", false},
            {"H010", 3, "H", "H005", "Inventário", "1:N", false},
            {"H020", 4, "H", "H010", "Informação complementar do Inventário", "1:N", false},
            {"H030", 4, "H", "H010", "Informações complementares do inventário das mercadorias sujeitas ao regime de substituição tributária", "1:1", false},
            {"H990", 1, "H", "0000", "Encerramento do Bloco H", "1", false},

            // =====================
            // Bloco K
            // =====================

            {"K001", 1, "K", "0000", "Abertura do Bloco K", "1", false},
            {"K010", 2, "K", "K001", "Informação sobre o Tipo de Leiaute (Simplificado / Completo)", "1", false},
            {"K100", 2, "K", "K001", "Período de Apuração ICMS/IPI", "V", false},

            {"K200", 3, "K", "K100", "Estoque Escriturado", "1:N", false},
            {"K210", 3, "K", "K100", "Desmontagem de mercadorias - Item de Origem", "1:N", false},
            {"K215", 4, "K", "K210", "Desmontagem de mercadorias - Item de Destino", "1:N", false},
            {"K220", 3, "K", "K100", "Outras Movimentações Internas entre Mercadorias", "1:N", false},

            {"K230", 3, "K", "K100", "Itens Produzidos", "1:N", false},
            {"K235", 4, "K", "K230", "Insumos Consumidos", "1:N", false},

            {"K250", 3, "K", "K100", "Industrialização Efetuada por Terceiros - Itens Produzidos", "1:N", false},
            {"K255", 4, "K", "K250", "Industrialização em Terceiros – Insumos Consumidos", "1:N", false},

            {"K260", 3, "K", "K100", "Reprocessamento/Reparo de Produto/Insumo", "1:N", false},
            {"K265", 4, "K", "K260", "Reprocessamento/Reparo – Mercadorias Consumidas e/ou Retornadas", "1:N", false},

            {"K270", 3, "K", "K100", "Correção de Apontamento dos Registros K210, K220, K230, K250 e K260", "1:N", false},
            {"K275", 4, "K", "K270", "Correção de Apontamento e Retorno de Insumos dos Registros K215, K220, K235, K255 e K265", "1:N", false},

            {"K280", 3, "K", "K100", "Correção de Apontamento – Estoque Escriturado", "1:N", false},

            {"K290", 3, "K", "K100", "Produção Conjunta – Ordem de Produção", "1:N", false},
            {"K291", 4, "K", "K290", "Produção Conjunta – Itens Produzidos", "1:N", false},
            {"K292", 4, "K", "K290", "Produção Conjunta – Insumos Consumidos", "1:N", false},

            {"K300", 3, "K", "K100", "Produção Conjunta – Industrialização Efetuada por Terceiros – Itens Produzidos", "1:N", false},
            {"K301", 4, "K", "K300", "Produção Conjunta – Industrialização Efetuada por Terceiros – Itens Produzidos Consumidos", "1:N", false},
            {"K302", 4, "K", "K300", "Produção Conjunta – Industrialização Efetuada por Terceiros – Insumos Consumidos", "1:N", false},

            {"K990", 1, "K", "0000", "Encerramento do Bloco K", "1", false},

            // =====================
            // Bloco L
            // =====================
            {"L001", 1, "L", "0000", "Abertura do Bloco L", "1", false},
            {"L100", 2, "L", "L001", "Identificação dos Períodos de Apuração do ICMS", "V", false},
            {"L200", 3, "L", "L100", "Crédito de ICMS do Ativo Permanente – CIAP – Controle por Documento Fiscal", "1:N", false},
            {"L210", 4, "L", "L200", "Controle do Crédito de ICMS do Ativo Permanente – CIAP", "1:N", false},
            {"L990", 1, "L", "0000", "Encerramento do Bloco L", "1", false},

            // =====================
            // Bloco 9
            // =====================
            {"9001", 1, "9", "0000", "Abertura do Bloco 9", "1", false},
            {"9900", 2, "9", "9001", "Registros do Arquivo", "1:N", false},
            {"9990", 1, "9", "0000", "Encerramento do Bloco 9", "1", false},
            {"9999", 0, "9", null, "Encerramento do Arquivo Digital", "1", false}
        }
    )
in
    Fonte;

shared Diag_Meta_Registros = let
    R = fnValidarMetaRegistros(Meta_Registros),
    Problemas = R[Problemas]
in
    Problemas;

shared fnValidarMetaRegistros = // fnValidarMetaRegistros
// Validação estrutural completa (0→9) para a tabela Meta_Registros
// Espera colunas: Registro, Nivel, Bloco, PaiEsperado, Descricao, Ocorrencia, ativo
// Retorna um RECORD com: [Resumo, Problemas, Estatisticas]

(tbl as table) as record =>
let
    // -------------------------
    // 0) Normalização defensiva
    // -------------------------
    RequiredCols = {"Registro","Nivel","Bloco","PaiEsperado","Descricao","Ocorrencia","ativo"},
    MissingCols = List.Difference(RequiredCols, Table.ColumnNames(tbl)),

    _Guard = if List.Count(MissingCols) > 0 then error "Meta_Registros: colunas faltando: " & Text.Combine(MissingCols, ", ") else null,

    // Tipagem (se já estiver tipado, não atrapalha)
    T = Table.TransformColumnTypes(
        tbl,
        {
            {"Registro", type text},
            {"Nivel", Int64.Type},
            {"Bloco", type text},
            {"PaiEsperado", type nullable text},
            {"Descricao", type text},
            {"Ocorrencia", type text},
            {"ativo", type logical}
        },
        "pt-BR"
    ),

    // Auxiliares
    TrimText = (x as any) as nullable text => if x = null then null else Text.Trim(Text.From(x)),

    T1 = Table.TransformColumns(
        T,
        {
            {"Registro", each TrimText(_), type text},
            {"Bloco", each TrimText(_), type text},
            {"PaiEsperado", each TrimText(_), type nullable text},
            {"Descricao", each if _ = null then "" else Text.Trim(Text.From(_)), type text},
            {"Ocorrencia", each if _ = null then "" else Text.Trim(Text.From(_)), type text}
        }
    ),

    // -------------------------
    // 1) Regras de integridade
    // -------------------------

    // 1.1 Registro vazio / Bloco vazio
    R_RegistroVazio = Table.SelectRows(T1, each [Registro] = null or [Registro] = ""),
    R_BlocoVazio    = Table.SelectRows(T1, each [Bloco] = null or [Bloco] = ""),

    // 1.2 Registro duplicado
    Dup = Table.Group(T1, {"Registro"}, {{"Qtd", each Table.RowCount(_), Int64.Type}}),
    R_Duplicados = Table.SelectRows(Dup, each [Qtd] > 1),

    // 1.3 Nivel inválido
    R_NivelInvalido = Table.SelectRows(T1, each [Nivel] = null or [Nivel] < 0),

    // 1.4 PaiEsperado inválido vs Nivel
    R_PaiVsNivel = Table.SelectRows(
        T1,
        each ([PaiEsperado] = null and [Nivel] <> 0) or ([PaiEsperado] <> null and [Nivel] = 0)
    ),

    // 1.5 Pai inexistente
    RegistroSet = List.Buffer(Table.Column(T1, "Registro")),
    R_PaiInexistente = Table.SelectRows(
        T1,
        each [PaiEsperado] <> null and not List.Contains(RegistroSet, [PaiEsperado])
    ),

    // 1.6 Relação de nível: NivelFilho = NivelPai + 1 (quando PaiEsperado não é null)
    Pais = Table.RenameColumns(Table.SelectColumns(T1, {"Registro","Nivel","Bloco"}), {{"Registro","Pai"},{"Nivel","NivelPai"},{"Bloco","BlocoPai"}}),
    ComPai = Table.NestedJoin(T1, {"PaiEsperado"}, Pais, {"Pai"}, "P", JoinKind.LeftOuter),
    ExpPai = Table.ExpandTableColumn(ComPai, "P", {"NivelPai","BlocoPai"}, {"NivelPai","BlocoPai"}),
    R_NivelPai = Table.SelectRows(
        ExpPai,
        each [PaiEsperado] <> null and [NivelPai] <> null and [Nivel] <> [NivelPai] + 1
    ),

    // 1.7 Consistência de Bloco: filho deve estar no mesmo bloco do pai, exceto quando o pai é 0000
    R_BlocoPai = Table.SelectRows(
        ExpPai,
        each [PaiEsperado] <> null
            and [BlocoPai] <> null
            and [PaiEsperado] <> "0000"
            and [Bloco] <> [BlocoPai]
    ),

    // 1.8 Presenças obrigatórias por bloco
    // - Bloco 0: 0000,0001,0990
    // - Bloco 9: 9001,9900,9990,9999
    // - Demais blocos (B,C,D,E,G,H,K,L): X001 e X990
    
    DistinctReg = List.Buffer(List.Distinct(RegistroSet)),
    MustHave0 = {"0000","0001","0990"},
    MustHave9 = {"9001","9900","9990","9999"},

    Missing0 = List.Difference(MustHave0, DistinctReg),
    Missing9 = List.Difference(MustHave9, DistinctReg),

    Blocos = List.Sort(List.Distinct(Table.Column(T1, "Bloco"))),
    BlocosIntermediarios = List.Select(Blocos, each _ <> "0" and _ <> "9"),

    // para cada bloco intermediário, exige abertura X001 e fechamento X990
    MissingOpenClose =
        List.Combine(
            List.Transform(
                BlocosIntermediarios,
                (b as text) =>
                    let
                        Open = b & "001",
                        Close = b & "990",
                        Miss = List.Difference({Open, Close}, DistinctReg)
                    in
                        List.Transform(Miss, each [Tipo="FaltaRegistroObrigatorio", Registro=_, Bloco=b])
            )
        ),

    R_FaltasObrigatorias =
        let
            L0 = List.Transform(Missing0, each [Tipo="FaltaRegistroObrigatorio", Registro=_, Bloco="0"]),
            L9 = List.Transform(Missing9, each [Tipo="FaltaRegistroObrigatorio", Registro=_, Bloco="9"])
        in
            Table.FromRecords(List.Combine({L0, L9, MissingOpenClose})),

    // 1.9 Regras do bloco 9: 9900 deve ter PaiEsperado = 9001; 9990 PaiEsperado = 0000; 9999 nivel 0 / pai null
    R_Bloco9 =
        let
            T9 = Table.SelectRows(T1, each [Bloco] = "9"),
            R1 = Table.SelectRows(T9, each [Registro] = "9900" and [PaiEsperado] <> "9001"),
            R2 = Table.SelectRows(T9, each [Registro] = "9990" and [PaiEsperado] <> "0000"),
            R3 = Table.SelectRows(T9, each [Registro] = "9999" and ( [PaiEsperado] <> null or [Nivel] <> 0 ))
        in
            Table.Combine(
                {
                    Table.AddColumn(R1, "_Tipo", each "Bloco9_Pai_9900", type text),
                    Table.AddColumn(R2, "_Tipo", each "Bloco9_Pai_9990", type text),
                    Table.AddColumn(R3, "_Tipo", each "Bloco9_Regra_9999", type text)
                }
            ),

    // -------------------------
    // 2) Padroniza saída de problemas
    // -------------------------
    MkIssues = (tIssue as table, issueType as text) as table =>
        let
            HasRegistro = List.Contains(Table.ColumnNames(tIssue), "Registro"),
            HasBloco = List.Contains(Table.ColumnNames(tIssue), "Bloco"),
            Base = if HasRegistro and HasBloco then Table.SelectColumns(tIssue, {"Registro","Bloco"})
                   else if HasRegistro then Table.AddColumn(Table.SelectColumns(tIssue, {"Registro"}), "Bloco", each null, type nullable text)
                   else if HasBloco then Table.AddColumn(Table.SelectColumns(tIssue, {"Bloco"}), "Registro", each null, type nullable text)
                   else #table(type table [Registro=nullable text, Bloco=nullable text], {}),
            Out = Table.AddColumn(Base, "Tipo", each issueType, type text)
        in
            Out,

    P1 = MkIssues(R_RegistroVazio, "RegistroVazio"),
    P2 = MkIssues(R_BlocoVazio, "BlocoVazio"),
    P3 = Table.AddColumn(Table.RenameColumns(R_Duplicados, {{"Registro","Registro"}}), "Tipo", each "RegistroDuplicado", type text),
    P3s = Table.SelectColumns(Table.AddColumn(P3, "Bloco", each null, type nullable text), {"Registro","Bloco","Tipo"}),
    P4 = MkIssues(R_NivelInvalido, "NivelInvalido"),
    P5 = MkIssues(R_PaiVsNivel, "PaiVsNivel"),
    P6 = MkIssues(R_PaiInexistente, "PaiInexistente"),
    P7 = MkIssues(R_NivelPai, "NivelNaoEhPaiMaisUm"),
    P8 = MkIssues(R_BlocoPai, "BlocoDiferenteDoPai"),
    P9 = if Table.IsEmpty(R_FaltasObrigatorias) then #table(type table [Registro=nullable text, Bloco=nullable text, Tipo=text], {})
         else Table.SelectColumns(Table.AddColumn(R_FaltasObrigatorias, "Tipo", each [Tipo], type text), {"Registro","Bloco","Tipo"}),
    P10 = if Table.IsEmpty(R_Bloco9) then #table(type table [Registro=nullable text, Bloco=nullable text, Tipo=text], {})
          else Table.SelectColumns(Table.RenameColumns(Table.SelectColumns(R_Bloco9, {"Registro","Bloco","_Tipo"}), {{"_Tipo","Tipo"}}), {"Registro","Bloco","Tipo"}),

    Problemas = Table.Distinct(Table.Combine({P1,P2,P3s,P4,P5,P6,P7,P8,P9,P10})),

    // -------------------------
    // 3) Estatísticas e resumo
    // -------------------------
    Estatisticas =
        let
            ByBloco = Table.Group(T1, {"Bloco"}, {{"QtdRegistros", each Table.RowCount(_), Int64.Type}, {"Niveis", each List.Sort(List.Distinct([Nivel])), type list}}),
            ByTipo  = Table.Group(Problemas, {"Tipo"}, {{"Qtd", each Table.RowCount(_), Int64.Type}})
        in
            [PorBloco = ByBloco, PorTipo = ByTipo],

    Resumo =
        let
            Total = Table.RowCount(T1),
            TotalProblemas = Table.RowCount(Problemas),
            Ok = TotalProblemas = 0,
            Msg0 = if List.Count(Missing0) > 0 then "Faltam registros obrigatórios no Bloco 0: " & Text.Combine(Missing0, ", ") else null,
            Msg9 = if List.Count(Missing9) > 0 then "Faltam registros obrigatórios no Bloco 9: " & Text.Combine(Missing9, ", ") else null,
            Msg = Text.Combine(List.RemoveNulls({Msg0, Msg9}), " | ")
        in
            [TotalRegistros = Total, TotalProblemas = TotalProblemas, HierarquiaOK = Ok, Observacao = Msg]

in
    [Resumo = Resumo, Problemas = Problemas, Estatisticas = Estatisticas]
;