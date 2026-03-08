let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC180 =
        [
            Registro = "C180",
            Fields = {
                Field("COD_ITEM", 2, "text"),
                Field("UNID", 3, "text"),
                Field("QTD", 4, "number"),
                Field("VL_UNIT", 5, "number"),
                Field("VL_ITEM", 6, "number")
            },
            Derivados = {

            }
        ]
in
    LC180
