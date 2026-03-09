let
    // Materialização via motor genérico utilizando a staging canônica.
    // As chaves de relacionamento hierárquico (Chave_Pai -> aponta para o 0200) 
    // já são injetadas automaticamente pela fnExtraiRegistro.
    R0220_Base = fnExtraiRegistro(EFD_Extraida, "0220")
in
    R0220_Base

