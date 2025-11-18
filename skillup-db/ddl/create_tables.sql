-------------------------------------------------------------
-- CREATE TABLES – SkillUp (Futuro do Trabalho / Requalificação)
-- Todas usando IDENTITY COLUMN conforme escolhido
-------------------------------------------------------------

-------------------------------------------------------------
-- Tabela USUARIO
-------------------------------------------------------------
CREATE TABLE usuario (
    id_usuario        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome              VARCHAR2(100)   NOT NULL,
    email             VARCHAR2(120)   NOT NULL UNIQUE,
    cpf               VARCHAR2(14)    NOT NULL UNIQUE,
    senioridade       VARCHAR2(20)    CHECK (senioridade IN ('Junior','Pleno','Senior')),
    area_interesse    VARCHAR2(100),
    risco_automacao   NUMBER(3)       CHECK (risco_automacao BETWEEN 0 AND 100)
);

-------------------------------------------------------------
-- Tabela COMPETENCIA
-------------------------------------------------------------
CREATE TABLE competencia (
    id_competencia   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome             VARCHAR2(100) NOT NULL,
    categoria        VARCHAR2(30)  CHECK (categoria IN ('Tecnica','Comportamental')),
    descricao        VARCHAR2(500)
);

-------------------------------------------------------------
-- Tabela USUARIO_COMPETENCIA (N:N)
-------------------------------------------------------------
CREATE TABLE usuario_competencia (
    id_usuario       NUMBER NOT NULL,
    id_competencia   NUMBER NOT NULL,
    nivel            NUMBER(3) CHECK (nivel BETWEEN 0 AND 100),
    CONSTRAINT pk_usuario_competencia PRIMARY KEY (id_usuario, id_competencia)
);

-------------------------------------------------------------
-- Tabela CURSO
-------------------------------------------------------------
CREATE TABLE curso (
    id_curso        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo          VARCHAR2(150) NOT NULL,
    provedor        VARCHAR2(80),
    carga_horaria   NUMBER,
    nivel           VARCHAR2(20),
    area_foco       VARCHAR2(80)
);

-------------------------------------------------------------
-- Tabela TRILHA
-------------------------------------------------------------
CREATE TABLE trilha (
    id_trilha     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome          VARCHAR2(120) NOT NULL,
    descricao     VARCHAR2(4000)
);

-------------------------------------------------------------
-- Tabela CURSO_COMPETENCIA (N:N)
-------------------------------------------------------------
CREATE TABLE curso_competencia (
    id_curso        NUMBER NOT NULL,
    id_competencia  NUMBER NOT NULL,
    CONSTRAINT pk_curso_competencia PRIMARY KEY (id_curso, id_competencia)
);

-------------------------------------------------------------
-- Tabela VAGA
-------------------------------------------------------------
CREATE TABLE vaga (
    id_vaga         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo          VARCHAR2(150) NOT NULL,
    empresa         VARCHAR2(120) NOT NULL,
    localidade      VARCHAR2(100),
    modalidade      VARCHAR2(20) CHECK (modalidade IN ('Remoto','Híbrido','Presencial')),
    descricao       VARCHAR2(4000),
    faixa_salarial  VARCHAR2(60),
    dt_publicacao   DATE DEFAULT SYSDATE
);

-------------------------------------------------------------
-- Tabela VAGA_COMPETENCIA (N:N)
-------------------------------------------------------------
CREATE TABLE vaga_competencia (
    id_vaga         NUMBER NOT NULL,
    id_competencia  NUMBER NOT NULL,
    peso            NUMBER(3) CHECK (peso BETWEEN 0 AND 100),
    CONSTRAINT pk_vaga_competencia PRIMARY KEY (id_vaga, id_competencia)
);

-------------------------------------------------------------
-- Tabela MATRICULA_CURSO
-------------------------------------------------------------
CREATE TABLE matricula_curso (
    id_matricula   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario     NUMBER NOT NULL,
    id_curso       NUMBER NOT NULL,
    dt_matricula   DATE DEFAULT SYSDATE
);

-------------------------------------------------------------
-- Tabela AUDITORIA_LOG (usada pelas triggers)
-------------------------------------------------------------
CREATE TABLE auditoria_log (
    id_log           NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tabela_afetada   VARCHAR2(100) NOT NULL,
    operacao         VARCHAR2(10)  NOT NULL,
    id_registro      VARCHAR2(100),
    usuario_bd       VARCHAR2(50),
    data_operacao    DATE DEFAULT SYSDATE,
    detalhe          VARCHAR2(4000)
);
