let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC197 =
        [
            Registro = "C197",
            Fields = {
                Field("COD_AJ", 2, "text"),
                Field("DESCR_COMPL", 3, "text"),
                Field("COD_ITEM", 4, "text"),
                Field("VL_BC_ICMS", 5, "number"),
                Field("ALIQ_ICMS", 6, "number"),
                Field("VL_ICMS", 7, "number"),
                Field("VL_OUTROS", 8, "number")
            },
            Derivados = {

            }
        ]
in
    LC197
