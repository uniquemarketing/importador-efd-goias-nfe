let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC195 =
        [
            Registro = "C195",
            Fields = {
                Field("COD_OBS", 2, "text"),
                Field("TXT_COMPL", 3, "text")
            },
            Derivados = {

            }
        ]
in
    LC195
