let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC350 =
        [
            Registro = "C350",
            Fields = {
                Field("SERIE", 2, "text"),
                Field("SUB", 3, "text"),
                Field("NUM_DOC", 4, "int"),
                Field("DT_DOC", 5, "date"),
                Field("CNPJ_CPF", 6, "text"),
                Field("VL_DOC", 7, "number"),
                Field("VL_DESC", 8, "number"),
                Field("VL_PIS", 9, "number"),
                Field("VL_COFINS", 10, "number"),
                Field("COD_CTA", 11, "text")
            },
            Derivados = {

            }
        ]
in
    LC350
