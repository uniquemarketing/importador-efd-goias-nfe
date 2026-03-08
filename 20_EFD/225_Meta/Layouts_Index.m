let
    // Layouts_Index (catálogo de layouts prontos)
    // Cada layout é uma query separada: Layout_0000, Layout_C100, Layout_C170, etc.

    Itens = {
        { "0000", Layout_0000 },
        { "0001", Layout_0001 },
        { "0015", Layout_0015 },
        { "0150", Layout_0150 },
        { "0175", Layout_0175 },
        { "0190", Layout_0190 },
        { "0200", Layout_0200 },
        { "0205", Layout_0205 },
        { "C100", Layout_C100 }
        // { "0002", Layout_0002 },
        // { "C170", Layout_C170 }
    },

    T =
        #table(
            type table [Registro = text, Layout = nullable record],
            Itens
        )
in
    T

