let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC176 =
        [
            Registro = "C176",
            Fields = {
                Field("COD_MOD_RET", 2, "code2"),
                Field("NUM_DOC_RET", 3, "text"),
                Field("SERIE_RET", 4, "text"),
                Field("DT_RET", 5, "date"),
                Field("COD_PART_RET", 6, "text")
            },
            Derivados = {

            }
        ]
in
    LC176
