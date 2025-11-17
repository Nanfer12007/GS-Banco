CREATE OR REPLACE TRIGGER trg_vaga_competencia_aud
AFTER INSERT OR UPDATE OR DELETE ON vaga_competencia
FOR EACH ROW
DECLARE
    v_oper VARCHAR2(10);
    v_key VARCHAR2(100);
BEGIN
    v_key :=
        NVL(TO_CHAR(:NEW.id_vaga), TO_CHAR(:OLD.id_vaga)) ||
        '-' ||
        NVL(TO_CHAR(:NEW.id_competencia), TO_CHAR(:OLD.id_competencia));

    IF INSERTING THEN
        v_oper := 'INSERT';
    ELSIF UPDATING THEN
        v_oper := 'UPDATE';
    ELSE
        v_oper := 'DELETE';
    END IF;

    pkg_auditoria.prc_registrar(
        p_tabela   => 'VAGA_COMPETENCIA',
        p_operacao => v_oper,
        p_id_reg   => v_key,
        p_detalhe  => 'Alteração em VAGA_COMPETENCIA'
    );
END;
/
