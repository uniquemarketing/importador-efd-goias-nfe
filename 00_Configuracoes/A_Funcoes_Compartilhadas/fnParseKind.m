(v as any, kind as text, optional mode as nullable text) as any =>
    let
        m = Text.Lower(Text.Trim(if mode = null then "parse" else mode)),
        k = Text.Lower(Text.Trim(if kind = null then "text" else kind)),
        fnSanitizeText = (txt as any) as nullable text =>
            let
                raw = if txt = null then null else Text.From(txt),
                trim1 = if raw = null then null else Text.Trim(raw),
                trim2 = if trim1 = null then null else Text.Trim(trim1, "|"),
                trim3 = if trim2 = null then null else Text.Replace(trim2, Character.FromNumber(160), " "),
                trim4 = if trim3 = null then null else Text.Trim(trim3)
            in
                if trim4 = null or trim4 = "" then null else trim4,
        t = fnSanitizeText(v),
        fnNormalizeDecimalText = (txt as nullable text) as nullable text =>
            if txt = null then
                null
            else
                let
                    s0 = Text.Replace(txt, " ", ""),
                    pDot = Text.PositionOf(s0, ".", Occurrence.Last),
                    pComma = Text.PositionOf(s0, ",", Occurrence.Last),
                    hasDot = pDot >= 0,
                    hasComma = pComma >= 0,
                    out =
                        if hasDot and hasComma then
                            if pComma > pDot then
                                Text.Replace(Text.Replace(s0, ".", ""), ",", ".")
                            else
                                Text.Replace(s0, ",", "")
                        else if hasComma then
                            Text.Replace(s0, ",", ".")
                        else
                            s0
                in
                    out,
        fnToNumber = (txt as nullable text) as nullable number =>
            if txt = null then
                null
            else
                let
                    n1 = try Number.FromText(txt, "en-US") otherwise null,
                    norm = if n1 <> null then null else fnNormalizeDecimalText(txt),
                    n2 = if n1 <> null then n1 else try Number.FromText(norm, "en-US") otherwise null
                in
                    n2,
        fnToInt64 = (txt as nullable text) as nullable number =>
            let
                n = fnToNumber(txt)
            in
                if n = null then null else try Int64.From(n) otherwise null,
        fnToDate8 = (txt as nullable text) as nullable date =>
            if txt = null then
                null
            else
                let
                    d = Text.Select(txt, {"0".."9"}),
                    out =
                        if Text.Length(d) <> 8 then
                            null
                        else
                            let
                                dd = try Number.FromText(Text.Start(d, 2), "en-US") otherwise null,
                                mm = try Number.FromText(Text.Range(d, 2, 2), "en-US") otherwise null,
                                yy = try Number.FromText(Text.End(d, 4), "en-US") otherwise null
                            in
                                if dd = null or mm = null or yy = null then null else try #date(yy, mm, dd) otherwise null
                in
                    out,
        fnToDateTime = (txt as nullable text) as nullable datetime =>
            if txt = null then
                null
            else
                let
                    z = try DateTimeZone.FromText(txt) otherwise null,
                    d8 = if z <> null then null else fnToDate8(txt),
                    dt =
                        if z <> null then
                            DateTimeZone.RemoveZone(z)
                        else
                            try DateTime.FromText(txt) otherwise
                                if d8 <> null then #datetime(Date.Year(d8), Date.Month(d8), Date.Day(d8), 0, 0, 0) else null
                in
                    dt,
        fnToDate = (txt as nullable text) as nullable date =>
            if txt = null then
                null
            else
                let
                    d8 = fnToDate8(txt),
                    z = if d8 <> null then null else try DateTimeZone.FromText(txt) otherwise null,
                    d =
                        if d8 <> null then
                            d8
                        else if z <> null then
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
                if n = null then null else Number.Round(n, scale, RoundingMode.AwayFromZero),
        fnToCurrency = (txt as nullable text, scale as number) as nullable number =>
            let
                n = fnParseScaledNumber(txt, scale)
            in
                if n = null then null else Currency.From(n),
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
                if scaleNum = null then null else Int64.From(scaleNum),
        fnToCode = (txt as nullable text, len as number) as nullable text =>
            if txt = null then
                null
            else
                let
                    onlyDigits = Text.Select(txt, {"0".."9"}),
                    padded = Text.PadStart(onlyDigits, len, "0")
                in
                    padded,
        ContratoFixo = [
            text = [Type = type text, Parse = (txt as nullable text) as any => txt],
            int = [Type = Int64.Type, Parse = (txt as nullable text) as any => fnToInt64(txt)],
            number = [Type = type number, Parse = (txt as nullable text) as any => fnToNumber(txt)],
            datetime = [Type = type datetime, Parse = (txt as nullable text) as any => fnToDateTime(txt)],
            date = [Type = type date, Parse = (txt as nullable text) as any => fnToDate(txt)],
            date8 = [Type = type date, Parse = (txt as nullable text) as any => fnToDate8(txt)],
            logical = [Type = type logical, Parse = (txt as nullable text) as any => fnToLogical(txt)],
            #"13v2" = [Type = Currency.Type, Parse = (txt as nullable text) as any => fnToCurrency(txt, 2)],
            #"3v2-4" = [Type = type number, Parse = (txt as nullable text) as any => fnParseScaledNumber(txt, 4)],
            #"11v0-4" = [Type = type number, Parse = (txt as nullable text) as any => fnParseScaledNumber(txt, 4)],
            #"11v0-10" = [Type = type number, Parse = (txt as nullable text) as any => fnParseScaledNumber(txt, 10)],
            #"11v4" = [Type = type number, Parse = (txt as nullable text) as any => fnParseScaledNumber(txt, 4)],
            num_pt = [Type = type number, Parse = (txt as nullable text) as any => fnParseScaledNumber(txt, 0)],
            num_pt_2 = [Type = type number, Parse = (txt as nullable text) as any => fnParseScaledNumber(txt, 2)],
            num_pt_3 = [Type = type number, Parse = (txt as nullable text) as any => fnParseScaledNumber(txt, 3)],
            num_pt_4 = [Type = type number, Parse = (txt as nullable text) as any => fnParseScaledNumber(txt, 4)],
            num_pt_5 = [Type = type number, Parse = (txt as nullable text) as any => fnParseScaledNumber(txt, 5)]
        ],
        fnContratoCode = (kk as text) as nullable record =>
            if Text.StartsWith(kk, "code") then
                let
                    lenTxt = Text.AfterDelimiter(kk, "code"),
                    len = try Number.FromText(lenTxt, "en-US") otherwise null
                in
                    if len = null then null else [Type = type text, Parse = (txt as nullable text) as any => fnToCode(txt, Int64.From(len))]
            else
                null,
        fnContratoNumPt = (kk as text) as nullable record =>
            if Text.StartsWith(kk, "num_pt_") then
                let
                    s = try Number.FromText(Text.AfterDelimiter(kk, "num_pt_"), "en-US") otherwise null
                in
                    if s = null then null else [Type = type number, Parse = (txt as nullable text) as any => fnParseScaledNumber(txt, Number.From(Int64.From(s)))]
            else
                null,
        fnContratoDecimal = (kk as text) as nullable record =>
            let
                scale = fnTryScaleFromKind(kk)
            in
                if scale = null then
                    null
                else
                    [Type = type number, Parse = (txt as nullable text) as any => fnParseScaledNumber(txt, Number.From(scale))],
        fnGetContrato = (kk as text) as nullable record =>
            let
                fixo = try Record.Field(ContratoFixo, kk) otherwise null,
                code = if fixo <> null then null else fnContratoCode(kk),
                numpt = if fixo <> null or code <> null then null else fnContratoNumPt(kk),
                decimal = if fixo <> null or code <> null or numpt <> null then null else fnContratoDecimal(kk)
            in
                if fixo <> null then fixo else if code <> null then code else if numpt <> null then numpt else decimal,
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

