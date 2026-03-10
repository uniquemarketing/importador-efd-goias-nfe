# Relatorio - Correcao de Rumo (Fases A, B e C)

## 1. O que foi mantido

### Nucleo minimo EFD mantido
- `20_EFD/225_Meta/Layouts_Index.m`
- `20_EFD/220_Layouts/Layout_0000.m`
- `20_EFD/220_Layouts/Layout_0150.m`
- `20_EFD/220_Layouts/Layout_0175.m`
- `20_EFD/220_Layouts/Layout_C100.m`
- `20_EFD/220_Layouts/Layout_C105.m`
- `20_EFD/220_Layouts/Layout_C170.m`
- `20_EFD/220_Layouts/Layout_C176.m`
- `20_EFD/220_Layouts/Layout_C179.m`
- `20_EFD/220_Layouts/Layout_C180.m`
- `20_EFD/220_Layouts/Layout_C181.m`
- `20_EFD/220_Layouts/Layout_C185.m`
- `20_EFD/220_Layouts/Layout_C186.m`
- `20_EFD/220_Layouts/Layout_C190.m`
- `20_EFD/220_Layouts/Layout_C197.m`
- `20_EFD/220_Layouts/Layout_E110.m`
- `20_EFD/220_Layouts/Layout_E111.m`
- `20_EFD/220_Layouts/Layout_E112.m`
- `20_EFD/220_Layouts/Layout_E113.m`
- `20_EFD/220_Layouts/Layout_E115.m`
- `20_EFD/220_Layouts/Layout_E116.m`
- `20_EFD/220_Layouts/Layout_E210.m`
- `20_EFD/220_Layouts/Layout_E220.m`
- `20_EFD/220_Layouts/Layout_E230.m`
- `20_EFD/220_Layouts/Layout_E240.m`
- `20_EFD/220_Layouts/Layout_E250.m`
- `20_EFD/220_Layouts/Layout_E310.m`
- `20_EFD/220_Layouts/Layout_E311.m`
- `20_EFD/220_Layouts/Layout_E312.m`
- `20_EFD/220_Layouts/Layout_E313.m`
- `20_EFD/230_Extraídos/R0000_base.m`
- `20_EFD/230_Extraídos/R0150_base.m`
- `20_EFD/230_Extraídos/R0175_base.m`
- `20_EFD/230_Extraídos/RC100_base.m`
- `20_EFD/230_Extraídos/RC105_base.m`
- `20_EFD/230_Extraídos/RC170_base.m`
- `20_EFD/230_Extraídos/RC176_base.m`
- `20_EFD/230_Extraídos/RC179_base.m`
- `20_EFD/230_Extraídos/RC180_base.m`
- `20_EFD/230_Extraídos/RC181_base.m`
- `20_EFD/230_Extraídos/RC185_base.m`
- `20_EFD/230_Extraídos/RC186_base.m`
- `20_EFD/230_Extraídos/RC190_base.m`
- `20_EFD/230_Extraídos/RC197_base.m`
- `20_EFD/230_Extraídos/RE110_base.m`
- `20_EFD/230_Extraídos/RE111_base.m`
- `20_EFD/230_Extraídos/RE112_base.m`
- `20_EFD/230_Extraídos/RE113_base.m`
- `20_EFD/230_Extraídos/RE115_base.m`
- `20_EFD/230_Extraídos/RE116_base.m`
- `20_EFD/230_Extraídos/RE210_base.m`
- `20_EFD/230_Extraídos/RE220_base.m`
- `20_EFD/230_Extraídos/RE230_base.m`
- `20_EFD/230_Extraídos/RE240_base.m`
- `20_EFD/230_Extraídos/RE250_base.m`
- `20_EFD/230_Extraídos/RE310_base.m`
- `20_EFD/230_Extraídos/RE311_base.m`
- `20_EFD/230_Extraídos/RE312_base.m`
- `20_EFD/230_Extraídos/RE313_base.m`

