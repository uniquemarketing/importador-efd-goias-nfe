let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LH005 =
        [
            Registro = "H005",
            Fields = {
                Field("DT_INV", 2, "date"),
                Field("VL_INV", 3, "number"),
                Field("MOT_INV", 4, "code2")
            },
            Derivados = {
                Deriv(
                    "MOT_INV_DESC",
                    "text",
                    (r as record) as any =>
                        let cod = try Text.From(r[MOT_INV]) otherwise null
                        in
                            if cod = "01" then "No final no periodo"
                            else if cod = "02" then "Mudanca de forma de tributacao da mercadoria (ICMS)"
                            else if cod = "03" then "Baixa cadastral, paralisacao temporaria e outras situacoes"
                            else if cod = "04" then "Alteracao de regime de pagamento"
                            else if cod = "05" then "Determinacao dos fiscos"
                            else if cod = "06" then "Controle ST: restituicao/ressarcimento/complementacao"
                            else null
                )
            }
        ]
in
    LH005
