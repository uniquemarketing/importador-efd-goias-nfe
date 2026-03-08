let
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
    Fonte

