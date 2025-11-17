-------------------------------------------------------------
-- POPULAÇÃO INICIAL DO BANCO DE DADOS SKILLUP
-- Requisito: mínimo 10 registros por tabela
-- Todos os inserts realizados EXCLUSIVAMENTE via procedures
-------------------------------------------------------------

SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Iniciando carga de dados...');
END;
/

-------------------------------------------------------------
-- 1. USUÁRIOS (10 registros)
-------------------------------------------------------------
BEGIN
    pkg_usuario.prc_inserir_usuario('Ana Silva',    'ana.silva@exemplo.com',    '11111111111', 'Junior', 'Dados', 85);
    pkg_usuario.prc_inserir_usuario('Bruno Lima',   'bruno.lima@exemplo.com',   '22222222222', 'Pleno',  'Desenvolvimento', 60);
    pkg_usuario.prc_inserir_usuario('Carla Souza',  'carla.souza@exemplo.com',  '33333333333', 'Senior', 'UX/UI', 40);
    pkg_usuario.prc_inserir_usuario('Diego Costa',  'diego.costa@exemplo.com',  '44444444444', 'Pleno',  'IA', 75);
    pkg_usuario.prc_inserir_usuario('Eduarda Reis', 'eduarda.reis@exemplo.com', '55555555555', 'Junior', 'Cloud', 55);
    pkg_usuario.prc_inserir_usuario('Fernando Melo','fernando.melo@exemplo.com','66666666666', 'Pleno',  'DevOps', 50);
    pkg_usuario.prc_inserir_usuario('Gabriela Luz', 'gabi.luz@exemplo.com',     '77777777777', 'Junior', 'Cibersegurança', 80);
    pkg_usuario.prc_inserir_usuario('Henrique Dias','henrique.dias@exa.com',     '88888888888', 'Senior', 'Dados', 35);
    pkg_usuario.prc_inserir_usuario('Isabela Nunes','isabela.nunes@exa.com',     '99999999999', 'Pleno',  'Desenvolvimento', 65);
    pkg_usuario.prc_inserir_usuario('João Pedro',   'joao.pedro@exa.com',        '00000000000', 'Junior', 'IA', 90);
END;
/

-------------------------------------------------------------
-- 2. COMPETÊNCIAS
-------------------------------------------------------------
BEGIN
    pkg_competencia.prc_inserir_competencia('Python', 'Tecnica', 'Linguagem essencial para análise de dados e IA.');
    pkg_competencia.prc_inserir_competencia('SQL', 'Tecnica', 'Consulta e manipulação de banco de dados.');
    pkg_competencia.prc_inserir_competencia('Machine Learning', 'Tecnica', 'Modelagem de IA e previsões.');
    pkg_competencia.prc_inserir_competencia('Comunicação', 'Comportamental', 'Habilidade essencial para trabalho em equipe.');
    pkg_competencia.prc_inserir_competencia('Resolução de Problemas', 'Comportamental', 'Pensamento crítico.');
    pkg_competencia.prc_inserir_competencia('Java', 'Tecnica', 'Linguagem usada em grandes sistemas corporativos.');
    pkg_competencia.prc_inserir_competencia('Cloud AWS', 'Tecnica', 'Infraestrutura em nuvem.');
    pkg_competencia.prc_inserir_competencia('DevOps', 'Tecnica', 'Integração e entrega contínua.');
    pkg_competencia.prc_inserir_competencia('UX Design', 'Tecnica', 'Experiência do usuário.');
    pkg_competencia.prc_inserir_competencia('Ciberseguranca', 'Tecnica', 'Proteção de sistemas e dados.');
END;
/

-------------------------------------------------------------
-- 3. USUARIO_COMPETENCIA (10+ registros)
-------------------------------------------------------------
BEGIN
    pkg_competencia.prc_associar_usuario(1, 1, 70); -- Ana → Python
    pkg_competencia.prc_associar_usuario(1, 2, 60);
    pkg_competencia.prc_associar_usuario(2, 6, 80);
    pkg_competencia.prc_associar_usuario(2, 2, 75);
    pkg_competencia.prc_associar_usuario(3, 9, 90);
    pkg_competencia.prc_associar_usuario(4, 3, 85);
    pkg_competencia.prc_associar_usuario(5, 7, 50);
    pkg_competencia.prc_associar_usuario(6, 8, 70);
    pkg_competencia.prc_associar_usuario(7, 10, 80);
    pkg_competencia.prc_associar_usuario(8, 1, 65);
END;
/

