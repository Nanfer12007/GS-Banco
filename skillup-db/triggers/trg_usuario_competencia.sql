CREATE OR REPLACE TRIGGER trg_usuario_competencia_aud
AFTER INSERT OR UPDATE OR DELETE ON usuario_competencia
FOR EACH ROW
DECLARE
    v_op VARCHAR2(10);
    v_key VARCHAR2(100);
BEGIN
    v_key :=
        NVL(TO_CHAR(:NEW.id_usuario), TO_CHAR(:OLD.id_usuario))
        || '-' ||
        NVL(TO_CHAR(:NEW.id_competencia), TO_CHAR(:OLD.id_competencia));

    IF INSERTING THEN
        v_op := 'INSERT';
    ELSIF UPDATING THEN
        v_op := 'UPDATE';
    ELSE
        v_op := 'DELETE';
    END IF;

    pkg_auditoria.prc_registrar(
        p_tabela   => 'USUARIO_COMPETENCIA',
        p_operacao => v_op,
        p_id_reg   => v_key,
        p_detalhe  => 'Alteração em USUARIO_COMPETENCIA'
    );
END;
/
