let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC310 =
        [
            Registro = "C310",
            Fields = {
                Field("NUM_DOC_CANC", 2, "int")
            },
            Derivados = {

            }
        ]
in
    LC310
