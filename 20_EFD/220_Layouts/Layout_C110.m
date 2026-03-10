let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC110 =
        [
            Registro = "C110",
            Fields = {
                Field("COD_INF", 2, "text"),
                Field("TXT_COMPL", 3, "text")
            },
            Derivados = {

            }
        ]
in
    LC110
