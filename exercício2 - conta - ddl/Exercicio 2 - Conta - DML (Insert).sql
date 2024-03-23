insert into banco values (1, 'Banco do Brasil');
insert into banco (codigo, nome) values (4, "CEF");

select * from banco;

insert into agencia (numero_agencia, cod_banco, endereco) values (0562, 4, 'Rua Joaquim Teixeira Alves, 1555');
insert into agencia (numero_agencia, cod_banco, endereco) values (3153, 1, "Av. Marcelino Pires, 1960");

select * from agencia;

insert into cliente values ("111.222.333-44", "Jeniffer B Souza", "Rua Cuiabá, 1050", 'F');
insert into cliente values ("666.777.888-99", "Caetano K Lima", "Rua Ivinhema, 879", 'M');
insert into cliente values ("555.444.777-33", "Silvia Macedo", "Rua Estados Unidos, 735", 'F');

select * from cliente;

insert into conta values ("86340-2", 763.05, 2, 3153);
insert into conta values ("23584-7", 3879.12, 1, 0562);

select * from conta;

insert into historico values ("111.222.333-44", "23584-7", "1997-12-17");
insert into historico values ("666.777.888-99", "23584-7", "1997-12-12");
insert into historico values ("555.444.777-33", "86340-2", "2010-11-29");

-- update historico set data_inicio = "1997-12-17" where cpf_cliente = "111.222.333-44";
-- update historico set data_inicio = "1997-12-12" where cpf_cliente = "666.777.888-99"; -- date sem aspas não funciona (como na primeira vez que testei), só números int, double...
-- update historico set data_inicio = "2010-11-29" where cpf_cliente = "555.444.777-33";

select * from historico;

insert into telefone_cliente values ("111.222.333-44", "(67)3422-7788");
insert into telefone_cliente values ("666.777.888-99", "(67)3423-9900");
insert into telefone_cliente values ("666.777.888-99", "(67)8121-8833");

select * from telefone_cliente;

select * from cliente, conta, banco, agencia, historico, telefone_cliente; -- ideal usar join para filtrar pesquisas correlacionadas entre duas tabelas

truncate banco;