### Funcoes e auxiliares mantidos
- `00_Configuracoes/Config.m`
- `00_Configuracoes/A_Funcoes_Compartilhadas/fnParseKind.m`
- `00_Configuracoes/A_Funcoes_Compartilhadas/fxAux_AplicarTiposAuxiliares.m`
- `00_Configuracoes/A_Funcoes_Compartilhadas/fxAux_NormalizarCodigo.m`
- `00_Configuracoes/A_Funcoes_Compartilhadas/fxAux_ReordenarColunasSeguras.m`
- `20_EFD/210_Funções/fnExtraiRegistro.m`
- `20_EFD/210_Funções/fnFinalDate.m`
- `20_EFD/210_Funções/fnPeriodo.m`
- `20_EFD/210_Funções/fnSPEDTabela.m`
- `20_EFD/225_Meta/Meta_Registros.m`
- todos os auxiliares de `00_Configuracoes/C_Auxiliares/*.m`

## 2. O que foi consolidado

- `20_EFD/225_Meta/Layouts_Index.m`
  - consolidado para conter apenas o nucleo minimo obrigatorio
- `20_EFD/200_Arquivos/EFD_Extraida.m`
  - removido `Table.Buffer(fnSPEDTabela([Paths]))`
  - mantido apenas o buffering fisico interno de `fnSPEDTabela`
- `30_MODELAGEM`
  - consolidada fora do fluxo principal, mantendo o codigo para retomada futura

## 3. O que deve ser removido do workbook principal

- `00_Configuracoes/archive/C_Auxiliares_390_Compatibilidade_congelada`
- `00_Configuracoes/archive/B_Schemas_congelado`
- `20_EFD/archive/200_Arquivos_apoio_congelado`
- `20_EFD/archive/210_Funcoes_validacao_congeladas`
- `20_EFD/archive/220_Layouts_congelados`
- `20_EFD/archive/230_Extraidos_congelados`
- `20_EFD/archive/240_Diagnostico_congelado`
- `30_MODELAGEM/archive_faseC`
- `10_NFE/archive_operacional_congelado`
- `Legado/10_NFE_archive_rollback_congelado`

## 4. O que pode ser apagado do codigo-fonte

### Pode ser apagado depois de confirmar ausencia de consumo externo
- `00_Configuracoes/archive/C_Auxiliares_390_Compatibilidade_congelada/*.m`
- `20_EFD/archive/200_Arquivos_apoio_congelado/*.m`
- `20_EFD/archive/210_Funcoes_validacao_congeladas/*.m`
- `20_EFD/archive/240_Diagnostico_congelado/*.m`
- `10_NFE/archive_operacional_congelado/130_Extraidos/NFE_QtdLinhas.m`
- `30_MODELAGEM/archive_faseC/390_Compatibilidade/*.m`

### Nao apagar agora
- `20_EFD/archive/220_Layouts_congelados/*.m`
- `20_EFD/archive/230_Extraidos_congelados/*.m`
- `00_Configuracoes/archive/B_Schemas_congelado/*.m`
- `30_MODELAGEM/archive_faseC/310_Dimensoes/*.m`
- `30_MODELAGEM/archive_faseC/320_Fatos/*.m`

## 5. O que deve apenas ser arquivado/congelado

- `20_EFD/archive/220_Layouts_congelados`
- `20_EFD/archive/230_Extraidos_congelados`
- `20_EFD/archive/240_Diagnostico_congelado`
- `30_MODELAGEM/archive_faseC`
- `00_Configuracoes/archive/B_Schemas_congelado`
- `00_Configuracoes/archive/C_Auxiliares_390_Compatibilidade_congelada`
- `10_NFE/archive_operacional_congelado`
- `Legado/10_NFE_archive_rollback_congelado`

## 6. Localizacao exata de cada item citado

### Ativos apos a simplificacao
- `D:\SEFAZ\01_IMPORTA_EFD_GOIAS\VERSOES_IMPORTADOR\v.1.3.1\Code\20_EFD\220_Layouts`
- `D:\SEFAZ\01_IMPORTA_EFD_GOIAS\VERSOES_IMPORTADOR\v.1.3.1\Code\20_EFD\230_Extraídos`
- `D:\SEFAZ\01_IMPORTA_EFD_GOIAS\VERSOES_IMPORTADOR\v.1.3.1\Code\20_EFD\225_Meta\Layouts_Index.m`
- `D:\SEFAZ\01_IMPORTA_EFD_GOIAS\VERSOES_IMPORTADOR\v.1.3.1\Code\20_EFD\200_Arquivos\EFD_Extraida.m`
- `D:\SEFAZ\01_IMPORTA_EFD_GOIAS\VERSOES_IMPORTADOR\v.1.3.1\Code\00_Configuracoes\C_Auxiliares`

