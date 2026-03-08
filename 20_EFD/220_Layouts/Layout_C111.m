let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC111 =
        [
            Registro = "C111",
            Fields = {
                Field("NUM_PROC", 2, "text"),
                Field("IND_PROC", 3, "code1")
            },
            Derivados = {
                Deriv(
                    "IND_PROC_DESC",
                    "text",
                    (r as record) as any =>
                        let cod = try Text.From(r[IND_PROC]) otherwise null
                        in
                            if cod = "0" then "SEFAZ"
                            else if cod = "1" then "Justica Federal"
                            else if cod = "2" then "Justica Estadual"
                            else if cod = "3" then "SECEX/SRF"
                            else if cod = "9" then "Outros"
                            else null
                )
            }
        ]
in
    LC111
