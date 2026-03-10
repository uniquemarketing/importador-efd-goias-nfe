let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC177 =
        [
            Registro = "C177",
            Fields = {
                Field("COD_SELO", 2, "text"),
                Field("QT_SELO", 3, "number")
            },
            Derivados = {

            }
        ]
in
    LC177
