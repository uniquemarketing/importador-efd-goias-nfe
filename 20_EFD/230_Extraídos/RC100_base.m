let
    // Materialização Dinâmica do Registro C100 a partir da Staging Canônica
    // As chaves de relacionamento hierárquico (Chave_Linha e Chave_Pai) 
    // já são injetadas automaticamente pela fnExtraiRegistro.
    RC100_Base = fnExtraiRegistro(EFD_Extraida, "C100")
in
    RC100_Base

