let
    Fonte = #"101_xml_Arquivos_All",
    fnDataEmitNfeFromXmlTable = (xmlTable as table) as nullable datetime =>
        let
            xmlRoot = try xmlTable{0} otherwise null,
            ideNode = if xmlRoot = null then null else fnGetNestedValue(xmlRoot, {"NFe", "infNFe", "ide"}),
            ideRec =
                if ideNode = null then
                    null
                else if Value.Is(ideNode, type table) then
                    try ideNode{0} otherwise null
                else if Value.Is(ideNode, type record) then
                    ideNode
                else
                    null,
            dhEmiTxt =
                if ideRec = null then
                    null
                else
                    let
                        a = try fnGetNestedValue(ideRec, {"dhEmi"}) otherwise null,
                        b = try fnGetNestedValue(ideRec, {"dEmi"}) otherwise null
                    in
                        if a <> null and Text.Trim(Text.From(a)) <> "" then
                            Text.From(a)
                        else if b <> null and Text.Trim(Text.From(b)) <> "" then
                            Text.From(b)
                        else
                            null,
            dt =
                try
                    if dhEmiTxt = null then
                        null
                    else
                        let
                            z = DateTimeZone.FromText(dhEmiTxt), noZone = DateTimeZone.RemoveZone(z)
                        in
                            noZone
                    otherwise try if dhEmiTxt = null then null else DateTime.FromText(dhEmiTxt) otherwise null
        in
            dt,
    Filtra = Table.SelectRows(Fonte, each (try [TipoArquivo] otherwise null) = "NFe"),
    AddDhEmi = Table.AddColumn(Filtra, "dhEmi", each fnDataEmitNfeFromXmlTable([XmlTable]), type datetime),
    Sort = Table.Sort(AddDhEmi, {{"dhEmi", Order.Ascending}, {"FullPath", Order.Ascending}}),
    AddNfeId = Table.AddIndexColumn(Sort, "nfe_id", 1, 1, Int64.Type),
    AddMes = Table.AddColumn(
        AddNfeId, "dhMes", each if [dhEmi] = null then null else Date.StartOfMonth(Date.From([dhEmi])), type date
    ),
    SoComDhEmi = Table.SelectRows(AddMes, each [dhMes] <> null),
    GruposMes = Table.Group(
        SoComDhEmi,
        {"dhMes"},
        {
            {
                "AmostraMes",
                each Table.FirstN(Table.Sort(_, {{"dhEmi", Order.Ascending}, {"nfe_id", Order.Ascending}}), 5)
            }
        }
    ),
    ListaAmostras = GruposMes[AmostraMes],
    AmostraMensal = if List.Count(ListaAmostras) = 0 then Table.FirstN(AddNfeId, 0) else Table.Combine(ListaAmostras),
    SortAmostra = Table.Sort(AmostraMensal, {{"dhEmi", Order.Ascending}, {"nfe_id", Order.Ascending}}),
    Resultado = Table.RemoveColumns(SortAmostra, {"dhMes"})
in
    Resultado
