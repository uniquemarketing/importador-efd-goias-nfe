let
    Layout = LAYOUT_NFE_BASE,
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
    CamposComPath = List.Transform(
        Layout[Fields],
        each
            [
                Alias = _[Alias],
                Tag = _[Tag],
                FullPath = fnPath(RootPath & _[Path])
            ]
    ),
    AliasesObrigatorios = {"Chave de Acesso"},
    AliasesAtivosDetectados = List.Transform(
        List.Select(CamposComPath, each fnTagExiste([FullPath], [Tag])),
        each [Alias]
    ),
    AliasesAtivos =
        if List.IsEmpty(Tags) then
            List.Transform(Layout[Fields], each _[Alias])
        else
            List.Distinct(List.Combine({AliasesObrigatorios, AliasesAtivosDetectados})),
    FieldsAtivos = List.Select(Layout[Fields], each List.Contains(AliasesAtivos, _[Alias])),
    Resultado = Record.Combine(
        {
            Layout,
            [
                Fields = FieldsAtivos,
                Metricas = [
                    TagsAmostra = List.Count(Tags),
                    CamposOriginais = List.Count(Layout[Fields]),
                    CamposAtivos = List.Count(FieldsAtivos)
                ]
            ]
        }
    )
in
    Resultado
