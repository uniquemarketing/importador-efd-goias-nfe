let
    Field = (tag as text, alias as text, path as list, kind as text) as record =>
        [Tag = tag, Alias = alias, Path = path, Kind = kind],
    Deriv = (name as text, kind as text, fn as function) as record => [Name = name, Kind = kind, Fn = fn],
    LAYOUT_NFE_BASE = [
        Tabela = "LAYOUT_NFE_BASE",
        Multiplicidade = "1:1",
        RootPath = {},
        Fields = {
            Field("versao", "Versao_XML", {"NFe", "infNFe", "Attribute:versao"}, "text"),
            Field("id", "Id_XML", {"NFe", "infNFe", "Attribute:Id"}, "text"),
            Field("chNFe", "Chave de Acesso", {"protNFe", "infProt", "chNFe"}, "text"),
            Field("cUF", "Ide_cUF", {"NFe", "infNFe", "ide", "cUF"}, "code2"),
            Field("natOp", "Ide_natOp", {"NFe", "infNFe", "ide", "natOp"}, "text"),
            Field("mod", "Ide_mod", {"NFe", "infNFe", "ide", "mod"}, "code2"),
            Field("serie", "Ide_serie", {"NFe", "infNFe", "ide", "serie"}, "text"),
            Field("nNF", "Ide_nNF", {"NFe", "infNFe", "ide", "nNF"}, "text"),
            Field("dhEmi", "Ide_dhEmi", {"NFe", "infNFe", "ide", "dhEmi"}, "datetime"),
            Field("tpNF", "Ide_tpNF", {"NFe", "infNFe", "ide", "tpNF"}, "code1"),
            Field("idDest", "Ide_idDest", {"NFe", "infNFe", "ide", "idDest"}, "code1"),
            Field("cMunFG", "Ide_cMunFG", {"NFe", "infNFe", "ide", "cMunFG"}, "text"),
            Field("finNFe", "Ide_finNFe", {"NFe", "infNFe", "ide", "finNFe"}, "code1"),
            Field("indFinal", "Ide_indFinal", {"NFe", "infNFe", "ide", "indFinal"}, "code1"),
            Field("indPres", "Ide_indPres", {"NFe", "infNFe", "ide", "indPres"}, "code1"),
            Field("indIntermed", "Ide_indIntermed", {"NFe", "infNFe", "ide", "indIntermed"}, "code1"),
            Field("procEmi", "Ide_procEmi", {"NFe", "infNFe", "ide", "procEmi"}, "code1"),
            Field("refNFe", "Ref_refNFe", {"NFe", "infNFe", "ide", "NFref", "refNFe"}, "text"),
            Field("refCTe", "Ref_refCTe", {"NFe", "infNFe", "ide", "NFref", "refCTe"}, "text"),
            Field("CNPJ", "Emit_CNPJ", {"NFe", "infNFe", "emit", "CNPJ"}, "text"),
            Field("CPF", "Emit_CPF", {"NFe", "infNFe", "emit", "CPF"}, "text"),
            Field("xNome", "Emit_xNome", {"NFe", "infNFe", "emit", "xNome"}, "text"),
            Field("IE", "Emit_IE", {"NFe", "infNFe", "emit", "IE"}, "text"),
            Field("cMun", "Emit_cMun", {"NFe", "infNFe", "emit", "enderEmit", "cMun"}, "text"),
            Field("xMun", "Emit_xMun", {"NFe", "infNFe", "emit", "enderEmit", "xMun"}, "text"),
            Field("UF", "Emit_UF", {"NFe", "infNFe", "emit", "enderEmit", "UF"}, "text"),
            Field("CNPJ", "Dest_CNPJ", {"NFe", "infNFe", "dest", "CNPJ"}, "text"),
            Field("CPF", "Dest_CPF", {"NFe", "infNFe", "dest", "CPF"}, "text"),
            Field("xNome", "Dest_xNome", {"NFe", "infNFe", "dest", "xNome"}, "text"),
            Field("indIEDest", "Dest_indIEDest", {"NFe", "infNFe", "dest", "indIEDest"}, "code1"),
            Field("IE", "Dest_IE", {"NFe", "infNFe", "dest", "IE"}, "text"),
            Field("cMun", "Dest_cMun", {"NFe", "infNFe", "dest", "enderDest", "cMun"}, "text"),
            Field("xMun", "Dest_xMun", {"NFe", "infNFe", "dest", "enderDest", "xMun"}, "text"),
            Field("UF", "Dest_UF", {"NFe", "infNFe", "dest", "enderDest", "UF"}, "text"),
            Field("nProt", "Prot_nProt", {"protNFe", "infProt", "nProt"}, "text"),
            Field("dhRecbto", "Prot_dhRecbto", {"protNFe", "infProt", "dhRecbto"}, "datetime"),
            Field("cStat", "Prot_cStat", {"protNFe", "infProt", "cStat"}, "code3"),
            Field("xMotivo", "Prot_xMotivo", {"protNFe", "infProt", "xMotivo"}, "text"),
            Field("vBC", "Tot_vBC", {"NFe", "infNFe", "total", "ICMSTot", "vBC"}, "13v2"),
            Field("vICMS", "Tot_vICMS", {"NFe", "infNFe", "total", "ICMSTot", "vICMS"}, "13v2"),
            Field("vICMSDeson", "Tot_vICMSDeson", {"NFe", "infNFe", "total", "ICMSTot", "vICMSDeson"}, "13v2"),
            Field("vFCPUFDest", "Tot_vFCPUFDest", {"NFe", "infNFe", "total", "ICMSTot", "vFCPUFDest"}, "13v2"),
            Field("vICMSUFDest", "Tot_vICMSUFDest", {"NFe", "infNFe", "total", "ICMSTot", "vICMSUFDest"}, "13v2"),
            Field("vICMSUFRemet", "Tot_vICMSUFRemet", {"NFe", "infNFe", "total", "ICMSTot", "vICMSUFRemet"}, "13v2"),
            Field("vFCP", "Tot_vFCP", {"NFe", "infNFe", "total", "ICMSTot", "vFCP"}, "13v2"),
            Field("vBCST", "Tot_vBCST", {"NFe", "infNFe", "total", "ICMSTot", "vBCST"}, "13v2"),
            Field("vST", "Tot_vST", {"NFe", "infNFe", "total", "ICMSTot", "vST"}, "13v2"),
            Field("vFCPST", "Tot_vFCPST", {"NFe", "infNFe", "total", "ICMSTot", "vFCPST"}, "13v2"),
            Field("vProd", "Tot_vProd", {"NFe", "infNFe", "total", "ICMSTot", "vProd"}, "13v2"),
            Field("vFrete", "Tot_vFrete", {"NFe", "infNFe", "total", "ICMSTot", "vFrete"}, "13v2"),
            Field("vSeg", "Tot_vSeg", {"NFe", "infNFe", "total", "ICMSTot", "vSeg"}, "13v2"),
            Field("vDesc", "Tot_vDesc", {"NFe", "infNFe", "total", "ICMSTot", "vDesc"}, "13v2"),
            Field("vII", "Tot_vII", {"NFe", "infNFe", "total", "ICMSTot", "vII"}, "13v2"),
            Field("vIPI", "Tot_vIPI", {"NFe", "infNFe", "total", "ICMSTot", "vIPI"}, "13v2"),
            Field("vIPIDevol", "Tot_vIPIDevol", {"NFe", "infNFe", "total", "ICMSTot", "vIPIDevol"}, "13v2"),
            Field("vOutro", "Tot_vOutro", {"NFe", "infNFe", "total", "ICMSTot", "vOutro"}, "13v2"),
            Field("vNF", "Tot_vNF", {"NFe", "infNFe", "total", "ICMSTot", "vNF"}, "13v2"),
            Field("vTotTrib", "Tot_vTotTrib", {"NFe", "infNFe", "total", "ICMSTot", "vTotTrib"}, "13v2"),
            Field("infAdFisco", "InfAdic_infAdFisco", {"NFe", "infNFe", "infAdic", "infAdFisco"}, "text"),
            Field("infCpl", "InfAdic_infCpl", {"NFe", "infNFe", "infAdic", "infCpl"}, "text")
        },
        Derivados = {
            Deriv(
                "Chave_Acesso_44",
                "text",
                (r as record) =>
                    let
                        chave = try Text.Trim(Text.From(Record.FieldOrDefault(r, "Chave de Acesso", null))) otherwise null,
                        idXml = try Text.Trim(Text.From(Record.FieldOrDefault(r, "Id_XML", null))) otherwise null,
                        idSemPrefixo =
                            if idXml = null then
                                null
                            else if Text.StartsWith(Text.Upper(idXml), "NFE") then
                                Text.Range(idXml, 3)
                            else
                                idXml
                    in
                        if chave <> null and chave <> "" then chave else idSemPrefixo
            ),
            Deriv(
                "Ide_tpNF_DESC",
                "text",
                (r as record) =>
                    let
                        v = Record.FieldOrDefault(r, "Ide_tpNF", null)
                    in
                        if v = "0" then
                            "Entrada"
                        else if v = "1" then
                            "Saida"
                        else
                            null
            ),
            Deriv(
                "Ide_idDest_DESC",
                "text",
                (r as record) =>
                    let
                        v = Record.FieldOrDefault(r, "Ide_idDest", null)
                    in
                        if v = "1" then
                            "Interna"
                        else if v = "2" then
                            "Interestadual"
                        else if v = "3" then
                            "Exterior"
                        else
                            null
            ),
            Deriv(
                "Ide_finNFe_DESC",
                "text",
                (r as record) =>
                    let
                        v = Record.FieldOrDefault(r, "Ide_finNFe", null)
                    in
                        if v = "1" then
                            "Normal"
                        else if v = "2" then
                            "Complementar"
                        else if v = "3" then
                            "Ajuste"
                        else if v = "4" then
                            "Devolucao/Retorno"
                        else
                            null
            ),
            Deriv(
                "Ide_indFinal_DESC",
                "text",
                (r as record) =>
                    let
                        v = Record.FieldOrDefault(r, "Ide_indFinal", null)
                    in
                        if v = "0" then
                            "Nao consumidor final"
                        else if v = "1" then
                            "Consumidor final"
                        else
                            null
            ),
            Deriv(
                "Ide_indPres_DESC",
                "text",
                (r as record) =>
                    let
                        v = Record.FieldOrDefault(r, "Ide_indPres", null)
                    in
                        if v = "0" then
                            "Nao se aplica"
                        else if v = "1" then
                            "Operacao presencial"
                        else if v = "2" then
                            "Internet"
                        else if v = "3" then
                            "Teleatendimento"
                        else if v = "4" then
                            "NFC-e entrega domicilio"
                        else if v = "5" then
                            "Presencial fora do estabelecimento"
                        else if v = "9" then
                            "Outros"
                        else
                            null
            ),
            Deriv(
                "Ide_procEmi_DESC",
                "text",
                (r as record) =>
                    let
                        v = Record.FieldOrDefault(r, "Ide_procEmi", null)
                    in
                        if v = "0" then
                            "Aplicativo contribuinte"
                        else if v = "1" then
                            "Avulsa Fisco"
                        else if v = "2" then
                            "Avulsa Fisco site"
                        else if v = "3" then
                            "Aplicativo Fisco"
                        else
                            null
            )
        }
    ]
in
    LAYOUT_NFE_BASE
