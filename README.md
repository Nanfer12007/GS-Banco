# SkillUp DB – Banco de Dados Oracle para Plataforma de Requalificação Profissional com IA

Este repositório contém o **banco de dados relacional Oracle** da plataforma **SkillUp**, uma solução web e mobile voltada para **requalificação profissional** e **futuro do trabalho**.  

A aplicação simula uma plataforma que:
- Cadastra **usuários/profissionais**;
- Registra suas **competências**, **cursos**, **trilhas de aprendizado** e **vagas**;
- Calcula **compatibilidade** entre perfil e vaga;
- Gera **JSONs manuais** para serem consumidos por módulos de **Inteligência Artificial**;
- Mantém **auditoria completa** de operações (INSERT, UPDATE, DELETE).

O projeto está alinhado com:
- **ODS 4 – Educação de Qualidade**  
- **ODS 8 – Trabalho Decente e Crescimento Econômico**

---

# SEÇÃO 1 - Membros do grupo

---

# SEÇÃO 2 - Objetivos Acadêmicos Atendidos

Aqui eu explico **diretamente** como este projeto cobre os itens do enunciado:

1. **Modelagem Relacional (3FN) e Implementação no Oracle**
   - Modelo baseado no tema **“O Futuro do Trabalho”** e na plataforma **SkillUp**.
   - Tabelas normalizadas até a **3ª Forma Normal (3FN)**.
   - Implementação no Oracle via scripts SQL em `ddl/`.

2. **Procedures e Funções**
   - **Procedures de inserção** para popular as tabelas com dados coerentes com o contexto.
   - **Função 1 – Conversão manual para JSON** (sem usar TO_JSON, JSON_OBJECT, etc.).
   - **Função 2 – Validações e cálculos lógicos** (usando REGEXP e tratamento de exceções).
   - **Procedure de exportação de dataset JSON** para consumo por IA.

3. **Triggers de Auditoria**
   - Triggers de auditoria em cada tabela principal, registrando:
     - Tipo de operação (INSERT, UPDATE, DELETE)
     - Usuário
     - Data/Hora
     - Valores antigos/novos (conforme aplicável).

4. **Empacotamento (Packages)**
   - Procedures e funções empacotadas em **packages** organizados por domínio:
     - Usuário, Competência, Curso/Trilha, Vaga, JSON/Exportação, Auditoria, etc.

5. **Integração com Outras Linguagens**
   - O banco é pensado para ser consumido por uma aplicação em **Java**, **C#** ou **mobile** (API), que pode:
     - Consultar usuários, vagas, cursos;
     - Consumir JSONs exportados;
     - Exibir compatibilidade entre usuário e vaga.

---

# SEÇÃO 3 - Tecnologias Utilizadas

- **Banco de Dados:** Oracle Database
- **Linguagem de programação do BD:** PL/SQL
- **Ferramentas possíveis:**
  - SQL*Plus, SQLcl ou SQL Developer
  - VS Code com extensões de SQL/Oracle

---

# SEÇÃO 4 - Descrição dos Principais Componentes

A base de dados foi organizada em pastas seguindo uma arquitetura modular, onde cada domínio da aplicação possui seus próprios packages, procedures e triggers. Isso facilita manutenção, reutilização e integração com a aplicação web/mobile do projeto.

---

### 4.1. DDL – Modelagem em 3FN (`ddl/`)

**`create_tables.sql`**
- Criação de todas as tabelas do projeto:
  - `USUARIO`
  - `COMPETENCIA`
  - `CURSO`
  - `TRILHA`
  - `VAGA`
  - Relacionamentos:  
    - `USUARIO_COMPETENCIA`  
    - `CURSO_COMPETENCIA`  
    - `VAGA_COMPETENCIA`  
    - `MATRICULA_CURSO`
  - `AUDITORIA_LOG` para registrar operações (INSERT/UPDATE/DELETE).

**`constraints.sql`**
- Define *Primary Keys*, *Foreign Keys*, *Unique*, *Check* e *Not Null*.
- Garante cardinilidade correta e normalização em 3FN.

**`seed_inserts.sql`**
- Executa **todas as procedures de inserção** dos packages.
- Popula o banco com **mínimo de 10 registros por tabela**, todos coerentes com:
  - Requalificação profissional  
  - Futuro do trabalho  
  - IA, automação, tecnologia, soft skills e transição verde

---

### 4.2. Packages por Domínio (`packages/`)

Os packages estão divididos por tema, seguindo boas práticas de modularização.

#### ✔ `packages/usuario/`
Gerencia ações ligadas ao usuário:
- `prc_inserir_usuario(...)`
- Validações internas (e-mail, campos obrigatórios)
- Preparação para integração com front-end da plataforma SkillUp

