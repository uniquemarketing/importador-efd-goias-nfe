let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC120 =
        [
            Registro = "C120",
            Fields = {
                Field("COD_DOC_IMP", 2, "code1"),
                Field("NUM_DOC_IMP", 3, "text"),
                Field("PIS_IMP", 4, "number"),
                Field("COFINS_IMP", 5, "number"),
                Field("NUM_ACDRAW", 6, "text")
            },
            Derivados = {

            }
        ]
in
    LC120
