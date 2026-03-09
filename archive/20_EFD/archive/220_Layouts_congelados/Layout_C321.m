let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC321 =
        [
            Registro = "C321",
            Fields = {
                Field("COD_ITEM", 2, "text"),
                Field("QTD", 3, "number"),
                Field("UNID", 4, "text"),
                Field("VL_ITEM", 5, "number"),
                Field("VL_DESC", 6, "number"),
                Field("VL_BC_ICMS", 7, "number"),
                Field("VL_ICMS", 8, "number"),
                Field("VL_PIS", 9, "number"),
                Field("VL_COFINS", 10, "number")
            },
            Derivados = {

            }
        ]
in
    LC321
