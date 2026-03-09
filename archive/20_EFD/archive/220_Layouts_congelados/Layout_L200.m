let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LL200 =
        [
            Registro = "L200",
            Fields = {
                Field("COD_MOD", 2, "code2"),
                Field("SERIE", 3, "text"),
                Field("NUM_INI", 4, "int"),
                Field("NUM_FIN", 5, "int"),
                Field("QUANT", 6, "number"),
                Field("VL_UNIT", 7, "number"),
                Field("VL_TOTAL", 8, "number")
            },
            Derivados = {

            }
        ]
in
    LL200
