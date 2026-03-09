let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC191 =
        [
            Registro = "C191",
            Fields = {
                Field("VL_FCP_OP", 2, "number"),
                Field("VL_FCP_ST", 3, "number")
            },
            Derivados = {

            }
        ]
in
    LC191
