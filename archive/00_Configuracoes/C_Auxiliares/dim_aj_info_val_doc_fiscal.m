let
    Fonte = tb_aj_info_val_doc_fiscal,
    Base = Table.SelectColumns(Fonte, {"COD_INF_ADIC", "DESCRICAO", "INICIO", "FIM", "UF"}, MissingField.Ignore),
    Final = fxAux_ReordenarColunasSeguras(Base, {"COD_INF_ADIC", "DESCRICAO", "INICIO", "FIM", "UF"})
in
    Final