let
    // Layout do Registro 0175 (SPED EFD ICMS/IPI)
    // Pos = número do campo conforme documentação oficial (campo 02 = Pos 2)

    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    L0175 =
        [
            Registro = "0175",
            Fields = {
                Field("DT_ALT", 2, "date8"),
                Field("NR_CAMPO", 3, "text"),
                Field("CONT_ANT", 4, "text")
                
            },
            Derivados = {}
        ]
in
    L0175

