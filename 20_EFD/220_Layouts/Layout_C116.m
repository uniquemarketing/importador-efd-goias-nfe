let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC116 =
        [
            Registro = "C116",
            Fields = {
                Field("COD_MOD", 2, "code2"),
                Field("NR_SAT", 3, "text"),
                Field("CHV_CFE", 4, "text"),
                Field("NUM_CFE", 5, "text"),
                Field("DT_DOC", 6, "date")
            },
            Derivados = {

            }
        ]
in
    LC116
