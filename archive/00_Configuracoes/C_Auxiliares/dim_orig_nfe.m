let
    Fonte = tb_orig_nfe,
    Base = Table.SelectColumns(Fonte, {"orig", "descOrig"}, MissingField.Ignore),
    Final = fxAux_ReordenarColunasSeguras(Base, {"orig", "descOrig"})
in
    Final