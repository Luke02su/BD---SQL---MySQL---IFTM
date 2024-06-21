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
    date_fim DATE,
    
    INDEX idx_id_aluno (id_aluno),
    INDEX idx_id_curso (id_curso),
    
    CONSTRAINT fk_id_aluno FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_id_curso FOREIGN KEY (id_curso) REFERENCES curso(id_curso) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE matricula_disciplina (
	id_matricula_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    id_matricula INT NOT NULL,
    id_disciplina INT NOT NULL,
    nota DEC(4,2) NOT NULL,
	
    INDEX idx_id_matricula (id_matricula),
    INDEX idx_id_disciplina (id_disciplina),
    
    CONSTRAINT fk_id_matricula FOREIGN KEY (id_matricula) REFERENCES matricula(id_matricula) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_id_disciplina2 FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina) ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- DML 

INSERT INTO aluno (nome, cpf, data_nascimento, sexo)
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



