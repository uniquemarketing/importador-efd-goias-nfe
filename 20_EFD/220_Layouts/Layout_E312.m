let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LE312 =
        [
            Registro = "E312",
            Fields = {
                Field("NUM_DA", 2, "text")
            },
            Derivados = {

            }
        ]
in
    LE312
