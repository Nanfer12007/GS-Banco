CREATE OR REPLACE TRIGGER trg_matricula_curso_aud
AFTER INSERT OR UPDATE OR DELETE ON matricula_curso
FOR EACH ROW
DECLARE
    v_op VARCHAR2(10);
    v_id VARCHAR2(100);
BEGIN
    IF INSERTING THEN
        v_op := 'INSERT';
        v_id := :NEW.id_matricula;
    ELSIF UPDATING THEN
        v_op := 'UPDATE';
        v_id := :NEW.id_matricula;
    ELSE
        v_op := 'DELETE';
        v_id := :OLD.id_matricula;
    END IF;

    pkg_auditoria.prc_registrar(
        p_tabela   => 'MATRICULA_CURSO',
        p_operacao => v_op,
        p_id_reg   => v_id,
        p_detalhe  => 'Alteração em MATRICULA_CURSO'
    );
END;
/
