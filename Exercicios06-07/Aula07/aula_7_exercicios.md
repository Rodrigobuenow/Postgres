# Exercícios

## Exercício 1
Encontre o preço médio arredondado com 2 casas decimais dos produtos em cada uma das categorias.
```sql
   SELECT
    c.category_id,
    c.category_name,
    ROUND(AVG(p.price), 2) AS avg_price
FROM
    categories c
LEFT JOIN
    products p ON c.category_id = p.category_id
GROUP BY
    c.category_id, c.category_name;
```
## Exercício 2
Busque todas as informações sobre os produtos que nunca foram comprados (inclusive a descrição da categoria e todos os dados do fornecedor).
```sql
SELECT
    p.*,
    c.category_name,
    s.supplier_name
FROM
    products p
JOIN
    categories c ON p.category_id = c.category_id
JOIN
    suppliers s ON p.supplier_id = s.supplier_id
LEFT JOIN
    order_items od ON p.product_id = od.product_id
WHERE
    od.product_id IS NULL;
```
## Exercício 3
Encontre os top 5 clientes que mais gastaram dinheiro em compras, exibindo o nome completo e o valor gasto formatado como dinheiro. 

Dica: Formatar como dinheiro pode ser feito assim usando o comando `CAST(xxxxxx AS MONEY)`, como em `SELECT CAST(1000 AS MONEY)`
```sql
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    '$' || TO_CHAR(SUM(o.total_amount), '999,999,999.99') AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY SUM(o.total_amount) DESC
LIMIT 5;
```

## Exercício 4

Dado o modelo textual/lógico abaixo, escreva os comandos SQL para criar as tabelas, suas restrições e relações quando aplicáveis e insira pelo menos 5 registros em cada uma das tabelas.

    alunos(nome, numero_aluno, tipo_aluno, curso)

    disciplinas(nome_disciplina, numero_disciplina, creditos, departamento)

    turmas(identificacao_turma, numero_disciplina, semestre, ano, professor)

    pre_requisitos(numero_disciplina, numero_pre_requisito)

    historico_escolar(numero_aluno, identificacao_turma, nota)

Feito, isso, execute o comando SQL abaixo, para inserir mais registros

```sql
INSERT INTO alunos
(nome, numero_aluno, tipo_aluno, curso)
VALUES('Silva', 17, 1, 'CC');

INSERT INTO alunos
(nome, numero_aluno, tipo_aluno, curso)
VALUES('Braga', 8, 2, 'CC');

INSERT INTO disciplinas
(numero_disciplina, creditos, departamento, nome_disciplina)
VALUES('CC1310', 4, 'CC', 'Introd. à ciência da computação');

INSERT INTO disciplinas
(numero_disciplina, creditos, departamento, nome_disciplina)
VALUES('CC3320', 4, 'CC', 'Estruturas de dados');

INSERT INTO disciplinas
(numero_disciplina, creditos, departamento, nome_disciplina)
VALUES('MAT2410', 3, 'MAT', 'Matemática discreta');

INSERT INTO disciplinas
(numero_disciplina, creditos, departamento, nome_disciplina)
VALUES('CC3380', 3, 'CC', 'Banco de dados');

INSERT INTO turmas
(identificacao_turma, numero_disciplina, semestre, ano, professor)
VALUES(85, 'MAT2410', 'Segundo', 2007, 'Kleber');

INSERT INTO turmas
(identificacao_turma, numero_disciplina, semestre, ano, professor)
VALUES(92, 'CC1310', 'Segundo', 2007, 'Anderson');

INSERT INTO turmas
(identificacao_turma, numero_disciplina, semestre, ano, professor)
VALUES(102, 'CC3320', 'Primeiro', 2008, 'Carlos');

INSERT INTO turmas
(identificacao_turma, numero_disciplina, semestre, ano, professor)
VALUES(112, 'MAT2410', 'Segundo', 2008, 'Chang');

INSERT INTO turmas
(identificacao_turma, numero_disciplina, semestre, ano, professor)
VALUES(119, 'CC1310', 'Segundo', 2008, 'Anderson');

INSERT INTO turmas
(identificacao_turma, numero_disciplina, semestre, ano, professor)
VALUES(135, 'CC3380', 'Segundo', 2008, 'Santos');

INSERT INTO historicos_escolares
(numero_aluno, identificacao_turma, nota)
VALUES(17, 112, 'B');

INSERT INTO historicos_escolares
(numero_aluno, identificacao_turma, nota)
VALUES(17, 119, 'C');

INSERT INTO historicos_escolares
(numero_aluno, identificacao_turma, nota)
VALUES(8, 85, 'A');

INSERT INTO historicos_escolares
(numero_aluno, identificacao_turma, nota)
VALUES(8, 92, 'A');

INSERT INTO historicos_escolares
(numero_aluno, identificacao_turma, nota)
VALUES(8, 102, 'B');

INSERT INTO historicos_escolares
(numero_aluno, identificacao_turma, nota)
VALUES(8, 135, 'A');

INSERT INTO pre_requisitos
(numero_disciplina, numero_pre_requisito)
VALUES('CC3380', 'CC3320');

INSERT INTO pre_requisitos
(numero_disciplina, numero_pre_requisito)
VALUES('CC3380', 'MAT2410');

INSERT INTO pre_requisitos
(numero_disciplina, numero_pre_requisito)
VALUES('CC3320', 'CC1310');
```

