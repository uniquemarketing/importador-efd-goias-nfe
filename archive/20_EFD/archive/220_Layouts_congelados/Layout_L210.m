let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LL210 =
        [
            Registro = "L210",
            Fields = {
                Field("COD_ITEM", 2, "text"),
                Field("QTD_SAIDA", 3, "number")
            },
            Derivados = {

            }
        ]
in
    LL210
