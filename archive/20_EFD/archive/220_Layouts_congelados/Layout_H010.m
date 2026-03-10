let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LH010 =
        [
            Registro = "H010",
            Fields = {
                Field("COD_ITEM", 2, "text"),
                Field("UNID", 3, "text"),
                Field("QTD", 4, "number"),
                Field("VL_UNIT", 5, "number"),
                Field("VL_ITEM", 6, "number"),
                Field("IND_PROP", 7, "code1"),
                Field("COD_PART", 8, "text"),
                Field("TXT_COMPL", 9, "text"),
                Field("COD_CTA", 10, "text"),
                Field("VL_ITEM_IR", 11, "number")
            },
            Derivados = {
                Deriv(
                    "POSSE_DESC",
                    "text",
                    (r as record) as any => let p = r[IND_PROP] in 
if p="1" then "Item próprio em poder do informante" 
else if p="2" then "Item próprio em poder de terceiros" 
else "Item de terceiros em poder do informante"
                )
            }
        ]
in
    LH010
