let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC330 =
        [
            Registro = "C330",
            Fields = {
                Field("COD_MOT_REST_COMPL", 2, "code1"),
                Field("VL_REST_ICMS_MOT", 3, "number"),
                Field("VL_COMPL_ICMS_MOT", 4, "number")
            },
            Derivados = {

            }
        ]
in
    LC330
