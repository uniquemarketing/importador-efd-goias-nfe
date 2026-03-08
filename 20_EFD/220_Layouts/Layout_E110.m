let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LE110 =
        [
            Registro = "E110",
            Fields = {
                Field("VL_TOT_DEBITOS", 2, "number"),
                Field("VL_AJ_DEBITOS", 3, "number"),
                Field("VL_TOT_AJ_DEBITOS", 4, "number"),
                Field("VL_ESTORNOS_CRED", 5, "number"),
                Field("VL_TOT_CREDITOS", 6, "number"),
                Field("VL_AJ_CREDITOS", 7, "number"),
                Field("VL_TOT_AJ_CREDITOS", 8, "number"),
                Field("VL_ESTORNOS_DEB", 9, "number"),
                Field("VL_SLD_CREDOR_ANT", 10, "number"),
                Field("VL_SLD_APURADO", 11, "number"),
                Field("VL_TOT_DED", 12, "number"),
                Field("VL_ICMS_RECOLHER", 13, "number"),
                Field("VL_SLD_CREDOR_TRANSPORTAR", 14, "number"),
                Field("DEB_ESP", 15, "number")
            },
            Derivados = {

            }
        ]
in
    LE110
