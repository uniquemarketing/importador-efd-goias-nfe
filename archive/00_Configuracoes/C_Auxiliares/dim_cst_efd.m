let
    Fonte = tb_cst_efd,
    Base = Table.SelectColumns(Fonte, {"CST_ICMS", "DESC_CST", "INICIO", "FIM"}, MissingField.Ignore),
    Final = fxAux_ReordenarColunasSeguras(Base, {"CST_ICMS", "DESC_CST", "INICIO", "FIM"})
in
    Final