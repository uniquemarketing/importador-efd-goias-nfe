// fnValidarMetaRegistros
// Validação estrutural completa (0→9) para a tabela Meta_Registros
// Espera colunas: Registro, Nivel, Bloco, PaiEsperado, Descricao, Ocorrencia, ativo
// Retorna um RECORD com: [Resumo, Problemas, Estatisticas]

(tbl as table) as record =>
let
    // -------------------------
    // 0) Normalização defensiva
    // -------------------------
    RequiredCols = {"Registro","Nivel","Bloco","PaiEsperado","Descricao","Ocorrencia","ativo"},
    MissingCols = List.Difference(RequiredCols, Table.ColumnNames(tbl)),

    _Guard = if List.Count(MissingCols) > 0 then error "Meta_Registros: colunas faltando: " & Text.Combine(MissingCols, ", ") else null,

    // Tipagem (se já estiver tipado, não atrapalha)
    T = Table.TransformColumnTypes(
        tbl,
        {
            {"Registro", type text},
            {"Nivel", Int64.Type},
            {"Bloco", type text},
            {"PaiEsperado", type nullable text},
            {"Descricao", type text},
            {"Ocorrencia", type text},
            {"ativo", type logical}
        },
        "pt-BR"
    ),

    // Auxiliares
    TrimText = (x as any) as nullable text => if x = null then null else Text.Trim(Text.From(x)),

    T1 = Table.TransformColumns(
        T,
        {
            {"Registro", each TrimText(_), type text},
            {"Bloco", each TrimText(_), type text},
            {"PaiEsperado", each TrimText(_), type nullable text},
            {"Descricao", each if _ = null then "" else Text.Trim(Text.From(_)), type text},
            {"Ocorrencia", each if _ = null then "" else Text.Trim(Text.From(_)), type text}
        }
    ),

    // -------------------------
    // 1) Regras de integridade
    // -------------------------

    // 1.1 Registro vazio / Bloco vazio
    R_RegistroVazio = Table.SelectRows(T1, each [Registro] = null or [Registro] = ""),
    R_BlocoVazio    = Table.SelectRows(T1, each [Bloco] = null or [Bloco] = ""),

    // 1.2 Registro duplicado
    Dup = Table.Group(T1, {"Registro"}, {{"Qtd", each Table.RowCount(_), Int64.Type}}),
    R_Duplicados = Table.SelectRows(Dup, each [Qtd] > 1),

    // 1.3 Nivel inválido
    R_NivelInvalido = Table.SelectRows(T1, each [Nivel] = null or [Nivel] < 0),

    // 1.4 PaiEsperado inválido vs Nivel
    R_PaiVsNivel = Table.SelectRows(
        T1,
        each ([PaiEsperado] = null and [Nivel] <> 0) or ([PaiEsperado] <> null and [Nivel] = 0)
    ),

    // 1.5 Pai inexistente
    RegistroSet = List.Buffer(Table.Column(T1, "Registro")),
    R_PaiInexistente = Table.SelectRows(
        T1,
        each [PaiEsperado] <> null and not List.Contains(RegistroSet, [PaiEsperado])
    ),

    // 1.6 Relação de nível: NivelFilho = NivelPai + 1 (quando PaiEsperado não é null)
    Pais = Table.RenameColumns(Table.SelectColumns(T1, {"Registro","Nivel","Bloco"}), {{"Registro","Pai"},{"Nivel","NivelPai"},{"Bloco","BlocoPai"}}),
    ComPai = Table.NestedJoin(T1, {"PaiEsperado"}, Pais, {"Pai"}, "P", JoinKind.LeftOuter),
    ExpPai = Table.ExpandTableColumn(ComPai, "P", {"NivelPai","BlocoPai"}, {"NivelPai","BlocoPai"}),
    R_NivelPai = Table.SelectRows(
        ExpPai,
        each [PaiEsperado] <> null and [NivelPai] <> null and [Nivel] <> [NivelPai] + 1
    ),

    // 1.7 Consistência de Bloco: filho deve estar no mesmo bloco do pai, exceto quando o pai é 0000
    R_BlocoPai = Table.SelectRows(
        ExpPai,
        each [PaiEsperado] <> null
            and [BlocoPai] <> null
            and [PaiEsperado] <> "0000"
            and [Bloco] <> [BlocoPai]
    ),

    // 1.8 Presenças obrigatórias por bloco
    // - Bloco 0: 0000,0001,0990
    // - Bloco 9: 9001,9900,9990,9999
    // - Demais blocos (B,C,D,E,G,H,K,L): X001 e X990
    
    DistinctReg = List.Buffer(List.Distinct(RegistroSet)),
    MustHave0 = {"0000","0001","0990"},
    MustHave9 = {"9001","9900","9990","9999"},

    Missing0 = List.Difference(MustHave0, DistinctReg),
    Missing9 = List.Difference(MustHave9, DistinctReg),

    Blocos = List.Sort(List.Distinct(Table.Column(T1, "Bloco"))),
    BlocosIntermediarios = List.Select(Blocos, each _ <> "0" and _ <> "9"),

    // para cada bloco intermediário, exige abertura X001 e fechamento X990
    MissingOpenClose =
        List.Combine(
            List.Transform(
                BlocosIntermediarios,
                (b as text) =>
                    let
                        Open = b & "001",
                        Close = b & "990",
                        Miss = List.Difference({Open, Close}, DistinctReg)
                    in
                        List.Transform(Miss, each [Tipo="FaltaRegistroObrigatorio", Registro=_, Bloco=b])
            )
        ),

    R_FaltasObrigatorias =
        let
            L0 = List.Transform(Missing0, each [Tipo="FaltaRegistroObrigatorio", Registro=_, Bloco="0"]),
            L9 = List.Transform(Missing9, each [Tipo="FaltaRegistroObrigatorio", Registro=_, Bloco="9"])
        in
            Table.FromRecords(List.Combine({L0, L9, MissingOpenClose})),

    // 1.9 Regras do bloco 9: 9900 deve ter PaiEsperado = 9001; 9990 PaiEsperado = 0000; 9999 nivel 0 / pai null
    R_Bloco9 =
        let
            T9 = Table.SelectRows(T1, each [Bloco] = "9"),
            R1 = Table.SelectRows(T9, each [Registro] = "9900" and [PaiEsperado] <> "9001"),
            R2 = Table.SelectRows(T9, each [Registro] = "9990" and [PaiEsperado] <> "0000"),
            R3 = Table.SelectRows(T9, each [Registro] = "9999" and ( [PaiEsperado] <> null or [Nivel] <> 0 ))
        in
            Table.Combine(
                {
                    Table.AddColumn(R1, "_Tipo", each "Bloco9_Pai_9900", type text),
                    Table.AddColumn(R2, "_Tipo", each "Bloco9_Pai_9990", type text),
                    Table.AddColumn(R3, "_Tipo", each "Bloco9_Regra_9999", type text)
                }
            ),

    // -------------------------
    // 2) Padroniza saída de problemas
    // -------------------------
    MkIssues = (tIssue as table, issueType as text) as table =>
        let
            HasRegistro = List.Contains(Table.ColumnNames(tIssue), "Registro"),
            HasBloco = List.Contains(Table.ColumnNames(tIssue), "Bloco"),
            Base = if HasRegistro and HasBloco then Table.SelectColumns(tIssue, {"Registro","Bloco"})
                   else if HasRegistro then Table.AddColumn(Table.SelectColumns(tIssue, {"Registro"}), "Bloco", each null, type nullable text)
                   else if HasBloco then Table.AddColumn(Table.SelectColumns(tIssue, {"Bloco"}), "Registro", each null, type nullable text)
                   else #table(type table [Registro=nullable text, Bloco=nullable text], {}),
            Out = Table.AddColumn(Base, "Tipo", each issueType, type text)
        in
            Out,

    P1 = MkIssues(R_RegistroVazio, "RegistroVazio"),
    P2 = MkIssues(R_BlocoVazio, "BlocoVazio"),
    P3 = Table.AddColumn(Table.RenameColumns(R_Duplicados, {{"Registro","Registro"}}), "Tipo", each "RegistroDuplicado", type text),
    P3s = Table.SelectColumns(Table.AddColumn(P3, "Bloco", each null, type nullable text), {"Registro","Bloco","Tipo"}),
    P4 = MkIssues(R_NivelInvalido, "NivelInvalido"),
    P5 = MkIssues(R_PaiVsNivel, "PaiVsNivel"),
    P6 = MkIssues(R_PaiInexistente, "PaiInexistente"),
    P7 = MkIssues(R_NivelPai, "NivelNaoEhPaiMaisUm"),
    P8 = MkIssues(R_BlocoPai, "BlocoDiferenteDoPai"),
    P9 = if Table.IsEmpty(R_FaltasObrigatorias) then #table(type table [Registro=nullable text, Bloco=nullable text, Tipo=text], {})
         else Table.SelectColumns(Table.AddColumn(R_FaltasObrigatorias, "Tipo", each [Tipo], type text), {"Registro","Bloco","Tipo"}),
    P10 = if Table.IsEmpty(R_Bloco9) then #table(type table [Registro=nullable text, Bloco=nullable text, Tipo=text], {})
          else Table.SelectColumns(Table.RenameColumns(Table.SelectColumns(R_Bloco9, {"Registro","Bloco","_Tipo"}), {{"_Tipo","Tipo"}}), {"Registro","Bloco","Tipo"}),

    Problemas = Table.Distinct(Table.Combine({P1,P2,P3s,P4,P5,P6,P7,P8,P9,P10})),

    // -------------------------
    // 3) Estatísticas e resumo
    // -------------------------
    Estatisticas =
        let
            ByBloco = Table.Group(T1, {"Bloco"}, {{"QtdRegistros", each Table.RowCount(_), Int64.Type}, {"Niveis", each List.Sort(List.Distinct([Nivel])), type list}}),
            ByTipo  = Table.Group(Problemas, {"Tipo"}, {{"Qtd", each Table.RowCount(_), Int64.Type}})
        in
            [PorBloco = ByBloco, PorTipo = ByTipo],

    Resumo =
        let
            Total = Table.RowCount(T1),
            TotalProblemas = Table.RowCount(Problemas),
            Ok = TotalProblemas = 0,
            Msg0 = if List.Count(Missing0) > 0 then "Faltam registros obrigatórios no Bloco 0: " & Text.Combine(Missing0, ", ") else null,
            Msg9 = if List.Count(Missing9) > 0 then "Faltam registros obrigatórios no Bloco 9: " & Text.Combine(Missing9, ", ") else null,
            Msg = Text.Combine(List.RemoveNulls({Msg0, Msg9}), " | ")
        in
            [TotalRegistros = Total, TotalProblemas = TotalProblemas, HierarquiaOK = Ok, Observacao = Msg]

in
    [Resumo = Resumo, Problemas = Problemas, Estatisticas = Estatisticas]

