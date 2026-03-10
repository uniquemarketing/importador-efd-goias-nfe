let
    Fonte = tb_cfop,
    Base = Table.SelectColumns(Fonte, {"CFOP", "Descrição", "Início", "Fim"}, MissingField.Ignore),
    Final = fxAux_ReordenarColunasSeguras(Base, {"CFOP", "Descrição", "Início", "Fim"})
in
    Final