let
    Fonte = tb_modelo_doc,
    Base = Table.SelectColumns(Fonte, {"COD_MOD", "DESC_MOD", "INICIO", "FIM"}, MissingField.Ignore),
    Final = fxAux_ReordenarColunasSeguras(Base, {"COD_MOD", "DESC_MOD", "INICIO", "FIM"})
in
    Final