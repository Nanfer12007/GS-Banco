CREATE OR REPLACE TRIGGER trg_usuario_aud
AFTER INSERT OR UPDATE OR DELETE ON usuario
FOR EACH ROW
DECLARE
    v_oper   VARCHAR2(10);
    v_id     VARCHAR2(100);
    v_det    VARCHAR2(4000);
BEGIN
    IF INSERTING THEN
        v_oper := 'INSERT';
        v_id := :NEW.id_usuario;
        v_det := 'Novo registro cadastrado.';
    ELSIF UPDATING THEN
        v_oper := 'UPDATE';
        v_id := :NEW.id_usuario;
        v_det := 'Registro atualizado.';
    ELSIF DELETING THEN
        v_oper := 'DELETE';
        v_id := :OLD.id_usuario;
        v_det := 'Registro excluido.';
    END IF;

    pkg_auditoria.prc_registrar(
        p_tabela   => 'USUARIO',
        p_operacao => v_oper,
        p_id_reg   => v_id,
        p_detalhe  => v_det
    );
END;
/
