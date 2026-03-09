let
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    LC001 =
        [
            Registro = "C001",
            Fields = {
                Field("IND_MOV", 2, "code1")
            },
            Derivados = {
                Deriv(
                    "IND_MOV_DESC",
                    "text",
                    (r as record) as any => if r[IND_MOV] = "0" then "Bloco com dados informados" else "Bloco sem dados informados"
                )
            }
        ]
in
    LC001