#### ✔ `packages/competencia/`
Gerencia competências técnicas e comportamentais:
- `prc_inserir_competencia(...)`
- `prc_associar_usuario(...)`
- Relacionamento direto com o futuro do trabalho (competências digitais, humanas, verdes)

#### ✔ `packages/curso_trilha/`
Gerencia cursos e trilhas:
- `prc_inserir_curso(...)`
- `prc_inserir_trilha(...)`
- Base para trilhas personalizadas de requalificação

#### ✔ `packages/vaga/`
Gerencia vagas de emprego:
- `prc_inserir_vaga(...)`
- `fn_competencia_match(...)` (Função 2 — cálculo de compatibilidade)
  - Usa REGEXP
  - Faz cálculos de percentual
  - Valida dados
  - Alinha os perfis às tendências do mercado

#### ✔ `packages/json/`
Responsável pela **Função 1 (JSON Manual)** e exportações:
- `fn_perfil_usuario_json(...)` → converte dados relacionais em JSON manual
- `prc_exportar_dataset(...)`
- Sem uso de funções JSON internas do Oracle (exigência do trabalho)

#### ✔ `packages/auditoria/`
Centraliza auditoria:
- `prc_registrar(...)`
- Chamado por todas as triggers

---

### 4.3. Funções Especiais (`functions/`)

#### ✔ Função 1 — `fn_json_manual.sql`
- Constrói JSON manualmente, usando apenas concatenação.
- Retorna JSON com:
  - Dados do usuário
  - Competências
  - Cursos
- Trata no mínimo **3 exceções**:
  - `NO_DATA_FOUND`
  - `VALUE_ERROR`
  - `OTHERS`
- Atende diretamente ao item obrigatório do enunciado.

#### ✔ Função 2 — `fn_validacoes.sql` (dentro de pkg_vaga)
- Calcula compatibilidade entre usuário e vaga.
- Usa **REGEXP** (ex.: validações)
- Faz consultas relacionais
- Retorna percentual de match entre competências do usuário e exigências da vaga
- Tratamento completo de exceções

--- 

# SEÇÃO 5 - Como Executar o Projeto

### ✔ 1. Criar usuário/schema no Oracle (opcional)
Se desejar, crie um schema exclusivo para o projeto:

```sql
CREATE USER skillup IDENTIFIED BY skillup123;
GRANT CONNECT, RESOURCE TO skillup;

### 2. Executar as tabelas

No VS Code ou SQL Developer execute:

- ddl/create_tables.sql
- ddl/constraints.sql

### 3. Criar os packages

Execute todos os .pks e depois os .pkb em:

packages/

Ordem recomendada:

auditoria - usuario - competencia -curso_trilha - vaga - json

### 4. Criar os triggers:

triggers/

### 5. Popular o banco (10 registros por tabela)

ddl/seed_inserts.sql

### 6. Gerar dataset JSON para IA

DECLARE
    v_json CLOB;
BEGIN
    pkg_json_export.prc_exportar_dataset(v_json);
    DBMS_OUTPUT.PUT_LINE(v_json);
END;
/

```

---

# SEÇÃO 6 – Como Demonstrar o Projeto na Apresentação**
```markdown
## 6. Como Demonstrar o Projeto na Apresentação

Sugestão de roteiro para defesa:

---

### 1️⃣ Contextualização
- Apresente rapidamente o projeto **SkillUp**.
- Explique o problema global: profissionalização, IA, automação, ODS 4 e 8.

---

### 2️⃣ Modelo Relacional (3FN)
- Mostre o `DER.pdf` (em docs/).
- Explique porque as tabelas foram separadas e como isso evita redundância.

---

### 3️⃣ Estrutura do projeto no VS Code
- Mostre as pastas:
  - `ddl/`
  - `packages/`
  - `triggers/`
  - `functions/`
  - `procedures/`

---

### 4️⃣ Destaques técnicos obrigatórios

#### ✔ Função 1 — JSON manual  
- Mostre parte do código (string sendo concatenada).
- Comente: “não usamos JSON_OBJECT porque é proibido pelo enunciado”.

#### ✔ Função 2 — REGEXP + cálculos  
- Exibir como foi feito o cálculo de compatibilidade entre usuário e vaga.

#### ✔ Auditoria completa  
- Executar um INSERT e mostrar registro surgindo em `AUDITORIA_LOG`.

#### ✔ Inserts via procedures  
- Mostrar chamada de `seed_inserts.sql`.

---

### 5️⃣ Integração com IA
- Mostrar como o JSON exportado poderia alimentar uma API de recomendação.

---

### 6️⃣ Encerramento
- Reforçar que tudo atende ao tema:
  - Requalificação profissional  
  - Futuro do trabalho  
  - IA e automação  
- E aos itens técnicos pedidos no trabalho.


---

# 👤 Integrantes

- RM556588 - Gabriel Yuji Suzuki
- RM97677 - Lucas Felix Vassiliades
- RM556972 - Gabriel Duarte Pinto