let
    Fonte = tb_cest,
    Base = Table.SelectColumns(Fonte, {"CEST", "Descricao", "Inicio", "Fim"}, MissingField.Ignore),
    Final = fxAux_ReordenarColunasSeguras(Base, {"CEST", "Descricao", "Inicio", "Fim"})
in
    Final