**Bloco 1 — Repriorização Fiscal**

- `Prioridade máxima`: `C100`, `C170`, `C176`, `C179`, `C180`, `C181`, `C185`, `C186`, `C190`, `C197`, `E110`, `E111`, `E112`, `E113`, `E115`, `E116`, `E210`, `E220`, `E230`, `E240`, `E250`, `E310`, `E311`, `E312`, `E313`.
- `Prioridade de tributos`: `1)` ICMS, ICMS-ST, DIFAL, FCP, IPI. `2)` identificação documental, item, processo, ajuste, recolhimento. `3)` PIS/COFINS. `4)` demais complementos.
- `Reposicionamento`: `E310`–`E313` sobem para o núcleo e deixam de ser “naturalmente posteriores”, porque o Guia Prático trata esses registros como apuração/ajuste/documento de DIFAL/FCP, e esse universo é recorrente no seu uso real. IPI também sobe para cedo em documento, item, analítico e NF-e, porque aparece estruturalmente nas normas EFD/NF-e e ajuda a explicar composição e diferença de base. citeturn4search0turn4search3turn7search0turn7search5turn5search0
- `Regra operacional`: um grupo só entra no lote inicial se passar em dois filtros ao mesmo tempo: necessidade fiscal e custo aceitável no Power Query/Excel. Em EFD isso tende a ser viável em layouts flat, porque [fnExtraiRegistro.m](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/20_EFD/210_Funções/fnExtraiRegistro.m) já materializa a partir de `EFD_Extraida`; então o custo principal é largura/preview, não nova leitura da origem. O veto passa a ser: não tocar [Layouts_Index.m](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/20_EFD/225_Meta/Layouts_Index.m), não criar `RXXXX_base`, não mexer em função central no começo.

**Bloco 2 — Matriz Fiscal x Custo**

