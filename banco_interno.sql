CREATE SCHEMA controle_equipamentos_TI;
USE controle_equipamentos_TI;

CREATE TABLE equipamento (
	 pk_equipamento INT AUTO_INCREMENT PRIMARY KEY, 
	 enviado BOOL NOT NULL,
	 modelo VARCHAR(45) NOT NULL
);

CREATE TABLE computador (
    fk_equipamento INT NOT NULL,
	pk_computador INT AUTO_INCREMENT PRIMARY KEY,
    processador VARCHAR(30),
    memoria VARCHAR(30),
    windows VARCHAR(30),
    armazenamento VARCHAR(30),
    formatacao BOOL NOT NULL,
    manutencao BOOL NOT NULL,
    
    INDEX idx_fk_equipamento (fk_equipamento),
    
    CONSTRAINT fk_equipamento_computador FOREIGN KEY (fk_equipamento) REFERENCES equipamento(pk_equipamento)
);

CREATE TABLE impressora (
	fk_equipamento INT NOT NULL,
	pk_impressora INT AUTO_INCREMENT PRIMARY KEY,
    revisao BOOL NOT NULL,
    
    INDEX idx_fk_equipamento (fk_equipamento),
    
    CONSTRAINT fk_impressora_equipamento FOREIGN KEY (fk_equipamento) REFERENCES equipamento(pk_equipamento) ON DELETE RESTRICT ON UPDATE RESTRICT
);


CREATE TABLE loja (
	pk_loja INT AUTO_INCREMENT PRIMARY KEY,
    cnpj INT UNIQUE NOT NULL,
    cidade VARCHAR(30) NOT NULL,
    telefone VARCHAR(20) NOT NULL
);

CREATE TABLE envio_equipamento (
	pk_envio INT AUTO_INCREMENT PRIMARY KEY,
	fk_equipamento INT NOT NULL,
    fk_loja INT NOT NULL,
    data_envio DATE NOT NULL,
    obervacao TEXT,
    
	INDEX idx_fk_equipamento (fk_equipamento),
	INDEX idx_fk_loja (fk_loja),
    
	CONSTRAINT fk_equipamento_envio FOREIGN KEY (fk_equipamento) REFERENCES equipamento(pk_equipamento) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_loja_envio FOREIGN KEY (fk_loja) REFERENCES loja(pk_loja) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE retorno_equipamento (
	pk_devolucao INT AUTO_INCREMENT PRIMARY KEY,
    fk_equipamento INT NOT NULL,
    fk_loja INT NOT NULL,
    data_retorno DATE,
    observacao TEXT,
    
	INDEX idx_fk_equipamento (fk_equipamento),
	INDEX idx_fk_loja (fk_loja),
    
	CONSTRAINT fk_equipamento_retorno FOREIGN KEY (fk_equipamento) REFERENCES equipamento(pk_equipamento) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_loja_retorno FOREIGN KEY (fk_loja) REFERENCES loja(pk_loja) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE VIEW view_equipamento_data_envio  AS (
	SELECT e.pk_equipamento, ee.fk_loja, e.modelo
	FROM equipamento e
    INNER JOIN envio_equipamento ee
    ON ee.fk_equipamento = e.pk_equipamento
);


CREATE VIEW view_equipamento_retorno_envio  AS (
	SELECT e.pk_equipamento, ee.fk_loja, e.modelo
	FROM equipamento e
    INNER JOIN envio_equipamento ee
    ON ee.fk_equipamento = e.pk_equipamento
);

CREATE VIEW equipamento_nao_enviado AS (
	SELECT 
	

);


equipamentos_descartados log
id_equipamento
observacao

TRIGGER descartado (
	before delete

)
;


