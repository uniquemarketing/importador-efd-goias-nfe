let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LG125 =
        [
            Registro = "G125",
            Fields = {
                Field("COD_BEM", 2, "text"),
                Field("DT_MOV", 3, "date"),
                Field("TIPO_MOV", 4, "code2"),
                Field("VL_IMOB_ICMS_OP", 5, "number"),
                Field("VL_IMOB_ICMS_ST", 6, "number"),
                Field("VL_IMOB_ICMS_FR", 7, "number"),
                Field("VL_IMOB_ICMS_DIF", 8, "number"),
                Field("NUM_PARC", 9, "int"),
                Field("VL_PARC_PASS", 10, "number")
            },
            Derivados = {
                Deriv(
                    "TIPO_MOV_DESC",
                    "text",
                    (r as record) as any =>
                        let cod = try Text.From(r[TIPO_MOV]) otherwise null
                        in
                            if cod = "SI" then "Saldo inicial de bens imobilizados"
                            else if cod = "IM" then "Imobilizacao de bem individual"
                            else if cod = "IA" then "Imobilizacao em andamento - Componente"
                            else if cod = "CI" then "Conclusao de imobilizacao em andamento"
                            else if cod = "MC" then "Imobilizacao oriunda do ativo circulante"
                            else if cod = "BA" then "Baixa do bem - fim da apropriacao"
                            else if cod = "AT" then "Alienacao ou transferencia"
                            else if cod = "PE" then "Perecimento, extravio ou deterioracao"
                            else if cod = "OT" then "Outras saidas do imobilizado"
                            else null
                )
            }
        ]
in
    LG125
