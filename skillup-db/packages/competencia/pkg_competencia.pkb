CREATE OR REPLACE PACKAGE BODY pkg_competencia AS

    PROCEDURE prc_inserir_competencia (
        p_nome       IN competencia.nome%TYPE,
        p_categoria  IN competencia.categoria%TYPE,
        p_descricao  IN competencia.descricao%TYPE
    )
    IS
    BEGIN
        INSERT INTO competencia (nome, categoria, descricao)
        VALUES (p_nome, p_categoria, p_descricao);
    END;

    PROCEDURE prc_associar_usuario (
        p_id_usuario      IN usuario_competencia.id_usuario%TYPE,
        p_id_competencia  IN usuario_competencia.id_competencia%TYPE,
        p_nivel           IN usuario_competencia.nivel%TYPE
    )
    IS
        v_dummy NUMBER;
    BEGIN
        SELECT 1 INTO v_dummy FROM usuario WHERE id_usuario = p_id_usuario;
        SELECT 1 INTO v_dummy FROM competencia WHERE id_competencia = p_id_competencia;

        INSERT INTO usuario_competencia (id_usuario, id_competencia, nivel)
        VALUES (p_id_usuario, p_id_competencia, p_nivel);

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-21001, 'Competência já atribuída ao usuário.');
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-21002, 'Usuário ou competência não encontrados.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-21003, 'Erro ao associar competência: ' || SQLERRM);
    END;

END pkg_competencia;
/
