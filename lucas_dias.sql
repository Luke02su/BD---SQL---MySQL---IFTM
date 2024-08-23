CREATE DATABASE Imobiliaria;
USE Imobiliaria;

CREATE TABLE Imoveis (
ImovelID INT AUTO_INCREMENT PRIMARY KEY,
Endereco VARCHAR(255) NOT NULL,
Valor DECIMAL(10, 2) NOT NULL,
Status ENUM('Disponível', 'Reservado', 'Vendido') DEFAULT 'Disponível'
);

CREATE TABLE Corretores (
CorretorID INT AUTO_INCREMENT PRIMARY KEY,
Nome VARCHAR(255) NOT NULL
);

CREATE TABLE Vendas (
VendaID INT AUTO_INCREMENT PRIMARY KEY,
ImovelID INT,
CorretorID INT,
Valor DECIMAL(10, 2),
DataVenda DATE,
FOREIGN KEY (ImovelID) REFERENCES Imoveis(ImovelID),
FOREIGN KEY (CorretorID) REFERENCES Corretores(CorretorID)
);

INSERT INTO Imoveis (Endereco, Valor, Status) VALUES
('Rua das Flores, 123', 250000.00, 'Disponível'),
('Avenida Central, 456', 350000.00, 'Disponível'),
('Rua das Acácias, 789', 300000.00, 'Disponível'),
('Rua do Comércio, 101', 450000.00, 'Vendido'),
('Avenida Brasil, 202', 500000.00, 'Disponível'),
('Praça da Liberdade, 303', 550000.00, 'Vendido');

INSERT INTO Corretores (Nome) VALUES
('Carlos Almeida'),
('Lucia Pereira'),
('Roberto Santos'),
('Juliana Martins'),
('Eduardo Costa');

INSERT INTO Vendas (ImovelID, CorretorID, Valor, DataVenda) VALUES
(1, 1, 250000.00, '2024-07-10'),
(2, 2, 350000.00, '2024-07-15'),
(3, 3, 280000.00, '2024-07-20'),
(4, 4, 450000.00, '2024-07-25'),
(5, 5, 490000.00, '2024-07-28');

-- SELECT * FROM imoveis;
-- SELECT * FROM corretores;
-- SELECT * FROM vendas;

/*1. Crie uma procedure que gere um relatório com o valor total das comissões de vendas para cada corretor a partir de uma
-- data passada como parâmetro para a procedure. O valor da comissão é de 5% o valor de venda.*/

DELIMITER //
CREATE PROCEDURE proc_gerar_relatorio (IN data_passada DATE)
BEGIN
	SELECT v.corretorID, c.nome, v.imovelID, v.valor AS vendaImovel, (v.valor + (v.valor * 0.05)) AS comissaoVenda, v.datavenda
    FROM vendas v
    INNER JOIN corretores c
    ON c.corretorID = v.corretorID
    WHERE datavenda = data_passada;
END//
DELIMITER ;

-- CALL proc_gerar_relatorio('2024-07-10');

/*Crie um trigger que ajuste automaticamente o status de um imóvel para "Vendido" ou para “Reservado” na tabela de
imóveis, quando uma venda é registrada na tabela de transações. O imóvel será “reservado” quando o valor inserido na
tabela de vendas é menor que o valor do imóvel na tabela de imóveis.*/

DELIMITER //
CREATE TRIGGER trg_status AFTER INSERT 
ON vendas
FOR EACH ROW 
BEGIN
    DECLARE imovel_valor DOUBLE;
    
    SELECT valor INTO imovel_valor
    FROM imoveis
    WHERE imovelID = NEW.imovelID;
    
    IF NEW.valor >= imovel_valor THEN
        UPDATE imoveis 
        SET Status = 'Vendido' 
        WHERE imovelID = NEW.imovelID;
    ELSE
        UPDATE imoveis 
        SET Status = 'Reservado' 
        WHERE imovelID = NEW.imovelID;
    END IF;
END//
DELIMITER ;

/*INSERT INTO Vendas (ImovelID, CorretorID, valor, DataVenda) VALUES
(1, 1, 500000.00, '2024-07-11'),
(2, 3, 5000, '2024-07-12'),
(3, 4, 300000.01, '2024-07-13'),
(5, 5, 400000.01, '2024-07-14');*/

/*Crie um usuário chamado “secretaria”. Este usuário tem permissões para visualizar relatórios de vendas, ou seja,
executar a procedure. Além disso ela poderá inserir, remover, atualizar e excluir imóveis, mas não poderá alterar nada de
vendas e nem de corretores.*/

CREATE USER 'secretaria'@'%' IDENTIFIED BY '123';

GRANT EXECUTE
ON PROCEDURE imobiliaria.proc_gerar_relatorio
TO 'secretaria'@'%';

GRANT INSERT, DROP, UPDATE, DELETE
ON imobiliaria.imoveis
TO 'secretaria'@'%';

-- SHOW GRANTS FOR 'secretaria'@'%';

-- DROP SCHEMA imobiliaria;