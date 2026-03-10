let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LE300 =
        [
            Registro = "E300",
            Fields = {
                Field("UF", 2, "text"),
                Field("DT_INI", 3, "date8"),
                Field("DT_FIN", 4, "date8")
            },
            Derivados = {

            }
        ]
in
    LE300
