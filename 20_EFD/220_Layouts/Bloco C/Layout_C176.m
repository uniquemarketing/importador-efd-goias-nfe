let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC176 =
        [
            Registro = "C176",
            Fields = {
                Field("COD_MOD_ULT_E", 2, "code2"),
                Field("NUM_DOC_ULT_E", 3, "text"),
                Field("SER_ULT_E", 4, "text"),
                Field("DT_ULT_E", 5, "date8"),
                Field("COD_PART_ULT_E", 6, "text"),
                Field("QUANT_ULT_E", 7, "num_pt_3"),
                Field("VL_UNIT_ULT_E", 8, "num_pt_3"),
                Field("VL_UNIT_BC_ST", 9, "num_pt_3"),
                Field("CHV_NFE_ULT_E", 10, "code44"),
                Field("NUM_ITEM_ULT_E", 11, "int"),
                Field("VL_UNIT_BC_ICMS_ULT_E", 12, "num_pt_2"),
                Field("ALIQ_ICMS_ULT_E", 13, "num_pt_4"),
                Field("VL_UNIT_LIMITE_BC_ICMS_ULT_E", 14, "num_pt_2"),
                Field("VL_UNIT_ICMS_ULT_E", 15, "num_pt_3"),
                Field("ALIQ_ST_ULT_E", 16, "num_pt_4"),
                Field("VL_UNIT_RES", 17, "num_pt_3"),
                Field("COD_RESP_RET", 18, "code1"),
                Field("COD_MOT_RES", 19, "code1"),
                Field("CHV_NFE_RET", 20, "code44"),
                Field("COD_PART_NFE_RET", 21, "text"),
                Field("SER_NFE_RET", 22, "text"),
                Field("NUM_NFE_RET", 23, "text"),
                Field("ITEM_NFE_RET", 24, "int"),
                Field("COD_DA", 25, "code1"),
                Field("NUM_DA", 26, "text")
            },
            Derivados = {

            }
        ]
in
    LC176
