let
    Layout = LAYOUT_NFE_PROD,
    TagsFonte = try Table.Buffer(#"104_Tags_NFe_Amostra5") otherwise #table({"Tag"}, {}),
    TagsBrutas = List.Buffer(List.Transform(Table.Column(TagsFonte, "Tag"), each Text.Lower(Text.Trim(Text.From(_))))),
    Tags = List.Select(TagsBrutas, each _ <> null and _ <> ""),
    RootPath = Record.FieldOrDefault(Layout, "RootPath", {}),
    fnPath = (partes as list) as text => Text.Combine(List.Transform(partes, each Text.From(_)), "."),
    fnTerminaCom = (valor as text, sufixo as text) as logical => valor = sufixo or Text.EndsWith(valor, "." & sufixo),
    fnTagExiste = (fullPath as text, tagTerminal as text) as logical =>
        let
            p = Text.Lower(Text.Trim(fullPath)),
            t = Text.Lower(Text.Trim(tagTerminal)),
            existePorPath = if p = "" then false else List.AnyTrue(List.Transform(Tags, each fnTerminaCom(_, p))),
            existePorTerminal = if t = "" then false else List.AnyTrue(List.Transform(Tags, each fnTerminaCom(_, t)))
        in
            existePorPath or existePorTerminal,
    CamposProdComPath = List.Transform(
        Layout[Fields],
        each
            [
                Alias = _[Alias],
                Tag = _[Tag],
                FullPath = fnPath(RootPath & _[Path])
            ]
    ),
    AliasesProdObrigatorios = {"Item"},
    AliasesProdAtivosDetectados = List.Transform(
        List.Select(CamposProdComPath, each fnTagExiste([FullPath], [Tag])),
        each [Alias]
    ),
    AliasesProdAtivos =
        if List.IsEmpty(Tags) then
            List.Transform(Layout[Fields], each _[Alias])
        else
            List.Distinct(List.Combine({AliasesProdObrigatorios, AliasesProdAtivosDetectados})),
    FieldsProdAtivos = List.Select(Layout[Fields], each List.Contains(AliasesProdAtivos, _[Alias])),
    CamposICMSAtivos =
        if List.IsEmpty(Tags) then
            Layout[ICMS_Layout]
        else
            List.Select(Layout[ICMS_Layout], each fnTagExiste(_[Tag], _[Tag])),
    Resultado = Record.Combine(
        {
            Layout,
            [
                Fields = FieldsProdAtivos,
                ICMS_Layout = CamposICMSAtivos,
                Metricas = [
                    TagsAmostra = List.Count(Tags),
                    CamposProdOriginais = List.Count(Layout[Fields]),
                    CamposProdAtivos = List.Count(FieldsProdAtivos),
                    CamposICMSOriginais = List.Count(Layout[ICMS_Layout]),
                    CamposICMSAtivos = List.Count(CamposICMSAtivos)
                ]
            ]
        }
    )
in
    Resultado
