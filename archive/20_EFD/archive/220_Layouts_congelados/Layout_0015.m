let
    // Layout do Registro 0015 (SPED EFD ICMS/IPI)
    // Pos = número do campo conforme documentação oficial (campo 02 = Pos 2)

    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    L0015 =
        [
            Registro = "0015",
            Fields = {
                Field("UF_ST", 2, "text"),
                Field("IE_ST", 3, "text")
            },
            Derivados = {}
        ]
in
    L0015

