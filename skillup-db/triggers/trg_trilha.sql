CREATE OR REPLACE TRIGGER trg_trilha_aud
AFTER INSERT OR UPDATE OR DELETE ON trilha
FOR EACH ROW
DECLARE
    v_oper VARCHAR2(10);
    v_id   VARCHAR2(100);
BEGIN
    IF INSERTING THEN
        v_oper := 'INSERT';
        v_id := :NEW.id_trilha;
    ELSIF UPDATING THEN
        v_oper := 'UPDATE';
        v_id := :NEW.id_trilha;
    ELSE
        v_oper := 'DELETE';
        v_id := :OLD.id_trilha;
    END IF;

    pkg_auditoria.prc_registrar(
        p_tabela   => 'TRILHA',
        p_operacao => v_oper,
        p_id_reg   => v_id,
        p_detalhe  => 'Alteração em TRILHA'
    );
END;
/
