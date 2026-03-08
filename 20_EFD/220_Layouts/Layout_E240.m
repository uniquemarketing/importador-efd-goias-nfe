let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LE240 =
        [
            Registro = "E240",
            Fields = {
                Field("NUM_DOC", 6, "int"),
                Field("VL_AJ_ITEM", 9, "number")
            },
            Derivados = {

            }
        ]
in
    LE240