- `C100`: barato = identificação, chave, datas, `VL_DOC`, `VL_MERC`, `VL_BC_ICMS`, `VL_ICMS`, `VL_BC_ICMS_ST`, `VL_ICMS_ST`, `VL_IPI`; moderado = `VL_DESC`, `VL_ABAT_NT`, `IND_PGTO`, `IND_FRT`, `VL_FRT`, `VL_SEG`, `VL_OUT_DA`, `VL_FCP`, `VL_FCP_ST`, `VL_FCP_ST_RET`; útil mas caro = PIS/COFINS; adiar = complementos fora do próprio `C100`.
- `C170`: barato = `NUM_ITEM`, `COD_ITEM`, `QTD`, `UNID`, `VL_ITEM`, `CST_ICMS`, `CFOP`, `VL_BC_ICMS`, `ALIQ_ICMS`, `VL_ICMS`, `VL_BC_ICMS_ST`, `ALIQ_ST`, `VL_ICMS_ST`, `VL_IPI`; moderado = `DESCR_COMPL`, `VL_DESC`, redução de base e derivados simples; útil mas caro = PIS/COFINS item; adiar = dependência de catálogo/lookups.
- `C176`: barato = documento da última entrada, chave, item, quantidade; moderado = valores unitários de BC/ICMS/ST e alíquotas da última entrada; útil mas caro = limites e complementos raros; adiar = qualquer excesso além do vínculo probatório.
- `C179`: barato = `BC_ST_ORIG_DEST`, `ICMS_ST_REP`, `ICMS_ST_COMPL`, `ICMS_RET`; moderado = campos auxiliares de retenção complementar; útil mas caro = nada relevante no primeiro desenho; adiar = variações não centrais.
- `C180`: barato = motivo/responsável, unidade, quantidade; moderado = valores unitários de operação, BC-ST, ICMS-ST e FCP-ST; útil mas caro = identificação extensa de arrecadação se não usada; adiar = acessórios.
- `C181`: barato = motivo, unidade, quantidade, documento/chave/item da saída devolvida; moderado = valores unitários de ICMS/ST/FCP ligados à devolução; útil mas caro = campos auxiliares de estoque/complemento; adiar = acessórios raros.
- `C185`: barato = item, CST, CFOP, motivo, unidade, quantidade; moderado = valores unitários de operação própria, ST estoque, restituição/complemento; útil mas caro = FCP/ST expandido se pouco recorrente; adiar = acessórios.
- `C186`: barato = item, CST, CFOP, motivo, documento/chave/item da entrada; moderado = BC, alíquota, ICMS UF, BC-ST, alíquota ST e resultado unitário; útil mas caro = complementos pouco usados; adiar = acessórios.
- `C190`: barato = `CST_ICMS`, `CFOP`, `ALIQ_ICMS`, `VL_OPR`, `VL_BC_ICMS`, `VL_ICMS`, `VL_BC_ICMS_ST`, `VL_ICMS_ST`, `VL_IPI`; moderado = `VL_RED_BC`, `COD_OBS`; útil mas caro = qualquer ampliação analítica sem uso direto; adiar = extras.
- `C197`: barato = `COD_AJ`, `DESCR_COMPL`, `COD_ITEM`, `VL_BC_ICMS`, `ALIQ_ICMS`, `VL_ICMS`, `VL_OUTROS`; moderado = só o texto complementar, pelo preview; útil mas caro = nada relevante; adiar = nada além do registro mínimo.
- `E110`: barato = praticamente o registro inteiro, com todos os monetários de apuração própria; moderado = nenhum grupo relevante; útil mas caro = nada; adiar = nada do próprio registro.
- `E111`: barato = `COD_AJ_APUR` e `VL_AJ_APUR`; moderado = `DESCR_COMPL_AJ`; útil mas caro = nada; adiar = nada.
- `E112`: barato = `NUM_DA`, `NUM_PROC`, `IND_PROC`; moderado = derivado `IND_PROC_DESC`; útil mas caro = nada; adiar = nada.
- `E113`: barato = `COD_MOD`, `SER`, `NUM_DOC`, `DT_DOC`, `CHV_DOCE`, `VL_AJ_ITEM`; moderado = `COD_PART`, `SUB`, `COD_ITEM`; útil mas caro = nada; adiar = nada.
- `E115`: barato = `COD_INF_ADIC`, `VL_INF_ADIC`; moderado = `DESCR_COMPL_AJ`; útil mas caro = nada; adiar = nada.
- `E116`: barato = `COD_OR`, `VL_OR`, `DT_VCTO`, `COD_REC`; moderado = `NUM_PROC`, `IND_PROC`, `PROC`, `MES_REF`, `TXT_COMPL`; útil mas caro = só texto longo; adiar = nada.
- `E210`: barato = quase o registro inteiro, porque o ganho fiscal é alto e o custo é só largura flat; moderado = derivado de indicador; útil mas caro = nada; adiar = nada.
- `E220`: barato = `COD_AJ_APUR` e `VL_AJ_APUR`; moderado = `DESCR_COMPL_AJ`; útil mas caro = nada; adiar = nada.
- `E230`: barato = `NUM_DA`, `NUM_PROC`, `IND_PROC`; moderado = `PROC`, `TXT_COMPL`; útil mas caro = nada; adiar = nada.
- `E240`: barato = `COD_MOD`, `SER`, `NUM_DOC`, `DT_DOC`, `CHV_DOCE`, `VL_AJ_ITEM`; moderado = `COD_PART`, `SUB`, `COD_ITEM`; útil mas caro = nada; adiar = nada.
- `E250`: barato = `COD_OR`, `VL_OR`, `DT_VCTO`, `COD_REC`; moderado = `NUM_PROC`, `IND_PROC`, `PROC`, `MES_REF`, `TXT_COMPL`; útil mas caro = só texto longo; adiar = nada.
- `E310`: barato = quase o registro inteiro de DIFAL/FCP, porque é flat e de altíssimo valor fiscal; moderado = derivados de indicador; útil mas caro = nada; adiar = nada do próprio registro salvo prova concreta de não incidência.
- `E311`: barato = `COD_AJ_APUR` e `VL_AJ_APUR`; moderado = `DESCR_COMPL_AJ`; útil mas caro = nada; adiar = nada.
- `E312`: barato = `NUM_DA`, `NUM_PROC`, `IND_PROC`; moderado = `PROC`, `TXT_COMPL`; útil mas caro = nada; adiar = nada.
- `E313`: barato = `COD_MOD`, `SER`, `NUM_DOC`, `DT_DOC`, `CHV_DOCE`, `VL_AJ_ITEM`; moderado = `COD_PART`, `SUB`, `COD_ITEM`; útil mas caro = nada; adiar = nada.
- `Leitura de custo`: em EFD, “caro” aqui quase nunca é leitura da origem; é tabela mais larga, preview mais pesado e mais memória em `RXXXX_base`. O que continua proibitivamente caro cedo é tocar [fnExtraiRegistro.m](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/20_EFD/210_Funções/fnExtraiRegistro.m), [Layouts_Index.m](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/20_EFD/225_Meta/Layouts_Index.m) ou abrir novos `RXXXX_base`.

