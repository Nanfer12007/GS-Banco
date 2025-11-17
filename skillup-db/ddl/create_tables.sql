-- PROFISSIONAIS / USUÁRIOS DA PLATAFORMA
CREATE TABLE usuario (
    id_usuario        NUMBER        PRIMARY KEY,
    nome              VARCHAR2(100) NOT NULL,
    email             VARCHAR2(150) NOT NULL UNIQUE,
    cpf               VARCHAR2(11)  NOT NULL UNIQUE,
    senioridade       VARCHAR2(30),           -- jr, pleno, sr
    area_interesse    VARCHAR2(100),          -- dados, dev, design, etc
    risco_automacao   NUMBER(3),              -- 0 a 100 (risco do cargo atual)
    dt_cadastro       DATE DEFAULT SYSDATE
);

-- COMPETÊNCIAS 
CREATE TABLE competencia (
    id_competencia    NUMBER        PRIMARY KEY,
    nome              VARCHAR2(100) NOT NULL,
    categoria         VARCHAR2(50),           -- técnica, comportamental
    descricao         VARCHAR2(4000)
);

-- CURSOS
CREATE TABLE curso (
    id_curso          NUMBER        PRIMARY KEY,
    titulo            VARCHAR2(200) NOT NULL,
    provedor          VARCHAR2(100),          -- Coursera, Alura, etc
    carga_horaria     NUMBER(5),
    nivel             VARCHAR2(30),           -- básico, intermediário, avançado
    area_foco         VARCHAR2(100)           -- IA, dados, programação, soft skills
);

-- TRILHAS (agrupam cursos)
CREATE TABLE trilha (
    id_trilha         NUMBER        PRIMARY KEY,
    nome              VARCHAR2(200) NOT NULL,
    descricao         VARCHAR2(4000)
);

-- VAGAS (futuro do trabalho)
CREATE TABLE vaga (
    id_vaga           NUMBER        PRIMARY KEY,
    titulo            VARCHAR2(200) NOT NULL,
    empresa           VARCHAR2(150),
    localidade        VARCHAR2(100),
    modalidade        VARCHAR2(30),           -- remoto, híbrido, presencial
    descricao         VARCHAR2(4000),
    faixa_salarial    VARCHAR2(50),
    dt_publicacao     DATE
);

-- TABELAS DE RELACIONAMENTO 3FN

-- Usuário x Competência
CREATE TABLE usuario_competencia (
    id_usuario        NUMBER NOT NULL,
    id_competencia    NUMBER NOT NULL,
    nivel             NUMBER(3),             -- 0 a 100 (nível de proficiência)
    CONSTRAINT pk_usuario_competencia PRIMARY KEY (id_usuario, id_competencia)
);

-- Curso x Competência
CREATE TABLE curso_competencia (
    id_curso          NUMBER NOT NULL,
    id_competencia    NUMBER NOT NULL,
    relevancia        NUMBER(3),            -- % de relevância da skill no curso
    CONSTRAINT pk_curso_competencia PRIMARY KEY (id_curso, id_competencia)
);

-- Matricula de usuário em curso
CREATE TABLE matricula_curso (
    id_matricula      NUMBER PRIMARY KEY,
    id_usuario        NUMBER NOT NULL,
    id_curso          NUMBER NOT NULL,
    dt_matricula      DATE DEFAULT SYSDATE,
    status            VARCHAR2(20)          -- em_andamento, concluido, cancelado
);

-- Vaga x Competência
CREATE TABLE vaga_competencia (
    id_vaga           NUMBER NOT NULL,
    id_competencia    NUMBER NOT NULL,
    peso              NUMBER(3),            -- peso da skill para a vaga
    CONSTRAINT pk_vaga_competencia PRIMARY KEY (id_vaga, id_competencia)
);

-- Tabela de auditoria genérica
CREATE TABLE auditoria_log (
    id_log            NUMBER PRIMARY KEY,
    tabela_afetada    VARCHAR2(50),
    operacao          VARCHAR2(10),          -- INSERT, UPDATE, DELETE
    id_registro       VARCHAR2(100),
    usuario_bd        VARCHAR2(30),
    dt_operacao       DATE DEFAULT SYSDATE,
    detalhe           VARCHAR2(4000)
);