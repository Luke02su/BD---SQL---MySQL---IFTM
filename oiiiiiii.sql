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
    id_func

);


