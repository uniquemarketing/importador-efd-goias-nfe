let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC186 =
        [
            Registro = "C186",
            Fields = {
                Field("NUM_ITEM", 2, "int"),
                Field("COD_ITEM", 3, "text"),
                Field("CST_ICMS", 4, "code3"),
                Field("CFOP", 5, "code4"),
                Field("COD_MOT_REST_COMPL", 6, "text"),
                Field("QUANT_CONV", 7, "num_pt_6"),
                Field("UNID", 8, "text"),
                Field("COD_MOD_ENTRADA", 9, "code2"),
                Field("SER_ENTRADA", 10, "text"),
                Field("NUM_DOC_ENTRADA", 11, "text"),
                Field("CHV_DFE_ENTRADA", 12, "code44"),
                Field("DT_DOC_ENTRADA", 13, "date8"),
                Field("NUM_ITEM_ENTRADA", 14, "int"),
                Field("VL_UNIT_CONV_ENTRADA", 15, "num_pt_6"),
                Field("VL_UNIT_BC_ICMS_UF_DEST", 16, "num_pt_6"),
                Field("ALIQ_ICMS_UF_DEST", 17, "num_pt_4"),
                Field("VL_UNIT_ICMS_UF_DEST", 18, "num_pt_6"),
                Field("VL_UNIT_BC_ICMS_ST", 19, "num_pt_6"),
                Field("ALIQ_ST", 20, "num_pt_4"),
                Field("VL_UNIT_RES", 21, "num_pt_6")
            },
            Derivados = {
                Deriv(
                    "CFOP_DIRECAO_DESC",
                    "text",
                    (r as record) as any =>
                        let
                            cfop = try Text.From(r[CFOP]) otherwise null,
                            p = if cfop = null or Text.Length(cfop) = 0 then null else Text.Start(cfop, 1)
                        in
                            if p = "1" or p = "2" or p = "3" then "Entrada"
                            else if p = "5" or p = "6" or p = "7" then "Saída"
                            else null
                )
            }
        ]
in
    LC186
