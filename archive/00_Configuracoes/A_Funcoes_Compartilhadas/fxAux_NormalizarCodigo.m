(Valor as any, optional Tamanho as nullable number, optional PadChar as nullable text) as nullable text =>
let
    TextoBruto = try Text.Trim(Text.From(Valor)) otherwise null,
    Texto = if TextoBruto = "" then null else TextoBruto,
    Preenchimento =
        if PadChar = null or PadChar = "" then
            "0"
        else
            Text.Start(PadChar, 1),
    Final =
        if Texto = null then
            null
        else if Tamanho = null or Tamanho <= 0 then
            Texto
        else if Text.Length(Texto) >= Tamanho then
            Texto
        else
            Text.PadStart(Texto, Tamanho, Preenchimento)
in
    Final