**Bloco 3 — Versão Mínima x Expandida**

- `C100`: mínima = identificação, chave, datas, ICMS/ST/IPI do documento; expandida = FCP, frete/seguro/outros, indicadores auxiliares; fora = PIS/COFINS.
- `C170`: mínima = item, quantidade/unidade, valor, ICMS, ICMS-ST, IPI, derivados simples; expandida = descrição complementar, descontos/reduções e FCP; fora = PIS/COFINS.
- `C176`: mínima = vínculo documental da última entrada + item + quantidade + BC/ICMS/ST unitários essenciais; expandida = demais monetários unitários e limites.
- `C181`: mínima = motivo + documento/chave/item da saída + quantidade/unidade + ST restituição/complemento; expandida = FCP e auxiliares.
- `C185`: mínima = item + motivo + quantidade/unidade + valores unitários de operação/ST restituição-complemento; expandida = FCP/ST mais largo.
- `C186`: mínima = item + motivo + documento/chave/item da entrada + BC/alíquota/resultado; expandida = complementos acessórios.
- `C190`: mínima = analítico ICMS/ST + IPI; expandida = redução de base, observação e relação mais ampla com `C191`.
- `E210`: mínima = registro quase completo; expandida = só derivados/descrições adicionais.
- `E240`: mínima = documento referenciado praticamente completo, já com `CHV_DOCE`; expandida = só chave auxiliar textual.
- `E250`: mínima = obrigação praticamente completa, já com processo, complemento e mês de referência; expandida = só derivados simples.
- `E310`: mínima = registro quase completo de DIFAL/FCP; expandida = só derivados/descrições adicionais.
- `E313`: mínima = documento referenciado praticamente completo, já com `CHV_DOCE`; expandida = só chave auxiliar textual.
- `LAYOUT_NFE_BASE`: mínima = identificação, emitente, destinatário, chaves, totais ICMS/ST/IPI e totais FCP/DIFAL se aparecerem com recorrência real; expandida = frete, seguro, outras despesas, referências documentais adicionais; fora = retirada, entrega, cobrança, pagamento, transporte. Os grupos oficiais centrais vêm do leiaute/MOC; os acessórios podem esperar. citeturn7search0turn7search5turn5search0
- `LAYOUT_NFE_PROD`: mínima = `nItem`, produto, ICMS, ICMS-ST, IPI e identificador técnico do item; expandida = `ICMSUFDest/FCPUFDest` no nível do item, GTIN e monetários acessórios; fora = PIS, COFINS e grupos acessórios. Em custo, esse é o ponto mais sensível porque [LAYOUT_NFE_PROD.m](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/10_NFE/120_Layouts/LAYOUT_NFE_PROD.m) já carrega um `ICMS_Layout` dinâmico.
- `NFE_Totais`: mínima = `NFe_Chave` + totais de produto, BC/ICMS, BCST/ST, IPI, NF e, se recorrentes, FCP/DIFAL; expandida = frete, seguro, desconto, outras despesas e total tributos.
- `NFE_Produtos`: mínima = `NFe_Chave`, `nItem`, produto, ICMS, ICMS-ST, IPI, `ID_Produto`; expandida = `ICMSUFDest/FCP`, GTIN e monetários acessórios. Em custo, cada coluna nova pesa mais aqui porque [NFE_Produtos.m](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/10_NFE/130_Extraídos/NFE_Produtos.m) expande `ConteudoProcessado` para todos os itens.
- `NF-e fora do lote mínimo por custo/performance`: PIS, COFINS, retirada, entrega, cobrança, pagamento, transporte, blocos acessórios e referências múltiplas. Parte disso é só largura; parte pode empurrar para função estrutural, especialmente onde houver multiplicidade/listas e a limitação atual de [fnGetNestedValue.m](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/10_NFE/110_Funções/fnGetNestedValue.m).

