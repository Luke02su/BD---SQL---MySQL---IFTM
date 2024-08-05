CREATE SCHEMA controle_interno_TI;
USE controle_interno_TI;

CREATE TABLE envio_equipamento (
	 id_equipamento INT AUTO_INCREMENT PRIMARY KEY, 
	 enviado BOOL NOT NULL,
	 modelo VARCHAR(45) NOT NULL
);

CREATE TABLE computador (
    id_equipamento INT NOT NULL,
	id_computador INT AUTO_INCREMENT PRIMARY KEY,
    enviado BOOL NOT NULL,
    modelo VARCHAR(45),
    processador VARCHAR(30),
    memoria VARCHAR(30),
    windows VARCHAR(30),
    armazenamento VARCHAR(30),
    formatacao BOOL NOT NULL,
    manutencao BOOL NOT NULL,
    
    INDEX idx_id_equipamento (id_equipamento),
    
    CONSTRAINT pk_id_equipamento FOREIGN KEY (id_equipamento) REFERENCES envio_equipamento(id_equipamento)
);