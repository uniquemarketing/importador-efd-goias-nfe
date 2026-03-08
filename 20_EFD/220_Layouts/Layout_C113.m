let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC113 =
        [
            Registro = "C113",
            Fields = {
                Field("IND_OPER", 2, "code1"),
                Field("IND_EMIT", 3, "code1"),
                Field("COD_PART", 4, "text"),
                Field("COD_MOD", 5, "code2"),
                Field("SERIE", 6, "text"),
                Field("NUM_DOC", 7, "text"),
                Field("DT_DOC", 8, "date"),
                Field("CHV_DFE", 9, "text")
            },
            Derivados = {
                Deriv(
                    "Tipo_Operacao_Desc",
                    "text",
                    (r as record) as any => if r[IND_OPER] = "0" then "Entrada" else "Saída"
                ),
                Deriv(
                    "IND_OPER_DESC",
                    "text",
                    (r as record) as any =>
                        let cod = try Text.From(r[IND_OPER]) otherwise null
                        in
                            if cod = "0" then "Entrada"
                            else if cod = "1" then "Saida"
                            else null
                ),
                Deriv(
                    "IND_EMIT_DESC",
                    "text",
                    (r as record) as any =>
                        let cod = try Text.From(r[IND_EMIT]) otherwise null
                        in
                            if cod = "0" then "Emissao propria"
                            else if cod = "1" then "Terceiros"
                            else null
                )
            }
        ]
in
    LC113
