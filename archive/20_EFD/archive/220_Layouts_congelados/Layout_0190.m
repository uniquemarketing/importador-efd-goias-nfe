let
    // Layout do Registro 0190 (SPED EFD ICMS/IPI) - Identificação das unidades de medida
    // Pos = número do campo conforme documentação oficial (campo 02 = Pos 2)

    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    L0190 =
        [
            Registro = "0190",
            Fields = {
                Field("UNID", 2, "text"),
                Field("DESCR", 3, "text")
            },
            Derivados = {}
        ]
in
    L0190

