let
    Fonte = #table(
        type table [
            #"COD_SIT" = text,
            #"DESC_SIT" = text,
            #"INICIO" = date,
            #"FIM" = nullable date
        ],
        {
            {"00", "Documento regular", #date(2009, 1, 1), null},
            {"01", "Documento regular extemporâneo", #date(2009, 1, 1), null},
            {"02", "Documento cancelado", #date(2009, 1, 1), null},
            {"03", "Documento cancelado extemporâneo", #date(2009, 1, 1), null},
            {"04", "NFe ou CT-e denegada", #date(2009, 1, 1), #date(2022, 12, 31)},
            {"05", "NFe ou CT-e Numeração inutilizada", #date(2009, 1, 1), #date(2022, 12, 31)},
            {"06", "Documento Fiscal Complementar", #date(2009, 1, 1), #date(2022, 12, 31)},
            {"06", "Documento Fiscal Complementar", #date(2023, 1, 1), null},
            {"07", "Documento Fiscal Complementar extemporâneo", #date(2009, 1, 1), null},
            {"08", "Documento Fiscal emitido com base em Regime Especial ou Norma Específica", #date(2009, 1, 1), null},
            {"09", "09 Documento Fiscal Substiuído", #date(2018, 1, 1), #date(2018, 1, 2)},
            {"09", "Documento Fiscal Substituído", #date(2018, 1, 3), #date(2018, 1, 4)}
        }
    ),
    Final = Fonte
in
    Final