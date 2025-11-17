CREATE OR REPLACE PACKAGE pkg_curso_trilha AS

    PROCEDURE prc_inserir_curso (
        p_titulo       IN curso.titulo%TYPE,
        p_provedor     IN curso.provedor%TYPE,
        p_carga_horaria IN curso.carga_horaria%TYPE,
        p_nivel        IN curso.nivel%TYPE,
        p_area_foco    IN curso.area_foco%TYPE
    );

    PROCEDURE prc_inserir_trilha (
        p_nome      IN trilha.nome%TYPE,
        p_descricao IN trilha.descricao%TYPE
    );

END pkg_curso_trilha;
/
