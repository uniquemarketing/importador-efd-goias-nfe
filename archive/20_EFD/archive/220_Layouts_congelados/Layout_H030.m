let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LH030 =
        [
            Registro = "H030",
            Fields = {
                Field("VL_ICMS_OP", 2, "number"),
                Field("VL_BC_ICMS_ST", 3, "number"),
                Field("VL_ICMS_ST", 4, "number"),
                Field("VL_FCP", 5, "number")
            },
            Derivados = {

            }
        ]
in
    LH030
