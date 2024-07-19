-- DDL

CREATE DATABASE conta;
USE conta;

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

-- DML

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

/*1. Crie uma trigger para inserir na tabela telefone_cliente com um valor padrão de telefone depois
de inserir na tabela cliente algum registro*/

DELIMITER &&
CREATE TRIGGER trg_inserir_cliente AFTER INSERT
ON cliente
FOR EACH ROW
	BEGIN
		INSERT telefone_cliente (cpf_cli, telefone) VALUES (NEW.cpf, '(99)9999-9999');
	END &&
DELIMITER ;

INSERT INTO cliente VALUES ('150.975.886-06', 'Lucas Samuel', 'Rua, Adélio Furtado', 'M');

SELECT * FROM cliente;
SELECT * FROM telefone_cliente;

/*2. Crie uma trigger para que uma vez que seja deletado o cliente, seja deletado também o registro
na tabela telefone_cliente*/

DELIMITER !!
CREATE TRIGGER trg_deletar_cliente BEFORE DELETE
ON cliente
FOR EACH ROW
	BEGIN
		DELETE FROM telefone_cliente WHERE cpf_cli = OLD.cpf;
    END !!
DELIMITER ;

DELETE FROM cliente WHERE cpf = '150.975.886-06';

SELECT * FROM cliente;
SELECT * FROM telefone_cliente;

/*3. Adicione ao modelo uma tabclienteela de log (registros). Sempre que os dados de uma conta forem
atualizados será gerado um registro nessa tabela, os dados antes e depois da atualização. Crie
um campo timestamp para armazenar a operação.*/

CREATE TABLE log_update_conta (
	id_update INT AUTO_INCREMENT PRIMARY KEY,
	num_conta_anterior VARCHAR(7) NOT NULL,
    num_conta_atual VARCHAR(7) NOT NULL,
    saldo_anterior FLOAT NOT NULL,
    saldo_atual FLOAT NOT NULL,
    tipo_conta_anterior INT,
    tipo_conta_atual INT,
    num_agencia_anterior INT NOT NULL,
	num_agencia_atual INT NOT NULL,
    horario_update TIMESTAMP
);

DELIMITER &&
CREATE TRIGGER trg_update_conta AFTER UPDATE
ON conta
FOR EACH ROW
	BEGIN
		INSERT INTO log_update_conta 
        (num_conta_anterior, num_conta_atual, saldo_anterior, saldo_atual, tipo_conta_anterior, tipo_conta_atual, num_agencia_anterior, num_agencia_atual, horario_update) 
        VALUES
        (OLD.num_conta, NEW.num_conta, OLD.saldo, NEW.saldo, OLD.tipo_conta, NEW.tipo_conta, OLD.num_agencia, NEW.num_agencia, NOW()); -- ideal guardar apenas o antigo log, pois já tem o atual guardado em cliente
    END &&
DELIMITER ;

SET FOREIGN_KEY_CHECKS = 0;
SET SQL_SAFE_UPDATES = 0;

UPDATE conta SET num_conta = '75839-6' WHERE num_conta = '86340-2';
UPDATE conta SET saldo = 756 WHERE num_conta = '75839-6';
UPDATE conta SET tipo_conta = 3 WHERE num_conta = '75839-6';
UPDATE conta SET num_agencia = 562 WHERE num_conta = '75839-6';

SET FOREIGN_KEY_CHECKS = 1;
SET SQL_SAFE_UPDATES = 1;

SELECT * FROM agencia;
SELECT * FROM conta;
SELECT * FROM log_update_conta;

/*4. Crie uma view com o nome do cliente, nome do banco, endereço da agência, e número da
conta.*/

SELECT * FROM cliente;
SELECT * FROM historico;
SELECT * FROM conta;
SELECT * FROM agencia;
SELECT * FROM banco;

CREATE VIEW dados_cliente
AS
SELECT c.nome AS nome_cliente, b.nome AS nome_banco, a.endereco, cc.num_conta
FROM cliente c
INNER JOIN historico h
ON c.cpf = h.cpf_cliente
INNER JOIN conta cc
ON h.num_conta_historico = cc.num_conta
INNER JOIN agencia a
ON cc.num_agencia = a.numero_agencia
INNER JOIN banco b
ON a.cod_banco = b.codigo;

SHOW CREATE VIEW dados_cliente;
SELECT * FROM dados_cliente;
