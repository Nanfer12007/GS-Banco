CREATE OR REPLACE TRIGGER trg_vaga_aud
AFTER INSERT OR UPDATE OR DELETE ON vaga
FOR EACH ROW
DECLARE
    v_op VARCHAR2(10);
    v_id VARCHAR2(100);
BEGIN
    IF INSERTING THEN
        v_op := 'INSERT';
        v_id := :NEW.id_vaga;
    ELSIF UPDATING THEN
        v_op := 'UPDATE';
        v_id := :NEW.id_vaga;
    ELSE
        v_op := 'DELETE';
        v_id := :OLD.id_vaga;
    END IF;

    pkg_auditoria.prc_registrar(
        p_tabela   => 'VAGA',
        p_operacao => v_op,
        p_id_reg   => v_id,
        p_detalhe  => 'Alteração em VAGA'
    );
END;
/
