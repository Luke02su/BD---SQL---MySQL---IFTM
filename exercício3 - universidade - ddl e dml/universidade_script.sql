-- DDL

CREATE DATABASE universidade;
USE universidade;

CREATE TABLE aluno (
	id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
	cpf VARCHAR(14) NOT NULL,
    data_nascimento DATE NOT NULL,
    sexo CHAR(1) NOT NULL
);

CREATE TABLE curso (
	id_curso INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(45) NOT NULL,
	carga_horaria INT NOT NULL
);

CREATE TABLE disciplina (
	id_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
	carga_horaria INT NOT NULL
);

CREATE TABLE matricula (
	id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_curso INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    
    INDEX idx_id_aluno (id_aluno),
    INDEX idx_id_curso (id_curso),
    
    CONSTRAINT fk_id_aluno FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_id_curso FOREIGN KEY (id_curso) REFERENCES curso(id_curso) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE matricula_disciplina (
	id_matricula_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    id_matricula INT NOT NULL,
    id_disciplina INT NOT NULL,
    nota DEC(4, 2) NOT NULL,
	
    INDEX idx_id_matricula (id_matricula),
    INDEX idx_id_disciplina (id_disciplina),
    
    CONSTRAINT fk_id_matricula FOREIGN KEY (id_matricula) REFERENCES matricula(id_matricula) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_id_disciplina FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina) ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- DML 

INSERT INTO aluno (nome, cpf, data_nascimento, sexo) -- Neste INSERT, assim como nos demais, poderia-se ocultar tais atributos e adicionar apenas VALUES. Exemplo: (default, 'João da Silva', '123.456.789-00', '1990-01-01', 'M');
VALUES
('João da Silva', '123.456.789-00', '1990-01-01', 'M'),
('Maria da Costa', '987.654.321-00', '1991-02-02', 'F'),
('Pedro dos Santos', '098.765.432-10', '1992-03-03', 'M');

SELECT * FROM aluno;

INSERT INTO curso (nome, carga_horaria)
VALUES
('Ciência da Computação', 2400),
('Engenharia de Software', 2800),
('Administração', 2200);

SELECT * FROM curso;

INSERT INTO matricula (id_aluno, id_curso, data_inicio, data_fim)
VALUES
(1, 1, '2023-08-01', NULL),
(2, 2, '2023-08-01', NULL),
(3, 3, '2023-08-01', NULL);

SELECT * FROM matricula;

INSERT INTO disciplina (nome, carga_horaria)
VALUES
('Algoritmos e Estruturas de Dados', 60),
('Programação Orientada a Objetos', 60),
('Bancos de Dados', 60);

SELECT * FROM disciplina;

INSERT INTO matricula_disciplina (id_matricula, id_disciplina, nota)
VALUES
(1, 1, 8.0),
(2, 1, 9.0),
(3, 1, 7.5),
(1, 2, 6.0),
(2, 2, 4.0),
(3, 2, 7.5),
(1, 3, 7.0),
(2, 3, 2.0),
(3, 3, 10);

SELECT * FROM matricula_disciplina;

-- Exercícios

-- 1. Liste o nome, o CPF e a data de nascimento de todos os alunos.

SELECT nome, CPF, data_nascimento
FROM aluno;

-- 2. Liste o nome, o CPF e o sexo de todos os alunos nascidos após 1990.

SELECT nome, CPF, sexo
FROM aluno
WHERE data_nascimento > '1990-01-01';

-- 3. Liste o nome do curso com a maior carga horária.

SELECT nome
FROM curso
WHERE carga_horaria = (
    SELECT MAX(carga_horaria) 
    FROM curso
);

-- 4. Excluir todas as disciplinas com a carga horária inferior a 20 horas:

SET SQL_SAFE_UPDATES = 0;
DELETE FROM disciplina 
WHERE carga_horaria < 20;
-- OU
-- DELETE FROM disciplina 
-- WHERE carga_horaria < 20 
-- AND id_disciplina != 0;

-- 5. Liste o ID do aluno com a menor nota na disciplina de Programação Orientada a Objetos.

SELECT id_aluno
FROM matricula m
INNER JOIN matricula_disciplina md 
ON m.id_matricula = md.id_matricula
WHERE nota = (
	SELECT MIN(nota)
    FROM matricula_disciplina
);

-- 6. Liste os IDS de todos os alunos que estão matriculados em um curso com carga horária superior a 2400 horas:

SELECT m.id_aluno
FROM matricula m
INNER JOIN curso c 
ON m.id_curso = c.id_curso
WHERE carga_horaria > 2400;

-- 7. Liste o nome, o nome do curso e a carga horária do curso de cada aluno.

SELECT a.nome, c.nome, c.carga_horaria
FROM aluno a
INNER JOIN matricula m
ON a.id_aluno = m.id_aluno
INNER JOIN curso c
ON c.id_curso = m.id_curso;

-- 8. Atualizar a carga horária do curso de Administração para 300 horas:

SET SQL_SAFE_UPDATES = 0;
UPDATE curso 
SET carga_horaria = 300
WHERE nome = 'Administração';
-- OU 
-- UPDATE curso 
-- SET carga_horaria = 300
-- WHERE nome = 'Administração' AND id_curso != 0;
