-- 1) Altere a tabela cliente e crie um novo atributo chamado e-mail para armazenar os emails dos clientes. 
alter table cliente add column email varchar(30);
select * from cliente;

-- 2) alter table conta drop foreign key fk_num_agencia;
select nome, cpf, endereco from cliente where nome like "C%"; -- não é case sensitive c% é igual C%

-- 3) Altere o número da agência 0562 para 6342.
alter table conta drop foreign key fk_num_agencia;
alter table conta add foreign key fk_num_agencia(num_agencia) references agencia(numero_agencia) on update cascade on delete restrict;
update agencia set numero_agencia = "6342" where numero_agencia = "0562";
select * from conta;
select * from agencia;

-- 4) Altere o registro do cliente Caetano K Lima acrescentando o email caetanolima@gmail.com.
update cliente set email = "caetanolima@gmail.com" where cpf = "666.777.888-99"; -- ou 
update cliente set email = "caetanolima@gmail.com" where nome = "Caetano K Lima"; -- não é o ideal atualizar pelo nome uma vez que pode existir outros nomes idênticos
select * from cliente;

-- 5) Conceda à conta 23584-7 um aumento de 10 por cento no saldo.
update conta set saldo = '3879.12' * 1.10 where num_conta = "23584-7"; -- update conta set saldo = saldo * 1.10 where num_conta = "23584-7";
select * from conta;

-- 6) Insira na tabela de Agência os seguintes dados:
-- 1) Numero: 1333
-- 2) Endereço: Rua João José da Silva, 486
-- 3) Banco do Brasil
insert into agencia values ('1333', '1', 'Rua João José da Silva, 486');
select * from agencia;

-- 7)Recupere o número e o endereço de todas as agências do Banco do Brasil. Use o código do banco fixo na condição do where.
select numero_agencia, endereco from agencia where cod_banco = 1; -- ou
select numero_agencia, endereco from agencia inner join banco on cod_banco = codigo; -- ideal

-- 8)Recupere todos os valores de atributo de qualquer cliente que é do sexo masculino.
select * from cliente where sexo = 'M'; -- poderia usar like (sexo like 'M');

-- 9)Exclua a conta 86340-2
alter table historico drop foreign key fk_num_conta_hist;
alter table historico add foreign key fk_num_conta_hist(num_conta_historico) references conta(num_conta) on update restrict on delete cascade;
delete from conta where num_conta = '86340-2'; -- delete from para apagar todas as tuplas
select * from historico;
select * from conta;

