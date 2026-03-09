let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LE313 =
        [
            Registro = "E313",
            Fields = {
                Field("NUM_DOC", 6, "int")
            },
            Derivados = {

            }
        ]
in
    LE313