**Bloco 4 — Lotes Revisados**

- `Lote 1`: núcleo EFD documento/item/ST + IPI mínimo. Arquivos-alvo futuros = `C100`, `C170`, `C176`, `C179`, `C180`, `C181`, `C185`, `C186`, `C190`, `C197`. Regra = só versão mínima.
- `Lote 2`: núcleo EFD apuração própria/ST + DIFAL/FCP prioritário. Arquivos-alvo futuros = `E110`, `E111`, `E112`, `E113`, `E115`, `E116`, `E210`, `E220`, `E230`, `E240`, `E250`, `E310`, `E311`, `E312`, `E313`. Regra = registros pequenos e flat entram quase completos.
- `Lote 3`: validação fiscal + validação de performance EFD. Só avança se o núcleo responder demonstrativos e não degradar preview/refresh de forma sensível.
- `Lote 4`: NF-e mínima de reconciliação com ICMS/ICMS-ST/IPI e chaves; sem PIS/COFINS, sem blocos acessórios, sem tocar função estrutural. Arquivos-alvo futuros = [LAYOUT_NFE_BASE.m](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/10_NFE/120_Layouts/LAYOUT_NFE_BASE.m), [LAYOUT_NFE_PROD.m](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/10_NFE/120_Layouts/LAYOUT_NFE_PROD.m), [NFE_Totais.m](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/10_NFE/130_Extraídos/NFE_Totais.m), [NFE_Produtos.m](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/10_NFE/130_Extraídos/NFE_Produtos.m).
- `Lote 5`: validação NF-e e decisão sobre expansão. Só decide item-level `ICMSUFDest/FCP`, FCP totais adicionais e referências extras depois de medir custo real.
- `Lote 6`: opcionais úteis apenas se houver folga de ambiente. Aqui entram PIS/COFINS, catálogos auxiliares, blocos acessórios NF-e e complementos de menor retorno.
- `Lote 7`: mudanças estruturais de alto risco apenas se inevitáveis. Aqui ficam [fnExtraiRegistro.m](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/20_EFD/210_Funções/fnExtraiRegistro.m), [Layouts_Index.m](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/20_EFD/225_Meta/Layouts_Index.m), [fnGetNestedValue.m](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/10_NFE/110_Funções/fnGetNestedValue.m) e qualquer reativação em massa.

**Bloco 5 — Critério de Aprovação Fiscal + Performance**

- `Regra veto`: se um lote passar no fiscal e falhar em performance, ele não executa.
- `Fiscal`: responde demonstrativos centrais de ST/DIFAL/FCP? preserva rastreabilidade documento-item-ajuste-recolhimento? entrega prova documental mínima para processo administrativo? cobre IPI cedo onde ele explica base/operação? citeturn4search0turn4search3turn8search1turn8search2turn8search4turn8search5
- `Performance`: não aumentou leitura da origem? não criou `RXXXX_base` novos? não abriu catálogo em excesso? não exigiu tocar função estrutural? não piorou preview de forma sensível? não ampliou dependências além do lote?
- `Checklist do Lote 1`: contagem de linhas idêntica em `RC100/RC170/...`; ganho só de colunas; versão mínima com ICMS/ST/IPI; zero mudança estrutural.
- `Checklist do Lote 2`: contagem de linhas idêntica em `RE110/RE210/RE310/...`; `E310-E313` cobrem DIFAL/FCP se aplicável; zero mudança estrutural; sem regressão sensível de preview.
- `Checklist do Lote 4`: reconciliação por chave e item fecha com EFD; `NFE_Produtos` não infla de forma sensível; nenhuma necessidade de tocar [fnGetNestedValue.m](D:/SEFAZ/01_IMPORTA_EFD_GOIAS/VERSOES_IMPORTADOR/v.1.3.1/Code/10_NFE/110_Funções/fnGetNestedValue.m) ou pipeline estrutural.
- `Critério de avanço`: só seguir para o próximo lote com sua autorização expressa, relatório curto do lote anterior e dupla aprovação: fiscal `ok` + performance `ok`.
