let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC300 =
        [
            Registro = "C300",
            Fields = {
                Field("COD_MOD", 2, "code2"),
                Field("SERIE", 3, "text"),
                Field("SUB", 4, "text"),
                Field("NUM_DOC_INI", 5, "int"),
                Field("NUM_DOC_FIN", 6, "int"),
                Field("DT_DOC", 7, "date"),
                Field("VL_DOC", 8, "number"),
                Field("VL_PIS", 9, "number"),
                Field("VL_COFINS", 10, "number")
            },
            Derivados = {
                Deriv(
                    "Modelo_Desc",
                    "text",
                    (r as record) as any => if r[COD_MOD] = "02" then "Nota Fiscal de Venda a Consumidor" else "Outros"
                )
            }
        ]
in
    LC300
