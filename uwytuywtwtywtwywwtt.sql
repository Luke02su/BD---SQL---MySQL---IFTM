select * from telefone_cliente;
select * from cliente;

DELIMITER !!
CREATE TRIGGER inserir_ AFTER INSERT
ON cliente
FOR EACH ROW
	BEGIN
		INSERT telefone_cliente (
        cpf_cli,
        telefone
		) VALUES (
        NEW.cpf,
        99999-9999
        );
	END !!
DELIMITER ;

drop trigger inserir_;

INSERT INTO cliente VALUES ('234dd33', 'Teste', 'Rua, 123', 'M', 'huhghg@ggf');

DELIMITER !!
CREATE TRIGGER deletar_ BEFORE DELETE
ON cliente
FOR EACH ROW
	BEGIN
		DELETE FROM telefone_cliente WHERE cpf_cli = OLD.cpf;
    END !!
DELIMITER ;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM cliente WHERE cpf = '234dd33';


Crie uma trigger para inserir na tabela telefone_cliente com um valor padrão de telefone depois
de inserir na tabela cliente algum registro

2. Crie uma trigger para que uma vez que seja deletado o cliente, seja deletado também o registro
na tabela telefone_cliente