/*1. Dado uma taxa e um identificador do funcionário, crie um procedure que aplique a taxa
informada no salário do funcionário.*/

SELECT * FROM funcionario;

DELIMITER //
CREATE PROCEDURE proc_taxa_salario_funcionario (IN taxa_salario DOUBLE, IN id_funcionario INT)
BEGIN
		UPDATE funcionario SET Salario = Salario * taxa_salario WHERE ID_Func = id_funcionario;
END//
DELIMITER ;

CALL proc_taxa_salario_funcionario (1.10, 1);

/*2. Crie uma tabela chamada hora_extra. Essa tabela deverá ter o identificador do funcionário e
campo para guardar quantas horas foram excedidas de um funcionário na jornada semanal.
Crie uma trigger que, ao ser adicionado um registro na tabela “trabalha” no banco, ela chamará
uma procedure que calcula a soma do número de horas trabalhadas em todos os projetos de um
funcionário. Caso a carga horária seja maior que 40, a trigger insere o valor excedente na tabela
de hora_extra.*/

CREATE TABLE hora_extra (
	id_hora_extra INT AUTO_INCREMENT PRIMARY KEY,
    id_func INT NOT NULL,
	horas_excedidas INT NOT NULL
);

SELECT * FROM hora_extra;

DELIMITER $$
CREATE PROCEDURE proc_hora_extra (IN id_funcionario INT, IN numeroHoras DOUBLE, OUT totalHoras DOUBLE)
BEGIN
	SELECT SUM(t.NumHoras) INTO totalHoras
	FROM trabalha t
    WHERE t.ID_Func = id_funcionario;
END$$
DELIMITER ;

DROP PROCEDURE proc_hora_extra;

DELIMITER %%
CREATE TRIGGER trg_hora_extra AFTER INSERT
ON trabalha
FOR EACH ROW
	BEGIN
		IF @totalhoras > 40.00 THEN
			CALL proc_hora_extra(NEW.ID_Func, NEW.NumHoras, @totalHoras);
            SET @excedente = @totalHoras - 40;
			INSERT INTO hora_extra (id_hora_extra, id_func, horas_excedidas) VALUES (NULL, NEW.ID_Func, @excedente);
		END IF;
    END%%
DELIMITER ;

DROP TRIGGER trg_hora_extra;

INSERT INTO trabalha VALUES (8, 1, 41);
INSERT INTO trabalha VALUES (8, 2, 2);
INSERT INTO trabalha VALUES (8, 3, 2);
INSERT INTO trabalha VALUES (8, 10, 2);
INSERT INTO trabalha VALUES (8, 20, 11);
INSERT INTO trabalha VALUES (8, 30, 2);