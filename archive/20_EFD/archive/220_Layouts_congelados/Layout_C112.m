let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC112 =
        [
            Registro = "C112",
            Fields = {
                Field("COD_DA", 2, "code1"),
                Field("UF", 3, "text"),
                Field("NUM_DA", 4, "text"),
                Field("COD_AUT", 5, "text")
            },
            Derivados = {
                Deriv(
                    "COD_DA_DESC",
                    "text",
                    (r as record) as any =>
                        let cod = try Text.From(r[COD_DA]) otherwise null
                        in
                            if cod = "0" then "Documento estadual de arrecadacao"
                            else if cod = "1" then "GNRE"
                            else null
                )
            }
        ]
in
    LC112
