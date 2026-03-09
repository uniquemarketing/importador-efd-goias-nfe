let
    // Funções auxiliares locais para definição de metadados
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    // Definição do Layout conforme Guia Prático da EFD ICMS/IPI
    L0220 =
        [
            Registro = "0220",
            Fields = {
                Field("UNID_CONV", 2, "text"),
                Field("FAT_CONV",  3, "num_pt_5")
            },
            Derivados = {}
        ]
in
    L0220

