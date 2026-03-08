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
                Field("CST_ICMS", 10, "code3"),
                Field("CFOP", 11, "code4"),
                Field("IND_MOV", 38, "code1")
            },
            Derivados = {
                Deriv(
                    "IND_MOV_DESC",
                    "text",
                    (r as record) as any =>
                        let cod = try Text.From(r[IND_MOV]) otherwise null
                        in
                            if cod = "0" then "Sim"
                            else if cod = "1" then "Nao"
                            else null
                ),
                Deriv(
                    "Origem_Mercadoria",
                    "text",
                    (r as record) as any => Text.Start(r[CST_ICMS], 1)
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
                )
            }
        ]
in
    LC170
