CREATE OR REPLACE PACKAGE pkg_usuario AS
    
    PROCEDURE prc_inserir_usuario (
        p_nome            IN usuario.nome%TYPE,
        p_email           IN usuario.email%TYPE,
        p_cpf             IN usuario.cpf%TYPE,
        p_senioridade     IN usuario.senioridade%TYPE,
        p_area_interesse  IN usuario.area_interesse%TYPE,
        p_risco_automacao IN usuario.risco_automacao%TYPE
    );

END pkg_usuario;
/
