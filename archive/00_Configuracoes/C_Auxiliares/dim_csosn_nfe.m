let
    Fonte = tb_csosn_nfe,
    Base = Table.SelectColumns(Fonte, {"CSOSN", "descCSOSN"}, MissingField.Ignore),
    Final = fxAux_ReordenarColunasSeguras(Base, {"CSOSN", "descCSOSN"})
in
    Final