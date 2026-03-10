let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC101 =
        [
            Registro = "C101",
            Fields = {
                Field("VL_FCP_UF_DEST", 2, "num_pt_2"),
                Field("VL_ICMS_UF_DEST", 3, "num_pt_2"),
                Field("VL_ICMS_UF_REM", 4, "num_pt_2")
            },
            Derivados = {

            }
        ]
in
    LC101
