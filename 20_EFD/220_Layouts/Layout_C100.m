let
    // Layout do Registro C100 (SPED EFD ICMS/IPI)
    // Pos = número do campo conforme documentação oficial (campo 02 = Pos 2)

    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC100 =
        [
            Registro = "C100",
            Fields = {
                Field("IND_OPER",       2,  "text"),
                Field("IND_EMIT",       3,  "text"),
                Field("COD_PART",       4,  "text"),
                Field("COD_MOD",        5,  "text"),
                Field("COD_SIT",        6,  "text"),
                Field("SER",            7,  "text"),
                Field("NUM_DOC",        8,  "text"),
                Field("CHV_NFE",        9,  "text"),
                Field("DT_DOC",         10, "date8"),
                Field("DT_E_S",         11, "date8"),
                Field("VL_DOC",         12, "num_pt_2"),
                Field("IND_PGTO",       13, "text"),
                Field("VL_DESC",        14, "num_pt_2"),
                Field("VL_ABAT_NT",     15, "num_pt_2"),
                Field("VL_MERC",        16, "num_pt_2"),
                Field("IND_FRT",        17, "text"),
                Field("VL_FRT",         18, "num_pt_2"),
                Field("VL_SEG",         19, "num_pt_2"),
                Field("VL_OUT_DA",      20, "num_pt_2"),
                Field("VL_BC_ICMS",     21, "num_pt_2"),
                Field("VL_ICMS",        22, "num_pt_2"),
                Field("VL_BC_ICMS_ST",  23, "num_pt_2"),
                Field("VL_ICMS_ST",     24, "num_pt_2"),
                Field("VL_FCP",         25, "num_pt_2"),
                Field("VL_FCP_ST",      26, "num_pt_2"),
                Field("VL_FCP_ST_RET",  27, "num_pt_2"),
                Field("VL_IPI",         28, "num_pt_2"),
                Field("VL_PIS",         29, "num_pt_2"),
                Field("VL_COFINS",      30, "num_pt_2"),
                Field("VL_PIS_ST",      31, "num_pt_2"),
                Field("VL_COFINS_ST",   32, "num_pt_2")
            },
            Derivados = {
                Deriv(
                    "IND_OPER_DESC",
                    "text",
                    (r as record) as any =>
                        let c = try Text.From(r[IND_OPER]) otherwise null
                        in
                            if c = "0" then "Entrada"
                            else if c = "1" then "Saída"
                            else null
                ),
                Deriv(
                    "IND_EMIT_DESC",
                    "text",
                    (r as record) as any =>
                        let c = try Text.From(r[IND_EMIT]) otherwise null
                        in
                            if c = "0" then "Emissão própria"
                            else if c = "1" then "Terceiros"
                            else null
                ),
                Deriv(
                    "IND_PGTO_DESC",
                    "text",
                    (r as record) as any =>
                        let c = try Text.From(r[IND_PGTO]) otherwise null
                        in
                            if c = "0" then "À vista"
                            else if c = "1" then "A prazo"
                            else if c = "2" then "Outros"
                            else if c = "9" then "Sem pagamento"
                            else null
                ),
                Deriv(
                    "IND_FRT_DESC",
                    "text",
                    (r as record) as any =>
                        let c = try Text.From(r[IND_FRT]) otherwise null
                        in
                            if c = "0" then "Por conta do remetente (CIF)"
                            else if c = "1" then "Por conta do destinatário (FOB)"
                            else if c = "2" then "Por conta de terceiros"
                            else if c = "3" then "Transporte próprio por conta do remetente"
                            else if c = "4" then "Transporte próprio por conta do destinatário"
                            else if c = "9" then "Sem ocorrência de transporte"
                            else null
                )
            }
        ]
in
    LC100

