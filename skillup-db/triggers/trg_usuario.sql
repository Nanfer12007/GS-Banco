CREATE OR REPLACE TRIGGER trg_usuario_aud
AFTER INSERT OR UPDATE OR DELETE ON usuario
FOR EACH ROW
DECLARE
  v_operacao   VARCHAR2(10);
  v_id_reg     VARCHAR2(100);
BEGIN
  IF INSERTING THEN
    v_operacao := 'INSERT';
    v_id_reg := :NEW.id_usuario;
  ELSIF UPDATING THEN
    v_operacao := 'UPDATE';
    v_id_reg := :NEW.id_usuario;
  ELSIF DELETING THEN
    v_operacao := 'DELETE';
    v_id_reg := :OLD.id_usuario;
  END IF;

  INSERT INTO auditoria_log (
    id_log,
    tabela_afetada,
    operacao,
    id_registro,
    usuario_bd,
    detalhe
  ) VALUES (
    auditoria_seq.NEXTVAL,
    'USUARIO',
    v_operacao,
    v_id_reg,
    USER,
    'Alteração na tabela USUARIO'
  );
END;
/
