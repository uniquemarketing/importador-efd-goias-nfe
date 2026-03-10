let
    Fonte = tb_municipios,
    Base = Table.SelectColumns(Fonte, {"UF", "Nome_UF", "Codigo_Municipio", "Nome_Municipio"}, MissingField.Ignore),
    Final = fxAux_ReordenarColunasSeguras(Base, {"UF", "Nome_UF", "Codigo_Municipio", "Nome_Municipio"})
in
    Final