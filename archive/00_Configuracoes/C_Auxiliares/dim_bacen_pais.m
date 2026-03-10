let
    Fonte = tb_bacen_pais,
    Base = Table.SelectColumns(Fonte, {"cPais", "PaisNome"}, MissingField.Ignore),
    Final = fxAux_ReordenarColunasSeguras(Base, {"cPais", "PaisNome"})
in
    Final