let
    Fonte = tb_cst_nfe,
    Base = Table.SelectColumns(Fonte, {"CST", "descCST"}, MissingField.Ignore),
    Final = fxAux_ReordenarColunasSeguras(Base, {"CST", "descCST"})
in
    Final