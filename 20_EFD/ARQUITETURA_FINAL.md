# Arquitetura Final - Migracao EFD (SPED)

## Objetivo
Isolar o legado de auditoria EFD em consultas modulares, mantendo a logica funcional e evoluindo o motor de tipagem (`fnParseKind`) para cenarios NFe + SPED.

## Visao Geral
A arquitetura foi organizada por camadas, separando ingestao, funcoes, metadados, layouts, extracao, dimensoes e diagnostico.

## Estrutura de Pastas
- `20_EFD/200_Arquivos`
  - Pipeline de ingestao e staging:
    - `EFD_Extraida`
    - `EFD_TotalLinha`
    - `Linhas_por_Arquivo`
    - `SomenteProblemas`
- `20_EFD/210_Funções`
  - Funcoes reutilizaveis:
    - `fnSPEDTabela`
    - `fnExtraiRegistro`
    - `fnFinalDate`
    - `fnPeriodo`
    - validadores auxiliares
- `00_Configuracoes/A_Funcoes_Compartilhadas`
  - Funcoes compartilhadas entre modulos:
    - `fnParseKind` (motor unico de tipagem)
- `20_EFD/220_Layouts`
  - Contratos de layout por registro (`Layout_*`)
- `20_EFD/225_Meta`
  - Catalogos de metadados e schema:
    - `Meta_Registros`
    - `Layouts_Index`
    - `schemaAuxiliares`
  - Manifesto da migracao:
    - `MIGRACAO_MANIFEST.csv`
- `20_EFD/230_Extraídos`
  - Tabelas base por registro (`R*_base`, `RC100_base`)
- `20_EFD/235_Dimensoes`
  - Dimensoes derivadas (`tb_*`)
- `20_EFD/240_Diagnostico`
  - Controles de qualidade e diagnostico (`Diag_*`, `QA_*`)

## Fluxo de Dados
1. `EFD_Extraida` usa `fnSPEDTabela` para leitura e normalizacao dos arquivos TXT SPED.
2. `fnExtraiRegistro` aplica `Layouts_Index` + `Layout_*` sobre `EFD_Extraida`.
3. Consultas `R*_base` materializam registros por tipo.
4. Consultas `tb_*` consolidam dimensoes para analise.
5. Consultas de `Diag_*` e `QA_*` validam qualidade e consistencia.

## Motor de Tipagem (fnParseKind)
`fnParseKind` foi consolidada em `00_Configuracoes/A_Funcoes_Compartilhadas/fnParseKind.m` e usada por NFe + EFD:
- manter robustez de parse atual (text, int, number, date, datetime, logical, codeN, decimais dinamicos `*v*`);
- suportar especificidades EFD:
  - `date8` (`ddmmaaaa`);
  - `num_pt`, `num_pt_2`, `num_pt_3`, `num_pt_4`, `num_pt_5`;
  - limpeza defensiva de campos com pipes nas extremidades;
  - normalizacao de decimal para formatos pt-BR/en-US.

Tambem foi mantido o modo de inferencia de tipo (`mode = "type"`), usado nas tipagens finais de tabela.

## Decisoes de Migracao
- Cada bloco `shared` do Section Document legado foi extraido para arquivo `.m` individual.
- O cabecalho `section Section1;` foi removido.
- O prefixo `shared <nome> =` foi removido de cada bloco.
- O `;` final de cada bloco foi removido.
- `NOVO_META` foi consolidada em `Meta_Registros`, mantendo fonte unica de verdade para metadados de registros.
