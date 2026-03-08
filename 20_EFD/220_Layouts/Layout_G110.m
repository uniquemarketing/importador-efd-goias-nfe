let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LG110 =
        [
            Registro = "G110",
            Fields = {
                Field("DT_INI", 2, "date"),
                Field("DT_FIN", 3, "date"),
                Field("SALDO_INIC_IA", 4, "number"),
                Field("SOM_PARC", 5, "number"),
                Field("VL_PARC_PASS", 6, "number"),
                Field("VL_FORF", 7, "number"),
                Field("VL_POT", 8, "number"),
                Field("VL_REST_ICMS", 9, "number")
            },
            Derivados = {

            }
        ]
in
    LG110
