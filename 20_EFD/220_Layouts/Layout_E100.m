let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LE100 =
        [
            Registro = "E100",
            Fields = {
                Field("DT_INI", 2, "date"),
                Field("DT_FIN", 3, "date")
            },
            Derivados = {

            }
        ]
in
    LE100
