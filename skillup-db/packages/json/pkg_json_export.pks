CREATE OR REPLACE PACKAGE pkg_json_export AS

    FUNCTION fn_perfil_usuario_json (
        p_id_usuario IN usuario.id_usuario%TYPE
    ) RETURN CLOB;

    PROCEDURE prc_exportar_dataset (
        p_json OUT CLOB
    );

END pkg_json_export;
/
