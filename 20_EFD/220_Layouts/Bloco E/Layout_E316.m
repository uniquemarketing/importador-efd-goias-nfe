let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LE316 =
        [
            Registro = "E316",
            Fields = {
                Field("VL_OR", 3, "num_pt_2"),
                Field("DT_VCTO", 4, "date8")
            },
            Derivados = {

            }
        ]
in
    LE316
