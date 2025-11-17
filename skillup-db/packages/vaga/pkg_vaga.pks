CREATE OR REPLACE PACKAGE pkg_vaga AS

    PROCEDURE prc_inserir_vaga (
        p_titulo       IN vaga.titulo%TYPE,
        p_empresa      IN vaga.empresa%TYPE,
        p_localidade   IN vaga.localidade%TYPE,
        p_modalidade   IN vaga.modalidade%TYPE,
        p_descricao    IN vaga.descricao%TYPE,
        p_faixa        IN vaga.faixa_salarial%TYPE
    );

    -- FUNÇÃO 2 (exigida na atividade)
    FUNCTION fn_competencia_match (
        p_id_usuario IN usuario.id_usuario%TYPE,
        p_id_vaga    IN vaga.id_vaga%TYPE
    ) RETURN NUMBER;

END pkg_vaga;
/