-------------------------------------------------------------
-- 4. CURSOS (10 registros)
-------------------------------------------------------------
BEGIN
    pkg_curso_trilha.prc_inserir_curso('Python para Análise de Dados', 'Coursera', 40, 'Intermediário', 'Dados');
    pkg_curso_trilha.prc_inserir_curso('SQL Essencial', 'Alura', 20, 'Básico', 'Dados');
    pkg_curso_trilha.prc_inserir_curso('Machine Learning com Scikit-Learn', 'DIO', 60, 'Avançado', 'IA');
    pkg_curso_trilha.prc_inserir_curso('Fundamentos de DevOps', 'Udemy', 30, 'Intermediário', 'DevOps');
    pkg_curso_trilha.prc_inserir_curso('Introdução à Cibersegurança', 'Cisco', 25, 'Básico', 'Segurança');
    pkg_curso_trilha.prc_inserir_curso('Java do Zero ao Avançado', 'Udemy', 60, 'Intermediário', 'Desenvolvimento');
    pkg_curso_trilha.prc_inserir_curso('Design de UX para Iniciantes', 'Alura', 15, 'Básico', 'UX/UI');
    pkg_curso_trilha.prc_inserir_curso('Arquitetura AWS', 'AWS Academy', 50, 'Avançado', 'Cloud');
    pkg_curso_trilha.prc_inserir_curso('Comunicação Profissional', 'Sebrae', 10, 'Básico', 'Soft Skills');
    pkg_curso_trilha.prc_inserir_curso('Análise de Dados com Power BI', 'DIO', 35, 'Intermediário', 'Dados');
END;
/

-------------------------------------------------------------
-- 5. TRILHAS (10 registros)
-------------------------------------------------------------
BEGIN
    pkg_curso_trilha.prc_inserir_trilha('Trilha de Dados', 'Do zero ao avançado em análise de dados.');
    pkg_curso_trilha.prc_inserir_trilha('Trilha de IA', 'Fundamentos até modelos avançados.');
    pkg_curso_trilha.prc_inserir_trilha('Trilha de DevOps', 'Ambiente DevOps completo.');
    pkg_curso_trilha.prc_inserir_trilha('Trilha de Cloud', 'Formação AWS.');
    pkg_curso_trilha.prc_inserir_trilha('Trilha de Segurança', 'Cibersegurança e proteção digital.');
    pkg_curso_trilha.prc_inserir_trilha('Trilha Full Stack', 'Desenvolvedor completo.');
    pkg_curso_trilha.prc_inserir_trilha('Trilha UX/UI', 'Design digital do zero.');
    pkg_curso_trilha.prc_inserir_trilha('Trilha Soft Skills', 'Habilidades comportamentais.');
    pkg_curso_trilha.prc_inserir_trilha('Trilha Dev Java', 'Especialização em Java.');
    pkg_curso_trilha.prc_inserir_trilha('Trilha Power BI', 'Dashboards e visualizações.');
END;
/

-------------------------------------------------------------
-- 6. VAGAS (10 registros)
-------------------------------------------------------------
BEGIN
    pkg_vaga.prc_inserir_vaga('Analista de Dados', 'TechCorp', 'São Paulo', 'Híbrido', 'Análise e preparação de dados.', 'R$ 5.000 - 7.000');
    pkg_vaga.prc_inserir_vaga('Dev Backend Java', 'GlobalSYS', 'Remoto', 'Remoto', 'Desenvolvimento de APIs e serviços.', 'R$ 6.000 - 9.000');
    pkg_vaga.prc_inserir_vaga('Cientista de Dados', 'NeuralTech', 'São Paulo', 'Presencial', 'Modelos de ML e predições.', 'R$ 10.000 - 15.000');
    pkg_vaga.prc_inserir_vaga('UX Designer', 'DesignLab', 'Rio de Janeiro', 'Híbrido', 'Criação de interfaces digitais.', 'R$ 4.000 - 6.000');
    pkg_vaga.prc_inserir_vaga('Arquiteto AWS', 'CloudMasters', 'Curitiba', 'Remoto', 'Soluções cloud.', 'R$ 12.000 - 18.000');
    pkg_vaga.prc_inserir_vaga('Analista de Cibersegurança', 'DataProtect', 'São Paulo', 'Presencial', 'Proteção de dados.', 'R$ 8.000 - 12.000');
    pkg_vaga.prc_inserir_vaga('DevOps Engineer', 'DeployX', 'Belo Horizonte', 'Híbrido', 'Infra CI/CD.', 'R$ 9.000 - 13.000');
    pkg_vaga.prc_inserir_vaga('Product Designer', 'UXHub', 'Recife', 'Remoto', 'Prototipação e design.', 'R$ 5.000 - 8.000');
    pkg_vaga.prc_inserir_vaga('Analista Power BI', 'DashCorp', 'Curitiba', 'Presencial', 'Relatórios e dashboards.', 'R$ 4.000 - 6.000');
    pkg_vaga.prc_inserir_vaga('Machine Learning Engineer', 'AI Solutions', 'São Paulo', 'Híbrido', 'Treino e deploy de modelos.', 'R$ 12.000 - 16.000');
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Carga finalizada com sucesso!');
END;
/
