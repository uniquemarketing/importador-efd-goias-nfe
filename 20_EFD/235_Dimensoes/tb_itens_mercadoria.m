let
    // ========================================================================
    // A) PREPARAR BASES LEVES (Early Column Pruning)
    // ========================================================================
    Base0200_Raw = Table.SelectColumns(R0200_base, {"ArquivoId", "Chave_Linha", "COD_ITEM", "DESCR_ITEM", "COD_BARRA", "COD_ANT_ITEM", "UNID_INV", "TIPO_ITEM", "TIPO_ITEM_DESC", "COD_NCM", "EX_IPI", "COD_GEN", "COD_LST", "ALIQ_ICMS", "CEST"}, MissingField.Ignore),
    Base0200 = if Table.HasColumns(Base0200_Raw, "TIPO_ITEM_DESC") then Base0200_Raw else Table.AddColumn(Base0200_Raw, "TIPO_ITEM_DESC", each null, type text),

    // BLINDAGEM: Buffer no lado DIREITO do Join
    Base0205_Buf = Table.Buffer(Table.SelectColumns(R0205_base, {"Chave_Pai", "DESCR_ANT_ITEM", "DT_INI", "DT_FIM", "COD_ANT_ITEM"}, MissingField.Ignore)),

    // ========================================================================
    // B) MOTOR SCD2 SET-BASED (Hash Join Imediato)
    // ========================================================================
    TabAtual = Table.AddColumn(Base0200, "Estado_Rec", each [ItemVersaoId = Text.From([ArquivoId]) & "-" & Text.From([COD_ITEM]) & "-C", DESCR_VIGENTE = [DESCR_ITEM], COD_ANT_ITEM_VIGENTE = [COD_ANT_ITEM], DtIni_Vigencia = null, DtFim_Vigencia = null, IsAtual = true], type record),
    TabAtual_Exp = Table.ExpandRecordColumn(TabAtual, "Estado_Rec", {"ItemVersaoId", "DESCR_VIGENTE", "COD_ANT_ITEM_VIGENTE", "DtIni_Vigencia", "DtFim_Vigencia", "IsAtual"}),

    JoinHist = Table.NestedJoin(Base0200, {"Chave_Linha"}, Base0205_Buf, {"Chave_Pai"}, "Tb0205", JoinKind.Inner),
    ExpandeHist = Table.ExpandTableColumn(JoinHist, "Tb0205", {"DESCR_ANT_ITEM", "DT_INI", "DT_FIM", "COD_ANT_ITEM"}, {"H_DESCR", "H_DT_INI", "H_DT_FIM", "H_COD_ANT"}),
    
    TabHist = Table.AddColumn(ExpandeHist, "Estado_Rec", each [ItemVersaoId = Text.From([ArquivoId]) & "-" & Text.From([COD_ITEM]) & "-H-" & (if [H_DT_INI] <> null then Date.ToText([H_DT_INI], "yyyyMMdd") else "NA"), DESCR_VIGENTE = [H_DESCR], COD_ANT_ITEM_VIGENTE = [H_COD_ANT], DtIni_Vigencia = [H_DT_INI], DtFim_Vigencia = [H_DT_FIM], IsAtual = if [H_DT_FIM] = null then true else false], type record),
    TabHist_Exp = Table.ExpandRecordColumn(TabHist, "Estado_Rec", {"ItemVersaoId", "DESCR_VIGENTE", "COD_ANT_ITEM_VIGENTE", "DtIni_Vigencia", "DtFim_Vigencia", "IsAtual"}),

    UniaoSCD2 = Table.Combine({Table.RemoveColumns(TabAtual_Exp, {"DESCR_ITEM", "COD_ANT_ITEM"}), Table.RemoveColumns(TabHist_Exp, {"DESCR_ITEM", "COD_ANT_ITEM", "H_DESCR", "H_DT_INI", "H_DT_FIM", "H_COD_ANT"})}),

    // ========================================================================
    // C) ENRIQUECIMENTOS DIMENSIONAIS 
    // ========================================================================
    AddChaves = Table.TransformColumns(UniaoSCD2, {{"COD_GEN", each if _ = null then null else Text.PadStart(Text.Trim(Text.From(_)), 2, "0"), type text}, {"UNID_INV", each if _ = null then null else Text.Trim(Text.From(_)), type text}}),

    DimUnid = Table.Buffer(Table.SelectColumns(R0190_base, {"ArquivoId", "UNID", "DESCR"}, MissingField.Ignore)),
    MergeUnid = Table.NestedJoin(AddChaves, {"ArquivoId", "UNID_INV"}, DimUnid, {"ArquivoId", "UNID"}, "TbUnid", JoinKind.LeftOuter),
    ExpandUnid = Table.ExpandTableColumn(MergeUnid, "TbUnid", {"DESCR"}, {"UNID_INV_DESC"}),

    DimGen = Table.Buffer(Table.SelectColumns(tb_4_2_1_gen_mercadoria, {"Código", "Descrição"}, MissingField.Ignore)),
    MergeGen = Table.NestedJoin(ExpandUnid, {"COD_GEN"}, DimGen, {"Código"}, "TbGen", JoinKind.LeftOuter),
    ExpandGen = Table.ExpandTableColumn(MergeGen, "TbGen", {"Descrição"}, {"COD_GEN_DESC"}),

    ColunasFinais = {"ItemVersaoId", "ArquivoId", "Chave_Linha", "COD_ITEM", "DESCR_VIGENTE", "COD_BARRA", "COD_ANT_ITEM_VIGENTE", "UNID_INV", "UNID_INV_DESC", "TIPO_ITEM", "TIPO_ITEM_DESC", "COD_NCM", "EX_IPI", "COD_GEN", "COD_GEN_DESC", "COD_LST", "ALIQ_ICMS", "CEST", "DtIni_Vigencia", "DtFim_Vigencia", "IsAtual"},
    SelecionaFinais = Table.SelectColumns(ExpandGen, ColunasFinais, MissingField.Ignore),
    TipagemFinal = Table.TransformColumnTypes(SelecionaFinais, {{"DtIni_Vigencia", type date}, {"DtFim_Vigencia", type date}, {"IsAtual", type logical}, {"ItemVersaoId", type text}, {"ArquivoId", Int64.Type}, {"COD_ITEM", type text}, {"DESCR_VIGENTE", type text}, {"UNID_INV_DESC", type text}, {"COD_GEN_DESC", type text}}, "pt-BR")
in
    TipagemFinal

