let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LE250 =
        [
            Registro = "E250",
            Fields = {
                Field("VL_OR", 3, "number"),
                Field("DT_VCTO", 4, "date")
            },
            Derivados = {

            }
        ]
in
    LE250
