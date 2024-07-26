-- 1. Crie um usuário my_user1;
CREATE USER my_user1 IDENTIFIED BY 'user1';

-- 2. Crie um usuário my_admin;
CREATE USER my_admin IDENTIFIED BY 'admin';

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

-- 4. Conceda acesso total para o usuário my_admin ao banco bd1.

GRANT ALL 
ON bd1.*
TO my_admin;

-- 5. Conceda apenas select, insert, delete e update para o usuário my_user no bd1.

GRANT SELECT, INSERT, DELETE, UPDATE 
ON bd1.*
TO my_user1;

-- 6. Visualize as permissões dadas aos usuários.

SHOW GRANTS FOR my_admin;
SHOW GRANTS FOR my_user1;

-- 7. Retire todas as permissões do usuário my_user.

REVOKE ALL PRIVILEGES
ON *.*
FROM my_user1;

-- 8. Crie uma nova conexão com o usuário my_user e use o comando show tables;

SELECT USER(); 
SHOW DATABASES;
USE bd1;
SHOW TABLES;

-- 9. Tente fazer uma operação de update usando o usuário my_user.



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

CREATE USER test_user1 IDENTIFIED BY '123';
CREATE USER test_user2 IDENTIFIED BY '321';

GRANT papelAdmin
TO test_user1;

GRANT papelDev
TO test_user2;



SELECT USER();
SHOW GRANTS FOR my_admin;
SHOW GRANTS FOR my_user1;
SHOW GRANTS FOR CURRENT_USER();


idengifei by junto hgrant não funciona mais