let
    // Layout do Registro 0000 (SPED EFD ICMS/IPI)
    // Pos = número do campo conforme documentação oficial (campo 02 = Pos 2)

    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    L0000 =
        [
            Registro = "0000",
            Fields = {
                Field("COD_VER",     2,  "text"),
                Field("COD_FIN",     3,  "text"),
                Field("DT_INI",      4,  "date8"),
                Field("DT_FIN",      5,  "date8"),
                Field("NOME",        6,  "text"),
                Field("CNPJ",        7,  "text"),
                Field("CPF",         8,  "text"),
                Field("UF",          9,  "text"),
                Field("IE",          10, "text"),
                Field("COD_MUN",     11, "text"),   // manter text para não perder zeros à esquerda
                Field("IM",          12, "text"),
                Field("SUFRAMA",     13, "text"),
                Field("IND_PERFIL",  14, "text"),
                Field("IND_ATIV",    15, "text")
            },
            Derivados = {
                Deriv(
                    "FINALIDADE",
                    "text",
                    (r as record) as any =>
                        let c = try Text.From(r[COD_FIN]) otherwise null
                        in
                            if c = "0" then "Remessa do arquivo original"
                            else if c = "1" then "Remessa do arquivo substituto"
                            else if c = "2" then "Remessa do arquivo retificador"
                            else null
                ),
                Deriv(
                    "ATIVIDADE",
                    "text",
                    (r as record) as any =>
                        let a = try Text.From(r[IND_ATIV]) otherwise null
                        in
                            if a = "0" then "Industrial ou equiparado a industrial"
                            else if a = "1" then "Outros"
                            else null
                )
            }
        ]
in
    L0000

