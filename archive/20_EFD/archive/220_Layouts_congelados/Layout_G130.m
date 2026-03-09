let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LG130 =
        [
            Registro = "G130",
            Fields = {
                Field("IND_EMIT", 2, "code1"),
                Field("COD_PART", 3, "text"),
                Field("COD_MOD", 4, "code2"),
                Field("SERIE", 5, "text"),
                Field("NUM_DOC", 6, "int"),
                Field("DT_DOC", 7, "date"),
                Field("CHV_NFE", 8, "text")
            },
            Derivados = {
                Deriv(
                    "IND_EMIT_DESC",
                    "text",
                    (r as record) as any =>
                        let cod = try Text.From(r[IND_EMIT]) otherwise null
                        in
                            if cod = "0" then "Emissao propria"
                            else if cod = "1" then "Terceiros"
                            else null
                )
            }
        ]
in
    LG130
