let
    Fonte = tb_pais,
    Base = Table.SelectColumns(Fonte, {"COD_PAIS", "NOME_PAIS", "SITUACAO", "INICIO", "FIM"}, MissingField.Ignore),
    Final = fxAux_ReordenarColunasSeguras(Base, {"COD_PAIS", "NOME_PAIS", "SITUACAO", "INICIO", "FIM"})
in
    Final