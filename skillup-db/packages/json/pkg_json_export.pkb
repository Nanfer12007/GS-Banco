CREATE OR REPLACE PACKAGE BODY pkg_json_export AS

    FUNCTION fn_perfil_usuario_json (
        p_id_usuario IN usuario.id_usuario%TYPE
    ) RETURN CLOB
    IS
        v_json  CLOB;
        v_nome  usuario.nome%TYPE;
        v_email usuario.email%TYPE;
        v_risco usuario.risco_automacao%TYPE;

        CURSOR c_comp IS
            SELECT c.nome, uc.nivel
            FROM usuario_competencia uc
            JOIN competencia c ON c.id_competencia = uc.id_competencia
            WHERE uc.id_usuario = p_id_usuario;

        CURSOR c_curso IS
            SELECT cu.titulo, cu.provedor
            FROM matricula_curso mc
            JOIN curso cu ON cu.id_curso = mc.id_curso
            WHERE mc.id_usuario = p_id_usuario;

        v_first BOOLEAN := TRUE;

    BEGIN
        SELECT nome, email, risco_automacao
        INTO v_nome, v_email, v_risco
        FROM usuario
        WHERE id_usuario = p_id_usuario;

        v_json := '{' ||
                  '"id_usuario":'||p_id_usuario||','||
                  '"nome":"'||v_nome||'",'||
                  '"email":"'||v_email||'",'||
                  '"risco_automacao":'||NVL(v_risco,0)||',';

        -- Compentencias
        v_json := v_json || '"competencias":[';
        v_first := TRUE;
        FOR c IN c_comp LOOP
            IF NOT v_first THEN v_json := v_json || ','; END IF;
            v_first := FALSE;

            v_json := v_json||'{"nome":"'||c.nome||'", "nivel":'||c.nivel||'}';
        END LOOP;
        v_json := v_json || '],';

        -- Cursos
        v_json := v_json || '"cursos":[';
        v_first := TRUE;
        FOR cc IN c_curso LOOP
            IF NOT v_first THEN v_json := v_json || ','; END IF;
            v_first := FALSE;

            v_json := v_json||'{"titulo":"'||cc.titulo||'", "provedor":"'||cc.provedor||'"}';
        END LOOP;
        v_json := v_json || ']';

        v_json := v_json || '}';

        RETURN v_json;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN '{"erro":"usuario nao encontrado"}';
        WHEN VALUE_ERROR THEN
            RETURN '{"erro":"erro de conversao"}';
        WHEN OTHERS THEN
            RETURN '{"erro":"erro inesperado"}';
    END;


    PROCEDURE prc_exportar_dataset (
        p_json OUT CLOB
    )
    IS
        v_json CLOB := '[';
        v_first BOOLEAN := TRUE;
    BEGIN
        FOR u IN (SELECT id_usuario FROM usuario) LOOP
            IF NOT v_first THEN
                v_json := v_json || ',';
            END IF;

            v_first := FALSE;

            v_json := v_json || fn_perfil_usuario_json(u.id_usuario);
        END LOOP;

        v_json := v_json || ']';

        p_json := v_json;
    END;

END pkg_json_export;
/
