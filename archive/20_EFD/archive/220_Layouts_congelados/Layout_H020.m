let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LH020 =
        [
            Registro = "H020",
            Fields = {
                Field("CST_ICMS", 2, "code3"),
                Field("BC_ICMS", 3, "number"),
                Field("VL_ICMS", 4, "number")
            },
            Derivados = {
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
    LH020
