let
    // ========================================================================
    // 1. CARREGAMENTO LEVE E EARLY COLUMN PRUNING 
    // ========================================================================
    Base0150 = Table.SelectColumns(R0150_base, {"ArquivoId", "Chave_Linha", "COD_PART", "NOME", "COD_PAIS", "COD_MUN", "IE", "CNPJ", "CPF"}, MissingField.Ignore),
    
    // BLINDAGEM: Buffer no lado DIREITO do Join (Impede a releitura do disco)
    Base0000_Buf = Table.Buffer(Table.SelectColumns(R0000_base, {"ArquivoId", "DT_INI", "DT_FIN"}, MissingField.Ignore)),

    Base0175_Raw = Table.SelectColumns(R0175_base, {"Chave_Pai", "DT_ALT", "NR_CAMPO", "CONT_ANT"}, MissingField.Ignore),
    Base0175 = Table.SelectRows(Base0175_Raw, each [NR_CAMPO] = "05" or [NR_CAMPO] = "06" or [NR_CAMPO] = "5" or [NR_CAMPO] = "6"),
    R0175_Norm = Table.AddColumn(Base0175, "NR_CAMPO_NORM", each if [NR_CAMPO] = null then "" else Text.PadStart(Text.Trim(Text.From([NR_CAMPO])), 2, "0"), type text),

    // BLINDAGEM: Buffer no lado DIREITO do Join
    R0175_Buf = Table.Buffer(R0175_Norm),

    // ========================================================================
    // 2. MESCLAGEM PRINCIPAL (Hash Joins puros em memória)
    // ========================================================================
    Join0000 = Table.NestedJoin(Base0150, {"ArquivoId"}, Base0000_Buf, {"ArquivoId"}, "R0000", JoinKind.Inner),
    Expand0000 = Table.ExpandTableColumn(Join0000, "R0000", {"DT_INI", "DT_FIN"}, {"DT_INI", "DT_FIN"}),
    Validos0150 = Table.SelectRows(Expand0000, each [DT_INI] <> null and [DT_FIN] <> null),

    Join0175 = Table.NestedJoin(Validos0150, {"Chave_Linha"}, R0175_Buf, {"Chave_Pai"}, "Tabela0175", JoinKind.LeftOuter),

    // ========================================================================
    // 3. MOTOR SCD2 (Restante igual...)
    // ========================================================================
    ResolveMes = Table.AddColumn(Join0175, "TimelineMes", each 
        let
            t0175 = [Tabela0175], TemAlteracao = t0175 <> null and not Table.IsEmpty(t0175),
            BaseRec = [COD_PART = [COD_PART], NOME = [NOME], COD_PAIS = [COD_PAIS], COD_MUN = [COD_MUN], IE = [IE]],
            Out = if not TemAlteracao then
                { Record.Combine({BaseRec, [CNPJ = [CNPJ], CPF = [CPF], DataInicial = [DT_INI], DataFinal = [DT_FIN]]}) }
            else
                let
                    LinhaCNPJ = try Table.SelectRows(t0175, (x) => x[NR_CAMPO_NORM] = "05"){0} otherwise null,
                    LinhaCPF  = try Table.SelectRows(t0175, (x) => x[NR_CAMPO_NORM] = "06"){0} otherwise null,
                    DtAltCNPJ = if LinhaCNPJ <> null then LinhaCNPJ[DT_ALT] else null,
                    AntCNPJ   = if LinhaCNPJ <> null then LinhaCNPJ[CONT_ANT] else null,
                    DtAltCPF  = if LinhaCPF <> null then LinhaCPF[DT_ALT] else null,
                    AntCPF    = if LinhaCPF <> null then LinhaCPF[CONT_ANT] else null,
                    Marcos = List.Sort(List.Distinct(List.RemoveNulls({[DT_INI], DtAltCNPJ, DtAltCPF, Date.AddDays([DT_FIN], 1)}))),
                    Intervalos = List.Transform({0..List.Count(Marcos)-2}, (i) => [Start = Marcos{i}, End = Date.AddDays(Marcos{i+1}, -1)]),
                    Fatias = List.Transform(Intervalos, (inv) => Record.Combine({BaseRec, [CNPJ = if DtAltCNPJ <> null and inv[Start] < DtAltCNPJ then AntCNPJ else [CNPJ], CPF = if DtAltCPF <> null and inv[Start] < DtAltCPF then AntCPF else [CPF], DataInicial = inv[Start], DataFinal = inv[End]]}))
                in Fatias
        in Out, type list),

    RemoveSobras = Table.SelectColumns(ResolveMes, {"TimelineMes"}),
    ExpandeLista = Table.ExpandListColumn(RemoveSobras, "TimelineMes"),
    ExpandeRecords = Table.ExpandRecordColumn(ExpandeLista, "TimelineMes", {"COD_PART", "NOME", "COD_PAIS", "COD_MUN", "IE", "CNPJ", "CPF", "DataInicial", "DataFinal"}),
    Ordenado = Table.Sort(ExpandeRecords, {{"COD_PART", Order.Ascending}, {"DataInicial", Order.Ascending}}),
    Consolidado = Table.Group(Ordenado, {"COD_PART", "NOME", "COD_PAIS", "COD_MUN", "IE", "CNPJ", "CPF"}, {{"DataInicial", each List.Min([DataInicial]), type date}, {"DataFinal", each List.Max([DataFinal]), type date}}, GroupKind.Local),

    AddTipoDoc = Table.AddColumn(Consolidado, "TIPO DOC", each if [CNPJ] <> null and Text.Trim([CNPJ]) <> "" then "CNPJ" else if [CPF] <> null and Text.Trim([CPF]) <> "" then "CPF" else "EXTERIOR", type text),
    AddNumDoc = Table.AddColumn(AddTipoDoc, "Numero DOC", each if [#"TIPO DOC"] = "CNPJ" then [CNPJ] else if [#"TIPO DOC"] = "CPF" then [CPF] else "EXTERIOR", type text),

    BufMunicipios = Table.Buffer(Table.SelectColumns(tb_municipios, {"Codigo_Municipio", "Nome_Municipio"}, MissingField.Ignore)),
    BufPais = Table.Buffer(Table.SelectColumns(tb_3_2_1_pais, {"COD_PAIS", "NOME_PAIS"}, MissingField.Ignore)),
    JoinMunicipios = Table.NestedJoin(AddNumDoc, {"COD_MUN"}, BufMunicipios, {"Codigo_Municipio"}, "Mun", JoinKind.LeftOuter),
    ExpandMunicipios = Table.ExpandTableColumn(JoinMunicipios, "Mun", {"Nome_Municipio"}, {"MUNICIPIO"}),
    JoinPais = Table.NestedJoin(ExpandMunicipios, {"COD_PAIS"}, BufPais, {"COD_PAIS"}, "PaisTbl", JoinKind.LeftOuter),
    ExpandPais = Table.ExpandTableColumn(JoinPais, "PaisTbl", {"NOME_PAIS"}, {"PAIS"}), 
    FinalCols = Table.SelectColumns(ExpandPais, {"COD_PART", "NOME", "TIPO DOC", "Numero DOC", "IE", "MUNICIPIO", "PAIS", "DataInicial", "DataFinal"}),
    TipagemFinal = Table.TransformColumnTypes(FinalCols, {{"COD_PART", type text}, {"NOME", type text}, {"TIPO DOC", type text}, {"Numero DOC", type text}, {"IE", type text}, {"MUNICIPIO", type text}, {"PAIS", type text}, {"DataInicial", type date}, {"DataFinal", type date}}, "pt-BR")
in
    TipagemFinal

