let
    // ======================================================
    // Layout_0150 — Tabela de Cadastro do Participante
    // Regra do projeto:
    //   Pos = número do campo conforme documentação oficial SPED
    //   Pos mapeia diretamente para C{Pos} na staging (EFD_Extraida)
    // ======================================================

    // Helpers
    Field = (name as text, pos as number, kind as text) as record =>
        [Name = name, Pos = pos, Kind = kind],

    Deriv = (name as text, kind as text, fn as function) as record =>
        [Name = name, Kind = kind, Fn = fn],

    // ======================================================
    // Registro 0150
    //
    // Campo 01 = REG  "0150"
    // Campo 02 = COD_PART
    // Campo 03 = NOME
    // Campo 04 = COD_PAIS
    // Campo 05 = CNPJ
    // Campo 06 = CPF
    // Campo 07 = IE
    // Campo 08 = COD_MUN
    // Campo 09 = SUFRAMA
    // Campo 10 = END
    // Campo 11 = NUM
    // Campo 12 = COMPL
    // Campo 13 = BAIRRO
    //
    // Observação técnica:
    // COD_MUN como "text" facilita enriquecimento posterior com tb_municipios (chave textual),
    // e preserva zeros à esquerda (se houver).
    // ======================================================
    L0150 =
        [
            Registro = "0150",
            Fields = {
                Field("COD_PART", 2, "text"),
                Field("NOME", 3, "text"),
                Field("COD_PAIS", 4, "text"),
                Field("CNPJ", 5, "text"),
                Field("CPF", 6, "text"),
                Field("IE", 7, "text"),
                Field("COD_MUN", 8, "text")
                
            },
            Derivados = {}
        ]
in
    L0150