Executar as seguintes consultas:

- Recuperar uma lista de todas as disciplinas e notas de Silva.
- Listar os nomes dos alunos que realizaram a disciplina Banco de dados oferecida no segundo semestre de 2008 e suas notas nessa turma.
- Listar os pré-requisitos do curso de Banco de dados.


Executar as seguintes atualizações no banco de dados

- Alterar o tipo de aluno de Silva para segundo ano.
- Criar outra turma para a disciplina Banco de dados para este semestre.
- Inserir uma nota A para Silva na turma Banco de dados do último semestre.


&nbsp;

## Resposta

```sql
-- create tables
CREATE TABLE alunos (
    nome VARCHAR(250),
    numero_aluno INT PRIMARY KEY,
    tipo_aluno INT,
    curso VARCHAR(250)
);

CREATE TABLE disciplinas (
    numero_disciplina VARCHAR(250) PRIMARY KEY,
    creditos INT,
    departamento VARCHAR(250),
    nome_disciplina VARCHAR(250)
);

CREATE TABLE turmas (
    identificacao_turma INT PRIMARY KEY,
    numero_disciplina VARCHAR(20),
    semestre VARCHAR(20),
    ano INT,
    professor VARCHAR(200)
);

CREATE TABLE pre_requisitos (
    numero_disciplina VARCHAR(20),
    numero_pre_requisito VARCHAR(20),
    PRIMARY KEY (numero_disciplina, numero_pre_requisito)
);

CREATE TABLE historico_escolar (
    numero_aluno INT,
    identificacao_turma INT,
    nota VARCHAR(1),
    PRIMARY KEY (numero_aluno, identificacao_turma)
);


--Recuperar uma lista de todas as disciplinas e notas de Silva.
SELECT d.nome_disciplina, he.nota
FROM alunos a
JOIN historico_escolar he ON a.numero_aluno = he.numero_aluno
JOIN turmas t ON he.identificacao_turma = t.identificacao_turma
JOIN disciplinas d ON t.numero_disciplina = d.numero_disciplina
WHERE a.nome = 'Silva';

--Listar os nomes dos alunos que realizaram a disciplina Banco de dados oferecida no segundo semestre de 2008 e suas notas nessa turma.
SELECT a.nome, he.nota
FROM alunos a
JOIN historico_escolar he ON a.numero_aluno = he.numero_aluno
JOIN turmas t ON he.identificacao_turma = t.identificacao_turma
JOIN disciplinas d ON t.numero_disciplina = d.numero_disciplina
WHERE d.nome_disciplina = 'Banco de dados' AND t.semestre = 'Segundo' AND t.ano = 2008;

	
--Listar os pré-requisitos do curso de Banco de dados.
SELECT p.numero_disciplina, p.numero_pre_requisito, d.nome_disciplina AS disciplina, dp.nome_disciplina AS pre_requisito
FROM pre_requisitos p
JOIN disciplinas d ON p.numero_disciplina = d.numero_disciplina
JOIN disciplinas dp ON p.numero_pre_requisito = dp.numero_disciplina
WHERE d.nome_disciplina = 'Banco de dados';


--Executar as seguintes atualizações no banco de dados
--Alterar o tipo de aluno de Silva para segundo ano.
UPDATE alunos SET tipo_aluno = 2 WHERE nome = 'Silva';

--Criar outra turma para a disciplina Banco de dados para este semestre.
INSERT INTO turmas (identificacao_turma, numero_disciplina, semestre, ano, professor)
VALUES (150, 'CC3380', 'Terceiro', 2023, 'NovoProfessor');

--Inserir uma nota A para Silva na turma Banco de dados do último semestre.
UPDATE historico_escolar
SET nota = 'A'
WHERE numero_aluno = 17
AND identificacao_turma = (SELECT identificacao_turma FROM turmas WHERE numero_disciplina = 'CC3380' AND semestre = 'Terceiro' AND ano = 2023);

```

&nbsp;