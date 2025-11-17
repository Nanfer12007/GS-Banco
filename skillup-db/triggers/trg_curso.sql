CREATE OR REPLACE TRIGGER trg_curso_aud
AFTER INSERT OR UPDATE OR DELETE ON curso
FOR EACH ROW
DECLARE
    v_oper VARCHAR2(10);
    v_id   VARCHAR2(100);
BEGIN
    IF INSERTING THEN
        v_oper := 'INSERT';
        v_id := :NEW.id_curso;
    ELSIF UPDATING THEN
        v_oper := 'UPDATE';
        v_id := :NEW.id_curso;
    ELSE
        v_oper := 'DELETE';
        v_id := :OLD.id_curso;
    END IF;

    pkg_auditoria.prc_registrar(
        p_tabela   => 'CURSO',
        p_operacao => v_oper,
        p_id_reg   => v_id,
        p_detalhe  => 'Alteração em CURSO'
    );
END;
/
