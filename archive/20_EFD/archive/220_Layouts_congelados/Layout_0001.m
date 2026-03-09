let
    // Layout do Registro 0015 (SPED EFD ICMS/IPI)
    // Pos = número do campo conforme documentação oficial (campo 02 = Pos 2)

    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    L0001 =
        [
            Registro = "0001",
            Fields = {
                Field("IND_MOV", 2, "text")
                
            },
            Derivados = {
                Deriv(
                    "MOVIMENTO",
                    "text",
                    (r as record) as any =>
                        let c = try Text.From(r[IND_MOV]) otherwise null
                        in
                            if c = "0" then "Bloco com dados informados"
                            else if c = "1" then "Bloco sem dados informados"
                            else null
                )
            }
        ]
in
    L0001

