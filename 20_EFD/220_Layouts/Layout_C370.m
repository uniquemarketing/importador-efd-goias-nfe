let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC370 =
        [
            Registro = "C370",
            Fields = {
                Field("NUM_ITEM", 2, "int"),
                Field("COD_ITEM", 3, "text"),
                Field("QTD", 4, "number"),
                Field("UNID", 5, "text"),
                Field("VL_ITEM", 6, "number"),
                Field("VL_DESC", 7, "number")
            },
            Derivados = {

            }
        ]
in
    LC370
