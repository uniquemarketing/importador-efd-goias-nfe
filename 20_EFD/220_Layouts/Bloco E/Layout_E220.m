let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LE220 =
        [
            Registro = "E220",
            Fields = {
                Field("COD_AJ_APUR", 2, "text"),
                Field("DESCR_COMPL_AJ", 3, "text"),
                Field("VL_AJ_APUR", 4, "number")
            },
            Derivados = {

            }
        ]
in
    LE220
