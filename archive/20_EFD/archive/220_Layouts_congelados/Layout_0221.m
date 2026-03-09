let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    L0221 =
        [
            Registro = "0221",
            Fields = {
                Field("COD_ITEM_ORI", 2, "text"),
                Field("UNID_ORI", 3, "text"),
                Field("QTD_ORI", 4, "number")
            },
            Derivados = {

            }
        ]
in
    L0221
