let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC179 =
        [
            Registro = "C179",
            Fields = {
                Field("BC_ST_ORIG_DEST", 2, "num_pt_2"),
                Field("ICMS_ST_REP", 3, "num_pt_2"),
                Field("ICMS_ST_COMPL", 4, "num_pt_2"),
                Field("ICMS_RET", 5, "num_pt_2")
            },
            Derivados = {

            }
        ]
in
    LC179
