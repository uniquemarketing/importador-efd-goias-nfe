let
    Fonte = tb_situacao_doc,
    Base = Table.SelectColumns(Fonte, {"COD_SIT", "DESC_SIT", "INICIO", "FIM"}, MissingField.Ignore),
    Final = fxAux_ReordenarColunasSeguras(Base, {"COD_SIT", "DESC_SIT", "INICIO", "FIM"})
in
    Final