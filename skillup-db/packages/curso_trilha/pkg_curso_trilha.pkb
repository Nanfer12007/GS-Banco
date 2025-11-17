CREATE OR REPLACE PACKAGE BODY pkg_curso_trilha AS

    PROCEDURE prc_inserir_curso (
        p_titulo       IN curso.titulo%TYPE,
        p_provedor     IN curso.provedor%TYPE,
        p_carga_horaria IN curso.carga_horaria%TYPE,
        p_nivel        IN curso.nivel%TYPE,
        p_area_foco    IN curso.area_foco%TYPE
    )
    IS
    BEGIN
        INSERT INTO curso (
            titulo, provedor, carga_horaria, nivel, area_foco
        ) VALUES (
            p_titulo, p_provedor, p_carga_horaria, p_nivel, p_area_foco
        );
    END;

    PROCEDURE prc_inserir_trilha (
        p_nome      IN trilha.nome%TYPE,
        p_descricao IN trilha.descricao%TYPE
    )
    IS
    BEGIN
        INSERT INTO trilha (nome, descricao)
        VALUES (p_nome, p_descricao);
    END;

END pkg_curso_trilha;
/
