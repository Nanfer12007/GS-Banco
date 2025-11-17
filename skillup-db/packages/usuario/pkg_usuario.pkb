CREATE OR REPLACE PACKAGE BODY pkg_usuario AS

    PROCEDURE prc_inserir_usuario (
        p_nome            IN usuario.nome%TYPE,
        p_email           IN usuario.email%TYPE,
        p_cpf             IN usuario.cpf%TYPE,
        p_senioridade     IN usuario.senioridade%TYPE,
        p_area_interesse  IN usuario.area_interesse%TYPE,
        p_risco_automacao IN usuario.risco_automacao%TYPE
    )
    IS
    BEGIN
        IF p_nome IS NULL THEN
            RAISE_APPLICATION_ERROR(-20001, 'Nome do usuário é obrigatório.');
        END IF;

        IF NOT REGEXP_LIKE(p_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
            RAISE_APPLICATION_ERROR(-20002, 'E-mail inválido.');
        END IF;

        INSERT INTO usuario (
            nome, email, cpf, senioridade, area_interesse, risco_automacao
        ) VALUES (
            p_nome, p_email, p_cpf, p_senioridade, p_area_interesse, p_risco_automacao
        );

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20003, 'E-mail ou CPF já cadastrado.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20004, 'Erro ao inserir usuário: ' || SQLERRM);
    END;

END pkg_usuario;
/
