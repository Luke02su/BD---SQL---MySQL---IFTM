-- 1. Crie um usuário my_user1;
CREATE USER 'my_user1'@'localhost' IDENTIFIED BY 'user1';

-- 2. Crie um usuário my_admin;
CREATE USER 'my_admin'@'localhost' IDENTIFIED BY 'admin';

-- 3. Crie/use dois bancos de dados bd1 e db2 quaisquer. Pode ser bancos de outros exercícios. Crie algumas tabelas aleatoriamente.

CREATE DATABASE bd1;
USE bd1;

CREATE TABLE cliente (
	cpf VARCHAR(14) PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    endereco varchar(100),
    sexo char(1)
);

CREATE TABLE banco (
	codigo INT PRIMARY KEY,
    nome VARCHAR(45)
);

CREATE TABLE telefone_cliente (
	cpf_cli VARCHAR(14) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    
    INDEX idx_cpf_cli (cpf_cli),
    
    CONSTRAINT fk_cpf_cli FOREIGN KEY (cpf_cli) REFERENCES cliente(cpf),
    CONSTRAINT pk_telefone_cliente PRIMARY KEY (cpf_cli, telefone)
);

CREATE TABLE agencia (
	numero_agencia INT NOT NULL,
    cod_banco INT NOT NULL,
    endereco VARCHAR(100),
    
    INDEX idx_cod_banco (cod_banco),
    
    CONSTRAINT fk_cod_banco FOREIGN KEY (cod_banco) REFERENCES banco(codigo),
    CONSTRAINT pk_agencia PRIMARY KEY (numero_agencia, cod_banco)
);

CREATE TABLE conta (
	num_conta VARCHAR(7) NOT NULL PRIMARY KEY,
    saldo FLOAT NOT NULL,
    tipo_conta INT,
    num_agencia INT NOT NULL,
	
    INDEX idx_num_agencia (num_agencia),
    
    CONSTRAINT fk_num_agencia FOREIGN KEY (num_agencia) REFERENCES agencia(numero_agencia)
);

CREATE TABLE historico (
	cpf_cliente VARCHAR(14) NOT NULL,
    num_conta_historico VARCHAR(7) NOT NULL,
	data_inicio DATE,
    
    INDEX idx_cpf_cliente (cpf_cliente),
    INDEX idx_num_conta_historico (num_conta_historico),
    
    CONSTRAINT fk_cpf_cli_hist FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf),
    CONSTRAINT fk_num_conta_hist FOREIGN KEY (num_conta_historico) REFERENCES conta(num_conta),
    CONSTRAINT pk_historico PRIMARY KEY (cpf_cliente, num_conta_historico)
);

INSERT INTO banco VALUES (1, 'Banco do Brasil');
INSERT INTO banco VALUES (4, "CEF");

SELECT * FROM banco;

INSERT INTO agencia VALUES (0562, 4, 'Rua Joaquim Teixeira Alves, 1555');
INSERT INTO agencia VALUES (3153, 1, "Av. Marcelino Pires, 1960");

SELECT * FROM agencia;

INSERT INTO cliente VALUES ("111.222.333-44", "Jeniffer B Souza", "Rua Cuiabá, 1050", 'F');
INSERT INTO cliente VALUES ("666.777.888-99", "Caetano K Lima", "Rua Ivinhema, 879", 'M');
INSERT INTO cliente VALUES ("555.444.777-33", "Silvia Macedo", "Rua Estados Unidos, 735", 'F');

SELECT * FROM cliente;

INSERT INTO conta VALUES ("86340-2", 763.05, 2, 3153);
INSERT INTO conta VALUES ("23584-7", 3879.12, 1, 0562);

SELECT * FROM conta;

INSERT INTO historico VALUES ("111.222.333-44", "23584-7", "1997-12-17");
INSERT INTO historico VALUES ("666.777.888-99", "23584-7", "1997-12-12");
INSERT INTO historico VALUES ("555.444.777-33", "86340-2", "2010-11-29");

