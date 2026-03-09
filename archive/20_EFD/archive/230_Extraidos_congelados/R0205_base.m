let
    // Materialização via motor genérico utilizando a staging canônica.
    // As chaves de relacionamento hierárquico (Chave_Pai -> aponta para o 0200) 
    // já são injetadas automaticamente pela fnExtraiRegistro.
    R0205_base = fnExtraiRegistro(EFD_Extraida, "0205")
in
    R0205_base

