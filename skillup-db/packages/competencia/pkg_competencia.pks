CREATE OR REPLACE PACKAGE pkg_competencia AS

    PROCEDURE prc_inserir_competencia (
        p_nome       IN competencia.nome%TYPE,
        p_categoria  IN competencia.categoria%TYPE,
        p_descricao  IN competencia.descricao%TYPE
    );

    PROCEDURE prc_associar_usuario (
        p_id_usuario      IN usuario_competencia.id_usuario%TYPE,
        p_id_competencia  IN usuario_competencia.id_competencia%TYPE,
        p_nivel           IN usuario_competencia.nivel%TYPE
    );

END pkg_competencia;
/
