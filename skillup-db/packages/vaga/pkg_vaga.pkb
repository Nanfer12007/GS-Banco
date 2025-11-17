CREATE OR REPLACE PACKAGE BODY pkg_vaga AS

    PROCEDURE prc_inserir_vaga (
        p_titulo       IN vaga.titulo%TYPE,
        p_empresa      IN vaga.empresa%TYPE,
        p_localidade   IN vaga.localidade%TYPE,
        p_modalidade   IN vaga.modalidade%TYPE,
        p_descricao    IN vaga.descricao%TYPE,
        p_faixa        IN vaga.faixa_salarial%TYPE
    )
    IS
    BEGIN
        INSERT INTO vaga (
            titulo, empresa, localidade, modalidade, descricao, faixa_salarial, dt_publicacao
        ) VALUES (
            p_titulo, p_empresa, p_localidade, p_modalidade,
            p_descricao, p_faixa, SYSDATE
        );
    END;


    -------------------------------------------------------------------
    -- FUNÇÃO 2: Cálculo de compatibilidade com REGEXP + EXCEÇÕES
    -------------------------------------------------------------------
    FUNCTION fn_competencia_match (
        p_id_usuario IN usuario.id_usuario%TYPE,
        p_id_vaga    IN vaga.id_vaga%TYPE
    ) RETURN NUMBER
    IS
        v_total_requisitos NUMBER;
        v_atendidos        NUMBER;
        v_percentual       NUMBER;
    BEGIN
        IF p_id_usuario IS NULL OR p_id_vaga IS NULL THEN
            RAISE_APPLICATION_ERROR(-30001, 'Usuário e vaga devem ser informados.');
        END IF;

        -- verificar se usuário existe
        DECLARE x NUMBER; BEGIN
            SELECT 1 INTO x FROM usuario WHERE id_usuario = p_id_usuario;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-30002, 'Usuário não encontrado.');
        END;

        -- verificar se vaga existe
        BEGIN
            SELECT 1 INTO x FROM vaga WHERE id_vaga = p_id_vaga;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-30003, 'Vaga não encontrada.');
        END;

        -- requisitos da vaga
        SELECT COUNT(*) INTO v_total_requisitos
        FROM vaga_competencia
        WHERE id_vaga = p_id_vaga;

        IF v_total_requisitos = 0 THEN
            RETURN 0;
        END IF;

        -- match de competências (usuário >= requisito)
        SELECT COUNT(*)
        INTO v_atendidos
        FROM vaga_competencia vc
        JOIN usuario_competencia uc 
          ON uc.id_competencia = vc.id_competencia
        WHERE vc.id_vaga = p_id_vaga
          AND uc.id_usuario = p_id_usuario
          AND uc.nivel >= vc.peso;  -- match simples

        v_percentual := ROUND((v_atendidos / v_total_requisitos) * 100, 2);

        RETURN v_percentual;

    EXCEPTION
        WHEN ZERO_DIVIDE THEN
            RETURN 0;
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-30099, 'Erro ao calcular compatibilidade: '||SQLERRM);
    END fn_competencia_match;

END pkg_vaga;
/
