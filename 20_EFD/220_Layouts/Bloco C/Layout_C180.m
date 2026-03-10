let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC180 =
        [
            Registro = "C180",
            Fields = {
                Field("COD_RESP_RET", 2, "code1"),
                Field("QUANT_CONV", 3, "num_pt_6"),
                Field("UNID", 4, "text"),
                Field("VL_UNIT_CONV", 5, "num_pt_6"),
                Field("VL_UNIT_ICMS_OP_CONV", 6, "num_pt_6"),
                Field("VL_UNIT_BC_ICMS_ST_CONV", 7, "num_pt_6"),
                Field("VL_UNIT_ICMS_ST_CONV", 8, "num_pt_6"),
                Field("VL_UNIT_FCP_ST_CONV", 9, "num_pt_6"),
                Field("COD_DA", 10, "code1"),
                Field("NUM_DA", 11, "text")
            },
            Derivados = {
                Deriv(
                    "COD_RESP_RET_DESC",
                    "text",
                    (r as record) as any =>
                        let cod = try Text.From(r[COD_RESP_RET]) otherwise null
                        in
                            if cod = "1" then "Fornecedor"
                            else if cod = "2" then "Remetente"
                            else if cod = "9" then "Outros"
                            else null
                )
            }
        ]
in
    LC180