SELECT * FROM historico;

INSERT INTO telefone_cliente VALUES ("111.222.333-44", "(67)3422-7788");
INSERT INTO telefone_cliente VALUES ("666.777.888-99", "(67)3423-9900");
INSERT INTO telefone_cliente VALUES ("666.777.888-99", "(67)8121-8833");

SELECT * FROM telefone_cliente; 

CREATE DATABASE bd2;
USE bd2;

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

-- 4. Conceda acesso total para o usuário my_admin ao banco bd1.

GRANT ALL -- em versões mais antigas do MySQL, poderia criar o user no momento de dar os privilégios
ON bd1.*
TO my_admin@localhost;
-- IDENTIFIED BY 'demonstracao';

-- 5. Conceda apenas select, insert, delete e update para o usuário my_user no bd1.

GRANT SELECT, INSERT, DELETE, UPDATE 
ON bd1.*
TO my_user1@localhost;

-- 6. Visualize as permissões dadas aos usuários.

SHOW GRANTS FOR 'my_admin'@'localhost'; -- poderia não usar aspas simples, daria no mesmo
SHOW GRANTS FOR 'my_user1'@'localhost';

-- 7. Retire todas as permissões do usuário my_user.

REVOKE ALL PRIVILEGES
ON *.*
FROM my_user1@localhost;

-- 8. Crie uma nova conexão com o usuário my_user e use o comando show tables;
-- Como os privilégios do usuário my_user1@localhost foram removidos, então, ao criar uma nova conexão (sessão) com tal usuário, não haveria acesso a nenhuma base de dados.
-- Comandos abaixo utilizados na conexão após retornar os privilégios ao usuário my_user para fins de estudo:

SELECT USER();
SHOW DATABASES; -- databses que determinado user() possui acesso
USE bd1;
SHOW TABLES;

-- 9. Tente fazer uma operação de update usando o usuário my_user.
-- Como dito anteriormente, não é possível pois o my_user1 teve os privilégios revogados, mas, ao retornar, conseguimos executar tal comando em sua determinada conexão:

SELECT * FROM cliente;
UPDATE cliente SET endereco = 'Rua João da Cunha, 1923' WHERE cpf = '111.222.333-44';

-- 10. Crie um papel chamado papelAdmin e outro papelDev

CREATE ROLE papelAdmin;
CREATE ROLE papelDev;

-- 11. Conceda ao papel papelAdmin todos os privilégios e para papelDev apenas as operações select, insert, update e delete.

GRANT ALL 
ON db1.*
TO papelAdmin;
GRANT ALL 
ON db2.*
TO papelAdmin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON db1.*
TO papelDev;
GRANT SELECT, INSERT, UPDATE, DELETE
ON db2.*
TO papelDev;

-- 12. Crie dois usuários e atribuía a cada um, um dos papéis criados. Faça teste com os dois usuários criados.

CREATE USER test_user1@localhost IDENTIFIED BY '123';
CREATE USER test_user2@localhost IDENTIFIED BY '321';

GRANT papelAdmin
TO test_user1@localhost;
SET DEFAULT ROLE papelAdmin -- define como padrão o papel atribuído para que não ocorra erros no momento da sessão ao acessar os privilégios
TO test_user1@localhost;

GRANT papelDev
TO test_user2@localhost;
SET DEFAULT ROLE papelDev
TO test_user2@localhost;

SHOW GRANTS FOR test_user1@localhost;
SHOW GRANTS FOR test_user2@localhost;

-- Como os papéis dos dois users dão privilégios de SELECT, INSERT, UPDATE E DELETE, então eles funcionarão perfeitamente em uma conexão a parte.
-- Não daria, por exemplo, para usar um:
CREATE SCHEMA bd_teste; -- 17:58:06	CREATE SCHEMA dbteste1	Error Code: 1044. Access denied for user 'test_user1'@'localhost' to database 'dbteste1'	0.000 sec
