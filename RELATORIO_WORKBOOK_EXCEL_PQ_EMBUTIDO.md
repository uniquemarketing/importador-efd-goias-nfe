# Relatorio - Workbook Excel x Power Query Embutido

Arquivo analisado: `EXCEL/Importador_1.3.1.xlsx`
Data da analise: `2026-03-09`

## 1) Confirmacao de acesso ao Power Query embutido

Foi confirmado acesso tecnico ao conteudo do Power Query dentro do `.xlsx` por inspecao interna do pacote OpenXML:

- `xl/connections.xml`: inventario de conexoes/locations de queries
- `customXml/item1.xml`: container `DataMashup` com formulas M
- `DataMashup` contem `Formulas/Section1.m` (codigo M embutido)

Ou seja: e possivel ler o inventario e o codigo M interno do workbook sem abrir a UI do Power Query.

## 2) Inventario consolidado

- Conexoes no workbook: `118`
- Locations unicos em conexoes: `109`
- Queries `shared` no `Formulas/Section1.m`: `106`
- Arquivos `.m` ativos mapeados na base de codigo (escopo ativo): `104`

## 3) Achados principais

### 3.1 Duplicidades no workbook (mesmo `Location`, conexoes duplicadas)

Duplicados detectados:

- `NFE_Processado_Base`
- `R0460_base`
- `RC101_base`
- `RC195_base`
- `RE100_base`
- `RE200_base`
- `RE300_base`
- `RE316_base`
- `fnParseKind`

Observacao: isso explica presenca de nomes como `...1` na UI (ex.: `RC195_base1`, `RE100_base1`), mesmo apontando para o mesmo `Location`.

### 3.2 Conexoes sem arquivo `.m` ativo correspondente

Presentes no workbook, nao presentes na malha ativa de `.m`:

- `AMOSTRA_EXPLODIDA`
- `Config`
- `fxAux_AplicarTiposAuxiliares`
- `fxAux_NormalizarCodigo`
- `fxAux_ReordenarColunasSeguras`

Observacao: isso nao implica erro automaticamente. `Config` e `AMOSTRA_EXPLODIDA` podem ser queries internas legitimas. Ja `fxAux_*` sao indicio de legado residual no workbook.

### 3.3 Divergencia conexoes x `Section1.m`

Locations em conexoes que nao aparecem como `shared` em `Section1.m`:

- `101_xml_Arquivos_All`
- `102_NFE_Arquivos`
- `AMOSTRA_EXPLODIDA`

Observacao: isso indica que parte do estado do workbook pode estar em metadados/conexoes alem do `Section1.m` principal.

## 4) Possibilidade de manipulacao (nomes de queries e M embutido)

## Resultado: **SIM, e tecnicamente possivel**

### 4.1 O que e possivel manipular

- Nome de query exibido na UI:
  - via `xl/connections.xml` (`connection/@name`)
- Target da conexao:
  - via `dbPr connection="...;Location=..."`
- Codigo M embutido:
  - via `customXml/item1.xml` -> `DataMashup` -> `Formulas/Section1.m`

### 4.2 Nivel de risco

Risco **medio/alto** se feito manualmente, porque:

- `DataMashup` usa estrutura binaria compactada
- rename de query exige consistencia entre:
  - nome `shared` em `Section1.m`
  - referencias internas em outras queries M
  - `Location` em `connections.xml`
  - metadados/caches do workbook

Se renomear so um ponto, o workbook pode abrir com erro de referencia.

### 4.3 Condicao para operacao segura

Para operar com baixo risco, a alteracao deve ser atomica e validar os 3 eixos:

1. `Section1.m` (definicao e referencias)
2. `connections.xml` (`name` e `Location`)
3. limpeza de duplicidades residuais (`...1`) quando compartilharem o mesmo `Location`

## 5) Recomendacao objetiva

Antes de manipular nomes/codigo dentro do `.xlsx` em producao:

1. Fazer copia de seguranca do workbook
2. Aplicar alteracao em lote pequeno (1 ou 2 queries)
3. Reabrir workbook e validar:
   - preview
   - refresh
   - carga de conexoes
4. So depois escalar para higienizacao completa

## 6) Referencias tecnicas desta analise

- Workbook: [Importador_1.3.1.xlsx](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/EXCEL/Importador_1.3.1.xlsx)
- Conexoes: [connections.xml](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/.tmp_xlsx/xl/connections.xml)
- DataMashup container (amostra extraida): [item1.xml](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/.tmp_xlsx/customXml/item1.xml)
- DataMashup container (workbook atual apos teste): `customXml/item5.xml` dentro de [Importador_1.3.1.xlsx](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/EXCEL/Importador_1.3.1.xlsx)
- Resumo estruturado da coleta: [.tmp_pq_workbook_report.json](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/.tmp_pq_workbook_report.json)

## 7) Teste operacional executado

Foi executado um teste de escrita controlada para validar manipulacao no workbook + base de codigo.

### 7.1 Consulta criada na base de codigo

- [NFE_Produtos_QtdLinhas.m](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/10_NFE/130_Extraídos/NFE_Produtos_QtdLinhas.m)

Logica da consulta:
- conta linhas de `NFE_Produtos` com `Table.RowCount`
- retorna tabela de 1 linha: `[Consulta, QtdLinhas]`

### 7.2 Consulta injetada no workbook

No arquivo [Importador_1.3.1.xlsx](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/EXCEL/Importador_1.3.1.xlsx):

- adicionado `shared NFE_Produtos_QtdLinhas` em `Formulas/Section1.m` (DataMashup)
- adicionada conexao em `xl/connections.xml` com `Location=NFE_Produtos_QtdLinhas`

### 7.3 Segurança e reversibilidade

- backup adicional criado antes da escrita:
  - [Importador_1.3.1.pre_NFE_Produtos_QtdLinhas_20260309_180149.xlsx](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/EXCEL/Importador_1.3.1.pre_NFE_Produtos_QtdLinhas_20260309_180149.xlsx)
- validacao tecnica pos-escrita:
  - query presente no `Section1.m`
  - conexao presente em `connections.xml`
