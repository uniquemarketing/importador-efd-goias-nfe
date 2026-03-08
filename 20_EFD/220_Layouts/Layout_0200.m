let
    // Funções auxiliares locais para definição de metadados
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    // Definição do Layout conforme Guia Prático da EFD ICMS/IPI
    L0200 =
        [
            Registro = "0200",
            Fields = {
                Field("COD_ITEM",      2,  "text"),
                Field("DESCR_ITEM",    3,  "text"),
                Field("COD_BARRA",     4,  "text"),
                Field("COD_ANT_ITEM",  5,  "text"),
                Field("UNID_INV",      6,  "text"),
                Field("TIPO_ITEM",     7,  "text"),
                Field("COD_NCM",       8,  "text"),
                Field("EX_IPI",        9,  "text"),
                Field("COD_GEN",       10, "text"),
                Field("COD_LST",       11, "text"),
                Field("ALIQ_ICMS",     12, "num_pt_2"),
                Field("CEST",          13, "text")
            },
            Derivados = {
                Deriv(
                    "TIPO_ITEM_DESC",
                    "text",
                    (r as record) as any =>
                        let 
                            raw = try Text.From(r[TIPO_ITEM]) otherwise null,
                            cod = if raw = null or Text.Trim(raw) = "" then null else Text.PadStart(Text.Trim(raw), 2, "0")
                        in
                            if cod = "00" then "Mercadoria para Revenda"
                            else if cod = "01" then "Matéria-prima"
                            else if cod = "02" then "Embalagem"
                            else if cod = "03" then "Produto em Processo"
                            else if cod = "04" then "Produto Acabado"
                            else if cod = "05" then "Subproduto"
                            else if cod = "06" then "Produto Intermediário"
                            else if cod = "07" then "Material de Uso e Consumo"
                            else if cod = "08" then "Ativo Imobilizado"
                            else if cod = "09" then "Serviços"
                            else if cod = "10" then "Outros insumos"
                            else if cod = "99" then "Outras"
                            else null
                )
            }
        ]
in
    L0200

