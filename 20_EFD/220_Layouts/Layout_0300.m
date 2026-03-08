let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    L0300 =
        [
            Registro = "0300",
            Fields = {
                Field("REG", 1, "text"),
                Field("COD_IND_BEM", 2, "code1"),
                Field("IDENT_MERC", 3, "code1"),
                Field("DESCR_ITEM", 4, "text"),
                Field("COD_PRNC", 5, "text"),
                Field("COD_CTA", 6, "text"),
                Field("NR_PARC", 7, "int")
            },
            Derivados = {
                Deriv(
                    "Tipo_Bem_Desc",
                    "text",
                    (r as record) as any => if r[COD_IND_BEM] = "1" then "Bem" else "Componente"
                ),
                Deriv(
                    "Identificacao_Bem_Desc",
                    "text",
                    (r as record) as any => let v = r[IDENT_MERC] in if v = "1" then "Máquinas" else if v = "2" then "Equipamentos" else if v = "3" then "Ferramentas" else "Outros"
                )
            }
        ]
in
    L0300
