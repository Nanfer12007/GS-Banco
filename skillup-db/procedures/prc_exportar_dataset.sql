CREATE OR REPLACE PROCEDURE prc_exportar_dataset_json (p_json OUT CLOB) AS
BEGIN
    p_json := pkg_json_export.fn_json_perfil_profissional(1);
END;
/
