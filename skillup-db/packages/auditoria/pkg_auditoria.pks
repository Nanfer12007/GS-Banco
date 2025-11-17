CREATE OR REPLACE PACKAGE pkg_auditoria AS

    PROCEDURE prc_registrar (
        p_tabela     IN auditoria_log.tabela_afetada%TYPE,
        p_operacao   IN auditoria_log.operacao%TYPE,
        p_id_reg     IN auditoria_log.id_registro%TYPE,
        p_detalhe    IN auditoria_log.detalhe%TYPE
    );

END pkg_auditoria;
/
