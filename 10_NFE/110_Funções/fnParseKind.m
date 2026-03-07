(v as any, kind as text, optional mode as nullable text) as any =>
    let
        m = Text.Lower(Text.Trim(if mode = null then "parse" else mode)),
        k = Text.Lower(Text.Trim(kind)),
        t0 = if v = null then null else Text.Trim(Text.From(v)),
        t = if t0 = "" then null else t0,
        fnToNumber = (txt as nullable text) as nullable number =>
            if txt = null then
                null
            else
                let
                    n1 = try Number.FromText(txt, "en-US") otherwise null,
                    n2 =
                        if n1 <> null then
                            n1
                        else
                            try Number.FromText(Text.Replace(txt, ",", "."), "en-US") otherwise null
                in
                    n2,
        fnToInt64 = (txt as nullable text) as nullable number =>
            let
                n = fnToNumber(txt)
            in
                if n = null then
                    null
                else
                    try Int64.From(n) otherwise null,
        fnToDateTime = (txt as nullable text) as nullable datetime =>
            if txt = null then
                null
            else
                let
                    z = try DateTimeZone.FromText(txt) otherwise null,
                    dt = if z <> null then DateTimeZone.RemoveZone(z) else try DateTime.FromText(txt) otherwise null
                in
                    dt,
        fnToDate = (txt as nullable text) as nullable date =>
            if txt = null then
                null
            else
                let
                    z = try DateTimeZone.FromText(txt) otherwise null,
                    d =
                        if z <> null then
                            Date.From(DateTimeZone.RemoveZone(z))
                        else
                            try Date.FromText(txt) otherwise try Date.From(DateTime.FromText(txt)) otherwise null
                in
                    d,
        fnToLogical = (txt as nullable text) as nullable logical =>
            if txt = null then
                null
            else
                let
                    u = Text.Upper(Text.Trim(txt))
                in
                    if u = "1" or u = "TRUE" or u = "VERDADEIRO" then
                        true
                    else if u = "0" or u = "FALSE" or u = "FALSO" then
                        false
                    else
                        null,
        fnParseScaledNumber = (txt as nullable text, scale as number) as nullable number =>
            let
                n = fnToNumber(txt)
            in
                if n = null then
                    null
                else
                    Number.Round(n, scale, RoundingMode.AwayFromZero),
        fnToCurrency = (txt as nullable text, scale as number) as nullable number =>
            let
                n = fnParseScaledNumber(txt, scale)
            in
                if n = null then
                    null
                else
                    Currency.From(n),
        fnTryScaleFromKind = (kk as text) as nullable number =>
            let
                hasV = Text.Contains(kk, "v"),
                afterV = if hasV then Text.AfterDelimiter(kk, "v") else null,
                scaleTxt =
                    if afterV = null then
                        null
                    else if Text.Contains(afterV, "-") then
                        Text.AfterDelimiter(afterV, "-")
                    else
                        afterV,
                scaleNum = try Number.FromText(scaleTxt, "en-US") otherwise null
            in
                if scaleNum = null then
                    null
                else
                    Int64.From(scaleNum),
        fnToCode = (txt as nullable text, len as number) as nullable text =>
            if txt = null then
                null
            else
                let
                    onlyDigits = Text.Select(txt, {"0".."9"}), padded = Text.PadStart(onlyDigits, len, "0")
                in
                    padded,
        ContratoFixo = [
            text = [Type = type text, Parse = (txt as nullable text) as any => txt],
            int = [Type = Int64.Type, Parse = (txt as nullable text) as any => fnToInt64(txt)],
            number = [Type = type number, Parse = (txt as nullable text) as any => fnToNumber(txt)],
            datetime = [Type = type datetime, Parse = (txt as nullable text) as any => fnToDateTime(txt)],
            date = [Type = type date, Parse = (txt as nullable text) as any => fnToDate(txt)],
            logical = [Type = type logical, Parse = (txt as nullable text) as any => fnToLogical(txt)],
            #"13v2" = [Type = Currency.Type, Parse = (txt as nullable text) as any => fnToCurrency(txt, 2)],
            #"3v2-4" = [Type = type number, Parse = (txt as nullable text) as any => fnParseScaledNumber(txt, 4)],
            #"11v0-4" = [Type = type number, Parse = (txt as nullable text) as any => fnParseScaledNumber(txt, 4)],
            #"11v0-10" = [Type = type number, Parse = (txt as nullable text) as any => fnParseScaledNumber(txt, 10)],
            #"11v4" = [Type = type number, Parse = (txt as nullable text) as any => fnParseScaledNumber(txt, 4)]
        ],
        fnContratoCode = (kk as text) as nullable record =>
            if Text.StartsWith(kk, "code") then
                let
                    lenTxt = Text.AfterDelimiter(kk, "code"),
                    len = try Number.FromText(lenTxt, "en-US") otherwise null
                in
                    if len = null then
                        null
                    else
                        [Type = type text, Parse = (txt as nullable text) as any => fnToCode(txt, Int64.From(len))]
            else
                null,
        fnContratoDecimal = (kk as text) as nullable record =>
            let
                scale = fnTryScaleFromKind(kk)
            in
                if scale = null then
                    null
                else
                    [
                        Type = type number,
                        Parse = (txt as nullable text) as any => fnParseScaledNumber(txt, Number.From(scale))
                    ],
        fnGetContrato = (kk as text) as nullable record =>
            let
                fixo = try Record.Field(ContratoFixo, kk) otherwise null,
                code = if fixo <> null then null else fnContratoCode(kk),
                decimal = if fixo <> null or code <> null then null else fnContratoDecimal(kk)
            in
                if fixo <> null then
                    fixo
                else if code <> null then
                    code
                else
                    decimal,
        contratoKind = fnGetContrato(k),
        out =
            if m = "type" then
                if contratoKind = null then type any else contratoKind[Type]
            else if t = null then
                null
            else if contratoKind = null then
                t
            else
                try contratoKind[Parse](t) otherwise null
    in
        out
