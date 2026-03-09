# Arquitetura Final - Migracao EFD (SPED)

## Objetivo
Isolar o legado de auditoria EFD em consultas modulares, mantendo a logica funcional e evoluindo o motor de tipagem (`fnParseKind`) para cenarios NFe + SPED.

## Visao Geral
A arquitetura foi reorganizada para um nucleo operacional leve no Excel, separando o que fica ativo do que fica congelado para retomada futura.

## Estrutura de Pastas
- `20_EFD/200_Arquivos`
  - Pipeline operacional ativo:
    - `EFD_Extraida`
- `20_EFD/210_Funções`
  - Funcoes reutilizaveis ativas:
    - `fnSPEDTabela`
    - `fnExtraiRegistro`
    - `fnFinalDate`
    - `fnPeriodo`
- `00_Configuracoes/A_Funcoes_Compartilhadas`
  - Funcoes compartilhadas entre modulos:
    - `fnParseKind` (motor unico de tipagem)
    - `fxAux_*`
- `20_EFD/220_Layouts`
  - Somente layouts ativos do nucleo minimo
- `20_EFD/225_Meta`
  - Catalogos de metadados ativos:
    - `Meta_Registros`
    - `Layouts_Index`
- `00_Configuracoes/C_Auxiliares`
  - Tabelas auxiliares hardcoded e dominios canonicos:
    - `tb_*`
    - `dim_*`
- `20_EFD/230_Extraídos`
  - Somente bases ativas do nucleo minimo
- `20_EFD/archive`
  - Layouts, bases, diagnosticos e apoios congelados
- `00_Configuracoes/archive`
  - Schemas de governanca e compatibilidade congelados
- `30_MODELAGEM/archive_faseC`
  - Modelagem preservada para retomada segura

## Fluxo de Dados
1. `EFD_Extraida` usa `fnSPEDTabela` para leitura e normalizacao dos arquivos TXT SPED.
2. `fnExtraiRegistro` aplica `Layouts_Index` + `Layout_*` sobre `EFD_Extraida`.
3. Consultas `R*_base` ativas materializam somente os registros do nucleo operacional.
4. Consultas auxiliares `tb_*` e `dim_*` em `00_Configuracoes/C_Auxiliares` materializam dominios compartilhados sem dependencias externas em tempo de atualizacao.
5. Conteudos em `archive` ficam fora do workbook principal e so retornam quando houver necessidade real.

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
