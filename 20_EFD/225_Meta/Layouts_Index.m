let
    // Layouts_Index (catalogo de layouts prontos)
    // Cada layout e uma query separada: Layout_0000, Layout_C100, Layout_C170, etc.

    Itens = {
        { "0000", Layout_0000 },
        { "0150", Layout_0150 },
        { "0175", Layout_0175 },
        { "0460", Layout_0460 },
        { "C100", Layout_C100 },
        { "C101", Layout_C101 },
        { "C105", Layout_C105 },
        { "C170", Layout_C170 },
        { "C176", Layout_C176 },
        { "C179", Layout_C179 },
        { "C180", Layout_C180 },
        { "C181", Layout_C181 },
        { "C185", Layout_C185 },
        { "C186", Layout_C186 },
        { "C190", Layout_C190 },
        { "C195", Layout_C195 },
        { "C197", Layout_C197 },
        { "E100", Layout_E100 },
        { "E110", Layout_E110 },
        { "E111", Layout_E111 },
        { "E112", Layout_E112 },
        { "E113", Layout_E113 },
        { "E115", Layout_E115 },
        { "E116", Layout_E116 },
        { "E200", Layout_E200 },
        { "E210", Layout_E210 },
        { "E220", Layout_E220 },
        { "E230", Layout_E230 },
        { "E240", Layout_E240 },
        { "E250", Layout_E250 },
        { "E300", Layout_E300 },
        { "E310", Layout_E310 },
        { "E311", Layout_E311 },
        { "E312", Layout_E312 },
        { "E313", Layout_E313 },
        { "E316", Layout_E316 }
    },

    T =
        #table(
            type table [Registro = text, Layout = nullable record],
            Itens
        )
in
    T
