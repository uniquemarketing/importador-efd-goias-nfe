let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC105 =
        [
            Registro = "C105",
            Fields = {
                Field("OPER", 2, "code1"),
                Field("UF", 3, "text")
            },
            Derivados = {
                Deriv(
                    "OPER_DESC",
                    "text",
                    (r as record) as any =>
                        let cod = try Text.From(r[OPER]) otherwise null
                        in
                            if cod = "0" then "Entrada"
                            else if cod = "1" then "Saida"
                            else null
                )
            }
        ]
in
    LC105
