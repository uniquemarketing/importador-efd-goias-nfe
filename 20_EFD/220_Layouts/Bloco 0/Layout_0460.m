let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    L0460 =
        [
            Registro = "0460",
            Fields = {
                Field("REG", 1, "text"),
                Field("COD_OBS", 2, "text"),
                Field("TXT", 3, "text")
            },
            Derivados = {

            }
        ]
in
    L0460
