let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LE210 =
        [
            Registro = "E210",
            Fields = {
                Field("IND_MOV_ST", 2, "code1"),
                Field("VL_SLD_CRED_ANT_ST", 3, "number"),
                Field("VL_DEBITOS_ST", 4, "number"),
                Field("VL_ICMS_RECOL_ST", 14, "number")
            },
            Derivados = {
                Deriv(
                    "IND_MOV_ST_DESC",
                    "text",
                    (r as record) as any =>
                        let cod = try Text.From(r[IND_MOV_ST]) otherwise null
                        in
                            if cod = "0" then "Com movimento"
                            else if cod = "1" then "Sem movimento"
                            else null
                )
            }
        ]
in
    LE210
