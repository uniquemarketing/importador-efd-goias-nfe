let
    Field = (tag as text, alias as text, path as list, kind as text) =>
        [Tag = tag, Alias = alias, Path = path, Kind = kind],
    Deriv = (name as text, kind as text, fn as function) => [Name = name, Kind = kind, Fn = fn],
    LAYOUT_NFE_PROD = [
        Tabela = "LAYOUT_NFE_PROD",
        Multiplicidade = "1:N",
        RootPath = {"NFe", "infNFe", "det"},
        Fields = {
            // Identificacao do item
            Field("nItem", "Item", {"Attribute:nItem"}, "text"),
            // Produto/mercadoria
            Field("cProd", "Prod_cProd", {"prod", "cProd"}, "text"),
            Field("xProd", "Prod_xProd", {"prod", "xProd"}, "text"),
            Field("NCM", "Prod_NCM", {"prod", "NCM"}, "text"),
            Field("CEST", "Prod_CEST", {"prod", "CEST"}, "text"),
            Field("CFOP", "Prod_CFOP", {"prod", "CFOP"}, "code4"),
            Field("cEAN", "Prod_cEAN", {"prod", "cEAN"}, "text"),
            Field("uCom", "Prod_uCom", {"prod", "uCom"}, "text"),
            Field("qCom", "Prod_qCom", {"prod", "qCom"}, "11v0-4"),
            Field("vUnCom", "Prod_vUnCom", {"prod", "vUnCom"}, "11v0-10"),
            Field("vProd", "Prod_vProd", {"prod", "vProd"}, "13v2"),
            Field("uTrib", "Prod_uTrib", {"prod", "uTrib"}, "text"),
            Field("qTrib", "Prod_qTrib", {"prod", "qTrib"}, "11v0-4"),
            Field("vUnTrib", "Prod_vUnTrib", {"prod", "vUnTrib"}, "11v0-10"),
            Field("vFrete", "Prod_vFrete", {"prod", "vFrete"}, "13v2"),
            Field("vSeg", "Prod_vSeg", {"prod", "vSeg"}, "13v2"),
            Field("vDesc", "Prod_vDesc", {"prod", "vDesc"}, "13v2"),
            Field("vOutro", "Prod_vOutro", {"prod", "vOutro"}, "13v2"),
            // DIFAL/FCP por item
            Field("vBCUFDest", "Difal_vBCUFDest", {"imposto", "ICMSUFDest", "vBCUFDest"}, "13v2"),
            Field("vBCFCPUFDest", "Difal_vBCFCPUFDest", {"imposto", "ICMSUFDest", "vBCFCPUFDest"}, "13v2"),
            Field("pFCPUFDest", "Difal_pFCPUFDest", {"imposto", "ICMSUFDest", "pFCPUFDest"}, "3v2-4"),
            Field("pICMSUFDest", "Difal_pICMSUFDest", {"imposto", "ICMSUFDest", "pICMSUFDest"}, "3v2-4"),
            Field("pICMSInter", "Difal_pICMSInter", {"imposto", "ICMSUFDest", "pICMSInter"}, "3v2-4"),
            Field("pICMSInterPart", "Difal_pICMSInterPart", {"imposto", "ICMSUFDest", "pICMSInterPart"}, "3v2-4"),
            Field("vFCPUFDest", "Difal_vFCPUFDest", {"imposto", "ICMSUFDest", "vFCPUFDest"}, "13v2"),
            Field("vICMSUFDest", "Difal_vICMSUFDest", {"imposto", "ICMSUFDest", "vICMSUFDest"}, "13v2"),
            Field("vICMSUFRemet", "Difal_vICMSUFRemet", {"imposto", "ICMSUFDest", "vICMSUFRemet"}, "13v2"),
            // IPI por item
            Field("cEnq", "IPI_cEnq", {"imposto", "IPI", "cEnq"}, "text"),
            Field("CST", "IPI_CST_Trib", {"imposto", "IPI", "IPITrib", "CST"}, "code2"),
            Field("CST", "IPI_CST_Outr", {"imposto", "IPI", "IPIOutr", "CST"}, "code2"),
            Field("vBC", "IPI_vBC", {"imposto", "IPI", "IPITrib", "vBC"}, "13v2"),
            Field("pIPI", "IPI_pIPI", {"imposto", "IPI", "IPITrib", "pIPI"}, "3v2-4"),
            Field("vIPI", "IPI_vIPI_Trib", {"imposto", "IPI", "IPITrib", "vIPI"}, "13v2"),
            Field("vIPI", "IPI_vIPI_Outr", {"imposto", "IPI", "IPIOutr", "vIPI"}, "13v2")
        },
        Derivados = {
            Deriv(
                "Prod_Brinde",
                "text",
                (r as record) =>
                    let
                        valor = Record.FieldOrDefault(r, "Prod_vProd", null)
                    in
                        if valor = null then
                            null
                        else if valor = 0 then
                            "Sim"
                        else
                            "Não"
            )
        },
        // ICMS dinamico por item
        ICMS_Layout = {
            Field("orig", "ICMS_orig", {}, "text"),
            Field("CST", "ICMS_CST", {}, "text"),
            Field("CSOSN", "ICMS_CSOSN", {}, "text"),
            Field("modBC", "ICMS_modBC", {}, "text"),
            Field("pRedBC", "ICMS_pRedBC", {}, "3v2-4"),
            Field("vBC", "ICMS_vBC", {}, "13v2"),
            Field("pICMS", "ICMS_pICMS", {}, "3v2-4"),
            Field("vICMS", "ICMS_vICMS", {}, "13v2"),
            Field("modBCST", "ICMSST_modBCST", {}, "text"),
            Field("pMVAST", "ICMSST_pMVAST", {}, "3v2-4"),
            Field("pRedBCST", "ICMSST_pRedBCST", {}, "3v2-4"),
            Field("vBCST", "ICMSST_vBCST", {}, "13v2"),
            Field("pICMSST", "ICMSST_pICMSST", {}, "3v2-4"),
            Field("vICMSST", "ICMSST_vICMSST", {}, "13v2"),
            Field("pFCP", "ICMS_pFCP", {}, "3v2-4"),
            Field("vFCP", "ICMS_vFCP", {}, "13v2"),
            Field("vBCFCP", "ICMS_vBCFCP", {}, "13v2"),
            Field("vBCFCPST", "ICMSST_vBCFCPST", {}, "13v2"),
            Field("pFCPST", "ICMSST_pFCPST", {}, "3v2-4"),
            Field("vFCPST", "ICMSST_vFCPST", {}, "13v2"),
            Field("vICMSOp", "ICMS_vICMSOp", {}, "13v2"),
            Field("pDif", "ICMS_pDif", {}, "3v2-4"),
            Field("vICMSDif", "ICMS_vICMSDif", {}, "13v2"),
            Field("pBCOp", "ICMS_pBCOp", {}, "3v2-4"),
            Field("UFST", "ICMSST_UFST", {}, "text"),
            Field("pCredSN", "ICMSSN_pCredSN", {}, "3v2-4"),
            Field("vCredICMSSN", "ICMSSN_vCredICMSSN", {}, "13v2"),
            Field("vBCSTDest", "ICMSST_vBCSTDest", {}, "13v2"),
            Field("vICMSSTDest", "ICMSST_vICMSSTDest", {}, "13v2")
        }
    ]
in
    LAYOUT_NFE_PROD
