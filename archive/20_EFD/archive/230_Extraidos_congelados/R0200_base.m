let
    // Materialização via motor genérico utilizando a staging EFD_Extraida
    // O grão desta tabela é [ArquivoId, LinhaId] (Chave_Linha)
    R0200_Base = fnExtraiRegistro(EFD_Extraida, "0200")
in
    R0200_Base

