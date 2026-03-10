let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC185 =
        [
            Registro = "C185",
            Fields = {
                Field("NUM_ITEM", 2, "int"),
                Field("COD_ITEM", 3, "text"),
                Field("CST_ICMS", 4, "code3"),
                Field("CFOP", 5, "code4"),
                Field("COD_MOT_REST_COMPL", 6, "text"),
                Field("QUANT_CONV", 7, "num_pt_6"),
                Field("UNID", 8, "text"),
                Field("VL_UNIT_CONV", 9, "num_pt_6"),
                Field("VL_UNIT_ICMS_NA_OPERACAO_CONV", 10, "num_pt_6"),
                Field("VL_UNIT_ICMS_OP_CONV", 11, "num_pt_6"),
                Field("VL_UNIT_ICMS_OP_ESTOQUE_CONV", 12, "num_pt_6"),
                Field("VL_UNIT_ICMS_ST_ESTOQUE_CONV", 13, "num_pt_6"),
                Field("VL_UNIT_FCP_ICMS_ST_ESTOQUE_CONV", 14, "num_pt_6"),
                Field("VL_UNIT_ICMS_ST_CONV_REST", 15, "num_pt_6"),
                Field("VL_UNIT_FCP_ST_CONV_REST", 16, "num_pt_6"),
                Field("VL_UNIT_ICMS_ST_CONV_COMPL", 17, "num_pt_6"),
                Field("VL_UNIT_FCP_ST_CONV_COMPL", 18, "num_pt_6")
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
    LC185
