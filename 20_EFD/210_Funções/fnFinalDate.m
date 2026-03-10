let
    Fonte = (txt as nullable any) as nullable date =>
    let
        t = if txt = null then null else Text.Select(Text.From(txt), {"0".."9"}),
        d = if t = null or Text.Length(t) <> 8 then null else
            try #date(
                Number.FromText(Text.End(t, 4)),
                Number.FromText(Text.Middle(t, 2, 2)),
                Number.FromText(Text.Start(t, 2))
            ) otherwise null
    in
        d
in
    Fonte

