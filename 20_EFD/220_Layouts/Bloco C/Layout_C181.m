let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC181 =
        [
            Registro = "C181",
            Fields = {
                Field("COD_MOT_REST_COMPL", 2, "text"),
                Field("QUANT_CONV", 3, "num_pt_6"),
                Field("UNID", 4, "text"),
                Field("COD_MOD_SAIDA", 5, "code2"),
                Field("SERIE_SAIDA", 6, "text"),
                Field("ECF_FAB_SAIDA", 7, "text"),
                Field("NUM_DOC_SAIDA", 8, "text"),
                Field("CHV_DFE_SAIDA", 9, "code44"),
                Field("DT_DOC_SAIDA", 10, "date8"),
                Field("NUM_ITEM_SAIDA", 11, "int"),
                Field("VL_UNIT_CONV_SAIDA", 12, "num_pt_6"),
                Field("VL_UNIT_ICMS_OP_ESTOQUE_CONV_SAIDA", 13, "num_pt_6"),
                Field("VL_UNIT_ICMS_ST_ESTOQUE_CONV_SAIDA", 14, "num_pt_6"),
                Field("VL_UNIT_FCP_ICMS_ST_ESTOQUE_CONV_SAIDA", 15, "num_pt_6"),
                Field("VL_UNIT_ICMS_NA_OPERACAO_CONV_SAIDA", 16, "num_pt_6"),
                Field("VL_UNIT_ICMS_OP_CONV_SAIDA", 17, "num_pt_6"),
                Field("VL_UNIT_ICMS_ST_CONV_REST", 18, "num_pt_6"),
                Field("VL_UNIT_FCP_ST_CONV_REST", 19, "num_pt_6"),
                Field("VL_UNIT_ICMS_ST_CONV_COMPL", 20, "num_pt_6"),
                Field("VL_UNIT_FCP_ST_CONV_COMPL", 21, "num_pt_6")
            },
            Derivados = {

            }
        ]
in
    LC181
