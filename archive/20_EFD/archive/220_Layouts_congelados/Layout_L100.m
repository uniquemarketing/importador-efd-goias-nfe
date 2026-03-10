let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LL100 =
        [
            Registro = "L100",
            Fields = {
                Field("COD_SELO", 2, "text"),
                Field("QUANT_INIC", 3, "number"),
                Field("QUANT_ENTR", 4, "number"),
                Field("QUANT_SAID", 5, "number"),
                Field("QUANT_REMAN", 6, "number")
            },
            Derivados = {

            }
        ]
in
    LL100
