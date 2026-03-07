let
    Field = (tag as text, alias as text, path as list, kind as text) as record =>
        [Tag = tag, Alias = alias, Path = path, Kind = kind],
    Deriv = (name as text, kind as text, fn as function) as record => [Name = name, Kind = kind, Fn = fn],
    LAYOUT_NFE_BASE = [
        Tabela = "LAYOUT_NFE_BASE",
        Multiplicidade = "1:1",
        RootPath = {},
        Fields = {
            Field("versao", "Versão XML", {"NFe", "infNFe", "Attribute:versao"}, "text"),
            Field("id", "Id XML", {"NFe", "infNFe", "Attribute:Id"}, "text"),
            // NÃO conflita com a coluna do inventário
            // No arquivo LAYOUT_NFE_BASE.M, substitua a linha da chNFe por esta:
            Field("chNFe", "Chave de Acesso", {"protNFe", "infProt", "chNFe"}, "text"),
            Field("cUF", "cUF", {"NFe", "infNFe", "ide", "cUF"}, "code2"),
            Field("natOp", "Natureza Operação", {"NFe", "infNFe", "ide", "natOp"}, "text"),
            Field("mod", "Modelo", {"NFe", "infNFe", "ide", "mod"}, "code2"),
            Field("serie", "Série", {"NFe", "infNFe", "ide", "serie"}, "text"),
            Field("nNF", "Número NF", {"NFe", "infNFe", "ide", "nNF"}, "text"),
            Field("dhEmi", "dhEmi_xml", {"NFe", "infNFe", "ide", "dhEmi"}, "datetime"),
            Field("tpNF", "tpNF", {"NFe", "infNFe", "ide", "tpNF"}, "text"),
            Field("idDest", "idDest", {"NFe", "infNFe", "ide", "idDest"}, "text"),
            Field("cMunFG", "cMunFG", {"NFe", "infNFe", "ide", "cMunFG"}, "text"),
            Field("finNFe", "finNFe", {"NFe", "infNFe", "ide", "finNFe"}, "text"),
            Field("indFinal", "indFinal", {"NFe", "infNFe", "ide", "indFinal"}, "text"),
            Field("indPres", "indPres", {"NFe", "infNFe", "ide", "indPres"}, "text"),
            Field("indIntermed", "indIntermed", {"NFe", "infNFe", "ide", "indIntermed"}, "text"),
            Field("procEmi", "procEmi", {"NFe", "infNFe", "ide", "procEmi"}, "text"),
            Field("refNFe", "Ref NFe", {"NFe", "infNFe", "ide", "NFref", "refNFe"}, "text"),
            Field("refCTe", "Ref CTe", {"NFe", "infNFe", "ide", "NFref", "refCTe"}, "text"),
            Field("CNPJ", "Emitente CNPJ", {"NFe", "infNFe", "emit", "CNPJ"}, "text"),
            Field("CPF", "Emitente CPF", {"NFe", "infNFe", "emit", "CPF"}, "text"),
            Field("xNome", "Emitente Razão Social", {"NFe", "infNFe", "emit", "xNome"}, "text"),
            Field("xFant", "Emitente Nome Fantasia", {"NFe", "infNFe", "emit", "xFant"}, "text"),
            Field("cMun", "Emitente cMun", {"NFe", "infNFe", "emit", "enderEmit", "cMun"}, "text"),
            Field("xMun", "Emitente Município", {"NFe", "infNFe", "emit", "enderEmit", "xMun"}, "text"),
            Field("UF", "Emitente UF", {"NFe", "infNFe", "emit", "enderEmit", "UF"}, "text"),
            Field("IE", "Emitente IE", {"NFe", "infNFe", "emit", "IE"}, "text"),
            Field("IEST", "Emitente IEST", {"NFe", "infNFe", "emit", "IEST"}, "text"),
            Field("CNPJ", "Destinatário CNPJ", {"NFe", "infNFe", "dest", "CNPJ"}, "text"),
            Field("CPF", "Destinatário CPF", {"NFe", "infNFe", "dest", "CPF"}, "text"),
            Field("idEstrangeiro", "Destinatário Id Estrangeiro", {"NFe", "infNFe", "dest", "idEstrangeiro"}, "text"),
            Field("xNome", "Destinatário Nome", {"NFe", "infNFe", "dest", "xNome"}, "text"),
            Field("indIEDest", "indIEDest", {"NFe", "infNFe", "dest", "indIEDest"}, "text"),
            Field("IE", "Destinatário IE", {"NFe", "infNFe", "dest", "IE"}, "text"),
            Field("cMun", "Destinatário cMun", {"NFe", "infNFe", "dest", "enderDest", "cMun"}, "text"),
            Field("xMun", "Destinatário Município", {"NFe", "infNFe", "dest", "enderDest", "xMun"}, "text"),
            Field("UF", "Destinatário UF", {"NFe", "infNFe", "dest", "enderDest", "UF"}, "text"),
            Field("CNPJ", "Retirada CNPJ", {"NFe", "infNFe", "retirada", "CNPJ"}, "text"),
            Field("CPF", "Retirada CPF", {"NFe", "infNFe", "retirada", "CPF"}, "text"),
            Field("xNome", "Retirada Nome", {"NFe", "infNFe", "retirada", "xNome"}, "text"),
            Field("cMun", "Retirada cMun", {"NFe", "infNFe", "retirada", "enderRetirada", "cMun"}, "text"),
            Field("xMun", "Retirada Município", {"NFe", "infNFe", "retirada", "enderRetirada", "xMun"}, "text"),
            Field("UF", "Retirada UF", {"NFe", "infNFe", "retirada", "enderRetirada", "UF"}, "text"),
            Field("CNPJ", "Entrega CNPJ", {"NFe", "infNFe", "entrega", "CNPJ"}, "text"),
            Field("CPF", "Entrega CPF", {"NFe", "infNFe", "entrega", "CPF"}, "text"),
            Field("xNome", "Entrega Nome", {"NFe", "infNFe", "entrega", "xNome"}, "text"),
            Field("cMun", "Entrega cMun", {"NFe", "infNFe", "entrega", "enderEntrega", "cMun"}, "text"),
            Field("xMun", "Entrega Município", {"NFe", "infNFe", "entrega", "enderEntrega", "xMun"}, "text"),
            Field("UF", "Entrega UF", {"NFe", "infNFe", "entrega", "enderEntrega", "UF"}, "text"),
            Field("vBC", "BC ICMS", {"NFe", "infNFe", "total", "ICMSTot", "vBC"}, "13v2"),
            Field("vICMS", "ICMS", {"NFe", "infNFe", "total", "ICMSTot", "vICMS"}, "13v2"),
            Field("vICMSDeson", "ICMS Desonerado", {"NFe", "infNFe", "total", "ICMSTot", "vICMSDeson"}, "13v2"),
            Field("vFCPUFDest", "FCP UF Dest", {"NFe", "infNFe", "total", "ICMSTot", "vFCPUFDest"}, "13v2"),
            Field("vICMSUFDest", "ICMS UF Dest", {"NFe", "infNFe", "total", "ICMSTot", "vICMSUFDest"}, "13v2"),
            Field("vICMSUFRemet", "ICMS UF Remet", {"NFe", "infNFe", "total", "ICMSTot", "vICMSUFRemet"}, "13v2"),
            Field("vFCP", "FCP", {"NFe", "infNFe", "total", "ICMSTot", "vFCP"}, "13v2"),
            Field("vBCST", "BC ST", {"NFe", "infNFe", "total", "ICMSTot", "vBCST"}, "13v2"),
            Field("vST", "ST", {"NFe", "infNFe", "total", "ICMSTot", "vST"}, "13v2"),
            Field("vFCPST", "FCP ST", {"NFe", "infNFe", "total", "ICMSTot", "vFCPST"}, "13v2"),
            Field("vProd", "Produtos", {"NFe", "infNFe", "total", "ICMSTot", "vProd"}, "13v2"),
            Field("vFrete", "Frete", {"NFe", "infNFe", "total", "ICMSTot", "vFrete"}, "13v2"),
            Field("vSeg", "Seguro", {"NFe", "infNFe", "total", "ICMSTot", "vSeg"}, "13v2"),
            Field("vDesc", "Desconto", {"NFe", "infNFe", "total", "ICMSTot", "vDesc"}, "13v2"),
            Field("vII", "II", {"NFe", "infNFe", "total", "ICMSTot", "vII"}, "13v2"),
            Field("vIPI", "IPI", {"NFe", "infNFe", "total", "ICMSTot", "vIPI"}, "13v2"),
            Field("vIPIDevol", "IPI Devolvido", {"NFe", "infNFe", "total", "ICMSTot", "vIPIDevol"}, "13v2"),
            Field("vOutro", "Outras Despesas", {"NFe", "infNFe", "total", "ICMSTot", "vOutro"}, "13v2"),
            Field("vNF", "Valor NF", {"NFe", "infNFe", "total", "ICMSTot", "vNF"}, "13v2"),
            Field("vTotTrib", "Total Tributos", {"NFe", "infNFe", "total", "ICMSTot", "vTotTrib"}, "13v2"),
            Field("modFrete", "modFrete", {"NFe", "infNFe", "transp", "modFrete"}, "text"),
            Field("infAdFisco", "Info Adicional (Fisco)", {"NFe", "infNFe", "infAdic", "infAdFisco"}, "text"),
            Field("infCpl", "Info Complementar", {"NFe", "infNFe", "infAdic", "infCpl"}, "text")
        },
        Derivados = {
            Deriv(
                "tpNF_DESC",
                "text",
                (r as record) =>
                    let
                        v = Record.FieldOrDefault(r, "tpNF", null)
                    in
                        if v = "0" then
                            "Entrada"
                        else if v = "1" then
                            "Saída"
                        else
                            null
            ),
            Deriv(
                "idDest_DESC",
                "text",
                (r as record) =>
                    let
                        v = Record.FieldOrDefault(r, "idDest", null)
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
                "finNFe_DESC",
                "text",
                (r as record) =>
                    let
                        v = Record.FieldOrDefault(r, "finNFe", null)
                    in
                        if v = "1" then
                            "Normal"
                        else if v = "2" then
                            "Complementar"
                        else if v = "3" then
                            "Ajuste"
                        else if v = "4" then
                            "Devolução/Retorno"
                        else
                            null
            ),
            Deriv(
                "indFinal_DESC",
                "text",
                (r as record) =>
                    let
                        v = Record.FieldOrDefault(r, "indFinal", null)
                    in
                        if v = "0" then
                            "Não Consumidor Final"
                        else if v = "1" then
                            "Consumidor Final"
                        else
                            null
            ),
            Deriv(
                "indPres_DESC",
                "text",
                (r as record) =>
                    let
                        v = Record.FieldOrDefault(r, "indPres", null)
                    in
                        if v = "0" then
                            "Não se aplica"
                        else if v = "1" then
                            "Operação presencial"
                        else if v = "2" then
                            "Internet"
                        else if v = "3" then
                            "Teleatendimento"
                        else if v = "4" then
                            "NFC-e entrega domicílio"
                        else if v = "5" then
                            "Presencial fora do estabelecimento"
                        else if v = "9" then
                            "Outros"
                        else
                            null
            ),
            Deriv(
                "indIntermed_DESC",
                "text",
                (r as record) =>
                    let
                        v = Record.FieldOrDefault(r, "indIntermed", null)
                    in
                        if v = "0" then
                            "Sem intermediador"
                        else if v = "1" then
                            "Com intermediador"
                        else
                            null
            ),
            Deriv(
                "procEmi_DESC",
                "text",
                (r as record) =>
                    let
                        v = Record.FieldOrDefault(r, "procEmi", null)
                    in
                        if v = "0" then
                            "Aplicativo do contribuinte"
                        else if v = "1" then
                            "Avulsa Fisco"
                        else if v = "2" then
                            "Avulsa Fisco (site)"
                        else if v = "3" then
                            "Aplicativo Fisco"
                        else
                            null
            ),
            Deriv(
                "modFrete_DESC",
                "text",
                (r as record) =>
                    let
                        v = Record.FieldOrDefault(r, "modFrete", null)
                    in
                        if v = "0" then
                            "Emitente"
                        else if v = "1" then
                            "Destinatário"
                        else if v = "2" then
                            "Terceiros"
                        else if v = "3" then
                            "Próprio remetente"
                        else if v = "4" then
                            "Próprio destinatário"
                        else if v = "9" then
                            "Sem frete"
                        else
                            null
            )
        }
    ]
in
    LAYOUT_NFE_BASE
