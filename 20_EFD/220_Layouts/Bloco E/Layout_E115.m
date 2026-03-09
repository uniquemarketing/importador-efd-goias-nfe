let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LE115 =
        [
            Registro = "E115",
            Fields = {
                Field("COD_INF_ADIC", 2, "text"),
                Field("VL_INF_ADIC", 3, "number"),
                Field("DESCR_COMPL_AJ", 4, "text")
            },
            Derivados = {

            }
        ]
in
    LE115
