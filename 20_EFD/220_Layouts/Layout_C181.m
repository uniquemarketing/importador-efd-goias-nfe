let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC181 =
        [
            Registro = "C181",
            Fields = {
                Field("COD_ITEM", 2, "text"),
                Field("UNID", 3, "text")
            },
            Derivados = {

            }
        ]
in
    LC181
