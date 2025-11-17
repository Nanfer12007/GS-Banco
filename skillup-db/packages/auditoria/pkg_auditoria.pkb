CREATE OR REPLACE PACKAGE BODY pkg_auditoria AS

    PROCEDURE prc_registrar (
        p_tabela     IN auditoria_log.tabela_afetada%TYPE,
        p_operacao   IN auditoria_log.operacao%TYPE,
        p_id_reg     IN auditoria_log.id_registro%TYPE,
        p_detalhe    IN auditoria_log.detalhe%TYPE
    )
    IS
    BEGIN
        INSERT INTO auditoria_log (
            tabela_afetada,
            operacao,
            id_registro,
            usuario_bd,
            detalhe
        ) VALUES (
            p_tabela,
            p_operacao,
            p_id_reg,
            USER,
            p_detalhe
        );
    END;

END pkg_auditoria;
/
