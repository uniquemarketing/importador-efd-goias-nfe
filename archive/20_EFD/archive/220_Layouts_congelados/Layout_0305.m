let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    L0305 =
        [
            Registro = "0305",
            Fields = {
                Field("REG", 1, "text"),
                Field("COD_CCUS", 2, "text"),
                Field("FUNC_BEM", 3, "text"),
                Field("VIDA_UTIL", 4, "int")
            },
            Derivados = {

            }
        ]
in
    L0305
