let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LE113 =
        [
            Registro = "E113",
            Fields = {
                Field("COD_PART", 2, "text"),
                Field("COD_MOD", 3, "code2"),
                Field("SERIE", 4, "text"),
                Field("SUB", 5, "text"),
                Field("NUM_DOC", 6, "int"),
                Field("DT_DOC", 7, "date"),
                Field("COD_ITEM", 8, "text"),
                Field("VL_AJ_ITEM", 9, "number")
            },
            Derivados = {

            }
        ]
in
    LE113
