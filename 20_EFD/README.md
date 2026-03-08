# README - Modulo EFD (SPED)

## Resumo
Este modulo contem a migracao do projeto legado de auditoria EFD para estrutura modular no repositorio atual.

Fonte utilizada:
- `Legado/Importador_EFD_1.23.xlsx_PowerQuery.m`

Total de consultas extraidas:
- 56 blocos `shared` convertidos para arquivos `.m` independentes.

## Estrutura
- `200_Arquivos`: ingestao e staging
- `210_Funções`: funcoes auxiliares e parser de tipos
- `220_Layouts`: definicoes de layout por registro
- `225_Meta`: catalogos de metadados e manifesto de migracao
- `230_Extraídos`: tabelas base por registro
- `235_Dimensoes`: tabelas dimensionais
- `240_Diagnostico`: validacoes e diagnosticos
- `../00_Configuracoes/A_Funcoes_Compartilhadas`: funcoes compartilhadas entre modulos

## Arquivos de Controle
- `225_Meta/MIGRACAO_MANIFEST.csv`
  - Mapeia nome original do legado para categoria e arquivo de destino.

## Ordem Recomendada de Importacao no Power Query
1. `00_Configuracoes/A_Funcoes_Compartilhadas`
2. `225_Meta`
3. `210_Funções`
4. `220_Layouts`
5. `200_Arquivos`
6. `230_Extraídos`
7. `235_Dimensoes`
8. `240_Diagnostico`

Essa ordem evita referencias quebradas durante a carga inicial.

## fnParseKind (Compartilhada)
Arquivo:
- `00_Configuracoes/A_Funcoes_Compartilhadas/fnParseKind.m`

Caracteristicas principais:
- parse robusto de `number`, `int`, `date`, `datetime`, `logical`;
- suporte a `codeN` (preenchimento de codigo com zeros a esquerda);
- suporte a `date8` (`ddmmaaaa`);
- suporte a `num_pt*` (`num_pt`, `num_pt_2` ... `num_pt_5`);
- limpeza de texto para dados SPED (trim defensivo e pipes nas extremidades);
- `mode = "type"` para inferencia de tipos em `Table.TransformColumnTypes`.

## Meta Registros (Fonte Unica)
- `225_Meta/Meta_Registros.m` e a fonte unica de verdade.
- `NOVO_META` foi consolidada e nao deve ser usada como consulta separada.

## Observacoes
- A pasta `20_EFD` foi preparada para evolucao incremental.
- Diagnosticos podem ser habilitados/desabilitados sem impactar ingestao.
- Para alto volume, prefira carregar tabelas grandes no Modelo de Dados (Power Pivot), evitando limites de planilha.