### Congelados
- `D:\SEFAZ\01_IMPORTA_EFD_GOIAS\VERSOES_IMPORTADOR\v.1.3.1\Code\20_EFD\archive\200_Arquivos_apoio_congelado`
- `D:\SEFAZ\01_IMPORTA_EFD_GOIAS\VERSOES_IMPORTADOR\v.1.3.1\Code\20_EFD\archive\210_Funcoes_validacao_congeladas`
- `D:\SEFAZ\01_IMPORTA_EFD_GOIAS\VERSOES_IMPORTADOR\v.1.3.1\Code\20_EFD\archive\220_Layouts_congelados`
- `D:\SEFAZ\01_IMPORTA_EFD_GOIAS\VERSOES_IMPORTADOR\v.1.3.1\Code\20_EFD\archive\230_Extraidos_congelados`
- `D:\SEFAZ\01_IMPORTA_EFD_GOIAS\VERSOES_IMPORTADOR\v.1.3.1\Code\20_EFD\archive\240_Diagnostico_congelado`
- `D:\SEFAZ\01_IMPORTA_EFD_GOIAS\VERSOES_IMPORTADOR\v.1.3.1\Code\00_Configuracoes\archive\B_Schemas_congelado`
- `D:\SEFAZ\01_IMPORTA_EFD_GOIAS\VERSOES_IMPORTADOR\v.1.3.1\Code\00_Configuracoes\archive\C_Auxiliares_390_Compatibilidade_congelada`
- `D:\SEFAZ\01_IMPORTA_EFD_GOIAS\VERSOES_IMPORTADOR\v.1.3.1\Code\30_MODELAGEM\archive_faseC`
- `D:\SEFAZ\01_IMPORTA_EFD_GOIAS\VERSOES_IMPORTADOR\v.1.3.1\Code\10_NFE\archive_operacional_congelado`
- `D:\SEFAZ\01_IMPORTA_EFD_GOIAS\VERSOES_IMPORTADOR\v.1.3.1\Code\Legado\10_NFE_archive_rollback_congelado`

## 7. Sequencia recomendada para workbook principal

1. Atualizar `20_EFD/200_Arquivos/EFD_Extraida.m`.
2. Substituir `20_EFD/225_Meta/Layouts_Index.m` pela versao minima.
3. Garantir que apenas os `Layout_*` obrigatorios permaneçam no workbook principal.
4. Garantir que apenas os `R*_base` obrigatorios permaneçam no workbook principal.
5. Remover do workbook principal os conteudos de `20_EFD/archive/200_Arquivos_apoio_congelado`.
6. Remover do workbook principal os conteudos de `20_EFD/archive/210_Funcoes_validacao_congeladas`.
7. Remover do workbook principal os conteudos de `20_EFD/archive/240_Diagnostico_congelado`.
8. Remover do workbook principal os conteudos de `00_Configuracoes/archive/B_Schemas_congelado`.
9. Remover do workbook principal os conteudos de `00_Configuracoes/archive/C_Auxiliares_390_Compatibilidade_congelada`.
10. Remover do workbook principal os conteudos de `30_MODELAGEM/archive_faseC`.
11. Remover do workbook principal `10_NFE/archive_operacional_congelado`.
12. Manter fora do workbook principal `Legado/10_NFE_archive_rollback_congelado`.

## 8. Confirmacao das restricoes obrigatorias

- `Layouts_Index` manteve todos os registros obrigatorios informados.
- Os `Layout_*` correspondentes foram mantidos em `20_EFD/220_Layouts`.
- Os `R*_base` correspondentes foram mantidos em `20_EFD/230_Extraídos`.
- Todos os auxiliares criados em `00_Configuracoes/C_Auxiliares` foram preservados.
- `fnParseKind` foi mantida sem remocao.
- Nada do nucleo minimo obrigatorio foi removido.
