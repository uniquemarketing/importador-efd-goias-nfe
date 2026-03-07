# NFe - Contrato de Tipos e Contrato Ativo

## Objetivo
Centralizar o parse de tipos em `fnParseKind` e reduzir colunas nulas nas materializacoes com base nas tags reais da amostra.

## Fonte Unica de Tipos
- Funcao: `10_NFE/110_Funções/fnParseKind.m`
- Regra: toda conversao de valor por `Kind` deve passar por `fnParseKind`.
- Kinds explicitos relevantes:
  - `13v2`: parse monetario em `Currency.Type`
  - `3v2-4`: decimal com 4 casas (`type number`)
  - `11v0-4`: decimal com 4 casas (`type number`)
  - `11v0-10`: decimal com 10 casas (`type number`)
  - `11v4`: decimal com 4 casas (`type number`)
- Fallback: formatos decimais `*v*` nao mapeados explicitamente seguem parse generico por escala.

## Contrato Ativo por Tags
- Origem da amostra de tags: `10_NFE/100_Arquivos/104_Tags_NFe_Amostra5.m`
- Contratos intermediarios:
  - `10_NFE/125_Contratos/NFE_Contrato_Ativo_BASE.m`
  - `10_NFE/125_Contratos/NFE_Contrato_Ativo_PROD.m`
- Criterio:
  - Campo do layout e mantido quando houver correspondencia com tag da amostra (por caminho completo ou sufixo terminal).
  - Fallback seguro: se a amostra vier vazia, mantem layout completo.

## Materializacao
- Totais: `10_NFE/130_Extraídos/NFE_Totais.m`
  - Usa `NFE_Contrato_Ativo_BASE`.
  - Sem tipagem paralela fora do `fnParseKind`.
  - Sem `ID_Nota` (chave tecnica e `nfe_id` da origem).
- Produtos: `10_NFE/130_Extraídos/NFE_Produtos.m`
  - Usa `NFE_Contrato_Ativo_PROD`.
  - Expansao dinamica por contrato ativo para reduzir colunas nulas.

## Diagnostico
- Consultas de baseline:
  - `10_NFE/140_Diagnostico/DIAG_NFE_Totais.m`
  - `10_NFE/140_Diagnostico/DIAG_NFE_Produtos.m`
- Cada uma retorna:
  - `Resumo`: linhas, colunas, colunas 100% nulas, percentual.
  - `Colunas`: diagnostico por coluna.
