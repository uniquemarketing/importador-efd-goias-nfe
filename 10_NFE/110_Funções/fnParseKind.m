(v as any, kind as text) as any =>
    let
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
        out =
            if t = null then
                null
            else if k = "text" then
                t
            else if k = "int" then
                fnToInt64(t)
            else if k = "number" then
                fnToNumber(t)
            else if k = "datetime" then
                fnToDateTime(t)
            else if k = "date" then
                fnToDate(t)
            else if k = "logical" then
                fnToLogical(t)
            else if Text.StartsWith(k, "code") then
                let
                    lenTxt = Text.AfterDelimiter(k, "code"),
                    len = try Number.FromText(lenTxt, "en-US") otherwise null
                in
                    if len = null then
                        t
                    else
                        fnToCode(t, Int64.From(len))
            else
                let
                    sc = fnTryScaleFromKind(k)
                in
                    if sc <> null then
                        fnParseScaledNumber(t, sc)
                    else
                        t
    in
        out
