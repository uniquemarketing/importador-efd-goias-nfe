let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    L0002 =
        [
            Registro = "0002",
            Fields = {
                Field("CLAS_ESTAB", 2, "code2")
            },
            Derivados = {
                Deriv(
                    "CLAS_ESTAB_DESC",
                    "text",
                    (r as record) as any =>
                        let cod = try Text.From(r[CLAS_ESTAB]) otherwise null
                        in
                            if cod = "01" then "Industrial"
                            else if cod = "02" then "Atacadista"
                            else if cod = "03" then "Varejista"
                            else null
                )
            }
        ]
in
    L0002
