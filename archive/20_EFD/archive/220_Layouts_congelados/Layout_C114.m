let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC114 =
        [
            Registro = "C114",
            Fields = {
                Field("COD_MOD", 2, "code2"),
                Field("ECF_FAB", 3, "text"),
                Field("ECF_CX", 4, "text"),
                Field("NUM_DOC", 5, "text"),
                Field("DT_DOC", 6, "date")
            },
            Derivados = {

            }
        ]
in
    LC114
