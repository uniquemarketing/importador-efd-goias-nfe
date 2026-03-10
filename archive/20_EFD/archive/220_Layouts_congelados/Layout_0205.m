let
    // Funções auxiliares locais para definição de metadados
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    // Definição do Layout conforme Guia Prático da EFD ICMS/IPI
    L0205 =
        [
            Registro = "0205",
            Fields = {
                Field("DESCR_ANT_ITEM", 2, "text"),
                Field("DT_INI",         3, "date8"),
                Field("DT_FIM",         4, "date8"),
                Field("COD_ANT_ITEM",   5, "text")
            },
            Derivados = {}
        ]
in
    L0205

