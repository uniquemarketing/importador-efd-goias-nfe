let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LG126 =
        [
            Registro = "G126",
            Fields = {
                Field("DT_INI", 2, "date"),
                Field("DT_FIN", 3, "date"),
                Field("NUM_PARC", 4, "int"),
                Field("VL_PARC_PASS", 5, "number")
            },
            Derivados = {

            }
        ]
in
    LG126
