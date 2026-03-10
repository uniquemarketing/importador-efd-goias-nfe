# README - Modulo EFD (SPED)

## Resumo
Este modulo contem a migracao do projeto legado de auditoria EFD para estrutura modular no repositorio atual.

Fonte utilizada:
- `Legado/Importador_EFD_1.23.xlsx_PowerQuery.m`

Total de consultas extraidas:
- 56 blocos `shared` convertidos para arquivos `.m` independentes.

## Estrutura
- `200_Arquivos`: staging operacional ativo
- `210_Funções`: funcoes auxiliares operacionais
- `220_Layouts`: somente layouts ativos do nucleo minimo
- `225_Meta`: catalogos de metadados especificos da EFD
- `230_Extraídos`: somente bases ativas do nucleo minimo
- `archive`: layouts, bases, diagnosticos e apoios congelados
- `../00_Configuracoes/A_Funcoes_Compartilhadas`: funcoes compartilhadas entre modulos
- `../00_Configuracoes/C_Auxiliares`: tabelas auxiliares hardcoded e dominios canonicos
- `../00_Configuracoes/archive`: governanca e compatibilidade congeladas
- `../30_MODELAGEM/archive_faseC`: modelagem preservada para retomada futura

## Ordem Recomendada de Importacao no Power Query
1. `00_Configuracoes/A_Funcoes_Compartilhadas`
2. `00_Configuracoes/C_Auxiliares`
3. `225_Meta`
4. `210_Funções`
5. `220_Layouts`
6. `200_Arquivos`
7. `230_Extraídos`

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
- O workbook principal deve importar apenas o nucleo ativo.
- Conteudos em pastas `archive` devem permanecer fora do workbook principal, salvo necessidade pontual de desenvolvimento.
- Para alto volume, prefira carregar tabelas grandes no Modelo de Dados (Power Pivot), evitando limites de planilha.
