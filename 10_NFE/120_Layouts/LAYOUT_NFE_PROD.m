let
    Field = (tag as text, alias as text, path as list, kind as text) =>
        [Tag = tag, Alias = alias, Path = path, Kind = kind],
    Deriv = (name as text, kind as text, fn as function) => [Name = name, Kind = kind, Fn = fn],
    LAYOUT_NFE_PROD = [
        Tabela = "LAYOUT_NFE_PROD",
        Multiplicidade = "1:N",
        RootPath = {"NFe", "infNFe", "det"},
        Fields = {
            // ====== CHAVES / IDENTIFICAÇÃO DO ITEM ======
            Field("nItem", "Item", {"Attribute:nItem"}, "text"),
            // ====== PRODUTO (auditável) ======
            Field("cProd", "Código Produto", {"prod", "cProd"}, "text"),
            Field("cEAN", "EAN", {"prod", "cEAN"}, "text"),
            Field("xProd", "Descrição", {"prod", "xProd"}, "text"),
            Field("NCM", "NCM", {"prod", "NCM"}, "text"),
            Field("CEST", "CEST", {"prod", "CEST"}, "text"),
            Field("indEscala", "Ind Escala", {"prod", "indEscala"}, "text"),
            Field("CFOP", "CFOP", {"prod", "CFOP"}, "text"),
            Field("uCom", "Unidade Comercial", {"prod", "uCom"}, "text"),
            Field("qCom", "Qtd Comercial", {"prod", "qCom"}, "11v0-4"),
            Field("vUnCom", "Vlr Unit Comercial", {"prod", "vUnCom"}, "11v0-10"),
            Field("vProd", "Valor Total Bruto", {"prod", "vProd"}, "13v2"),
            Field("cEANTrib", "EAN Trib", {"prod", "cEANTrib"}, "text"),
            Field("uTrib", "Unidade Trib", {"prod", "uTrib"}, "text"),
            Field("qTrib", "Qtd Trib", {"prod", "qTrib"}, "11v0-4"),
            Field("vUnTrib", "Vlr Unit Trib", {"prod", "vUnTrib"}, "11v0-10"),
            Field("vFrete", "Vlr Frete", {"prod", "vFrete"}, "13v2"),
            Field("vSeg", "Vlr Seguro", {"prod", "vSeg"}, "13v2"),
            Field("vDesc", "Vlr Desconto", {"prod", "vDesc"}, "13v2"),
            Field("vOutro", "Vlr Outros", {"prod", "vOutro"}, "13v2"),
            // ====== ICMS UF DESTINO (DIFAL / EC 87) ======
            Field("vBCUFDest", "BC ICMS UF Destino", {"imposto", "ICMSUFDest", "vBCUFDest"}, "13v2"),
            Field("vBCFCPUFDest", "BC FCP UF Destino", {"imposto", "ICMSUFDest", "vBCFCPUFDest"}, "13v2"),
            Field("pFCPUFDest", "Perc FCP Destino", {"imposto", "ICMSUFDest", "pFCPUFDest"}, "3v2-4"),
            Field("pICMSUFDest", "Aliq Interna Destino", {"imposto", "ICMSUFDest", "pICMSUFDest"}, "3v2-4"),
            Field("pICMSInter", "Aliq Interestadual", {"imposto", "ICMSUFDest", "pICMSInter"}, "3v2-4"),
            Field("pICMSInterPart", "Perc Partilha Destino", {"imposto", "ICMSUFDest", "pICMSInterPart"}, "3v2-4"),
            Field("vFCPUFDest", "Valor FCP Destino", {"imposto", "ICMSUFDest", "vFCPUFDest"}, "13v2"),
            Field("vICMSUFDest", "Valor ICMS UF Destino", {"imposto", "ICMSUFDest", "vICMSUFDest"}, "13v2"),
            Field("vICMSUFRemet", "Valor ICMS UF Remet", {"imposto", "ICMSUFDest", "vICMSUFRemet"}, "13v2"),
            // ====== IPI ======
            Field("cEnq", "Cod Enquadramento IPI", {"imposto", "IPI", "cEnq"}, "text"),
            Field("CST_IPI", "CST IPI", {"imposto", "IPI", "IPITrib", "CST"}, "text"),
            Field("vIPI", "Valor IPI Trib", {"imposto", "IPI", "IPITrib", "vIPI"}, "13v2"),
            Field("vIPI_Outros", "Valor IPI Outros", {"imposto", "IPI", "IPIOutr", "vIPI"}, "13v2")
        },
        Derivados = {
            Deriv(
                "Produto Brinde",
                "text",
                (r as record) =>
                    let
                        valor = Record.FieldOrDefault(r, "Valor Total Bruto", null)
                    in
                        if valor = 0 then
                            "Sim"
                        else
                            "Não"
            )
        },
        // ====== ICMS DINÂMICO (Caixa única por Tag ativa) ======
        ICMS_Layout = {
            Field("orig", "Origem Mercadoria", {}, "text"),
            Field("CST", "CST ICMS", {}, "text"),
            Field("CSOSN", "CSOSN ICMS", {}, "text"),
            Field("modBC", "Modalidade BC ICMS", {}, "text"),
            Field("pRedBC", "Percentual Redução BC ICMS", {}, "3v2-4"),
            Field("vBC", "Base Cálculo ICMS", {}, "13v2"),
            Field("pICMS", "Alíquota ICMS", {}, "3v2-4"),
            Field("vICMS", "Valor ICMS", {}, "13v2"),
            Field("modBCST", "Modalidade BC ST", {}, "text"),
            Field("pMVAST", "Percentual MVA BC ST", {}, "3v2-4"),
            Field("pRedBCST", "Percentual Redução BC ST", {}, "3v2-4"),
            Field("vBCST", "Base Cálculo ST", {}, "13v2"),
            Field("pICMSST", "Alíquota ST", {}, "3v2-4"),
            Field("vICMSST", "Valor ST", {}, "13v2"),
            Field("pFCP", "Percentual FCP", {}, "3v2-4"),
            Field("vFCP", "Valor FCP", {}, "13v2"),
            Field("vBCFCP", "Base Cálculo FCP", {}, "13v2"),
            Field("vBCFCPST", "Base Cálculo FCP ST", {}, "13v2"),
            Field("pFCPST", "Percentual FCP ST", {}, "3v2-4"),
            Field("vFCPST", "Valor FCP ST", {}, "13v2"),
            Field("vICMSOp", "Valor ICMS Operação", {}, "13v2"),
            Field("pDif", "Percentual Diferimento ICMS", {}, "3v2-4"),
            Field("vICMSDif", "Valor do ICMS Diferido", {}, "13v2"),
            Field("pBCOp", "Percentual BC Op Própria", {}, "3v2-4"),
            Field("UFST", "UF ST", {}, "text"),
            Field("pCredSN", "Percentual Crédito SN", {}, "3v2-4"),
            Field("vCredICMSSN", "Valor Crédito SN", {}, "13v2"),
            Field("vBCSTDest", "Base Cálculo ST Destino", {}, "13v2"),
            Field("vICMSSTDest", "Valor ICMS ST UF de Destino", {}, "13v2")
        }
    ]
in
    LAYOUT_NFE_PROD
