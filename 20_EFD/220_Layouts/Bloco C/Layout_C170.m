let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC170 =
        [
            Registro = "C170",
            Fields = {
                Field("NUM_ITEM", 2, "int"),
                Field("COD_ITEM", 3, "text"),
                Field("DESCR_COMPL", 4, "text"),
                Field("QTD", 5, "num_pt_5"),
                Field("UNID", 6, "text"),
                Field("VL_ITEM", 7, "num_pt_2"),
                Field("VL_DESC", 8, "num_pt_2"),
                Field("IND_MOV", 9, "code1"),
                Field("CST_ICMS", 10, "code3"),
                Field("CFOP", 11, "code4"),
                Field("VL_BC_ICMS", 13, "num_pt_2"),
                Field("ALIQ_ICMS", 14, "num_pt_4"),
                Field("VL_ICMS", 15, "num_pt_2"),
                Field("VL_BC_ICMS_ST", 16, "num_pt_2"),
                Field("ALIQ_ST", 17, "num_pt_4"),
                Field("VL_ICMS_ST", 18, "num_pt_2"),
                Field("IND_APUR", 19, "code1"),
                Field("CST_IPI", 20, "code2"),
                Field("COD_ENQ", 21, "code3"),
                Field("VL_BC_IPI", 22, "num_pt_2"),
                Field("ALIQ_IPI", 23, "num_pt_4"),
                Field("VL_IPI", 24, "num_pt_2")
            },
            Derivados = {
                Deriv(
                    "IND_MOV_DESC",
                    "text",
                    (r as record) as any =>
                        let cod = try Text.From(r[IND_MOV]) otherwise null
                        in
                            if cod = "0" then "Sim"
                            else if cod = "1" then "Não"
                            else null
                ),
                Deriv(
                    "Origem_Mercadoria",
                    "text",
                    (r as record) as any =>
                        let cst = try Text.From(r[CST_ICMS]) otherwise null
                        in if cst = null or cst = "" then null else Text.Start(Text.PadStart(cst, 3, "0"), 1)
                ),
                Deriv(
                    "CFOP_DIRECAO_DESC",
                    "text",
                    (r as record) as any =>
                        let
                            cfop = try Text.From(r[CFOP]) otherwise null,
                            p = if cfop = null or Text.Length(cfop) = 0 then null else Text.Start(cfop, 1)
                        in
                            if p = "1" or p = "2" or p = "3" then "Entrada"
                            else if p = "5" or p = "6" or p = "7" then "Saida"
                            else null
                ),
                Deriv(
                    "CST_ORIGEM_DESC",
                    "text",
                    (r as record) as any =>
                        let
                            cst = try Text.From(r[CST_ICMS]) otherwise null,
                            o = if cst = null or Text.Length(cst) = 0 then null else Text.Start(Text.PadStart(cst, 3, "0"), 1)
                        in
                            if o = "0" then "Nacional"
                            else if o = "1" then "Estrangeira - Importacao direta"
                            else if o = "2" then "Estrangeira - Mercado interno"
                            else if o = "3" then "Nacional com conteudo de importacao > 40%"
                            else if o = "4" then "Nacional por processo produtivo basico"
                            else if o = "5" then "Nacional com conteudo <= 40%"
                            else if o = "6" then "Estrangeira - Importacao direta sem similar"
                            else if o = "7" then "Estrangeira - Mercado interno sem similar"
                            else if o = "8" then "Nacional com conteudo de importacao > 70%"
                            else null
                ),
                Deriv(
                    "IND_APUR_DESC",
                    "text",
                    (r as record) as any =>
                        let cod = try Text.From(r[IND_APUR]) otherwise null
                        in
                            if cod = "0" then "Mensal"
                            else if cod = "1" then "Decendial"
                            else null
                )
            }
        ]
in
    LC170
