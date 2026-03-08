let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC185 =
        [
            Registro = "C185",
            Fields = {
                Field("NUM_ITEM", 2, "int"),
                Field("COD_ITEM", 3, "text")
            },
            Derivados = {

            }
        ]
in
    LC185
