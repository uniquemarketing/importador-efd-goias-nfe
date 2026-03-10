let
    Fonte = tb_cod_aj_apur_icms,
    Base = Table.SelectColumns(Fonte, {"COD_AJ_APUR", "DESCRICAO", "INICIO", "FIM"}, MissingField.Ignore),
    Final = fxAux_ReordenarColunasSeguras(Base, {"COD_AJ_APUR", "DESCRICAO", "INICIO", "FIM"})
in
    Final