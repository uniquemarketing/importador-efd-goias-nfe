let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    L0400 =
        [
            Registro = "0400",
            Fields = {
                Field("REG", 1, "text"),
                Field("COD_NAT", 2, "text"),
                Field("DESCR_NAT", 3, "text")
            },
            Derivados = {

            }
        ]
in
    L0400
