alter table cliente add column email varchar(30);
select * from cliente;

select nome, cpf, endereco from cliente where nome like "C%";

alter table conta drop foreign key fk_num_agencia;
alter table conta add foreign key fk_num_agencia(num_agencia) references agencia(numero_agencia) on update cascade on delete restrict;
update agencia set numero_agencia = "6342" where numero_agencia = "0562";
select * from conta;
select * from agencia;

update cliente set email = "caetanolima@gmail.com" where cpf = "666.777.888-99";
select * from cliente;

update conta set saldo = '3879.12' * 1.10 where num_conta = "23584-7";
select * from conta;

insert into agencia values ('1333', '1', 'Rua João José da Silva, 486');
select * from agencia;

select numero_agencia, endereco from agencia where cod_banco = 1; -- ou
select numero_agencia, endereco from agencia inner join banco on cod_banco = banco.codigo; -- ideal

select * from cliente where sexo = 'M';

alter table historico drop foreign key fk_num_conta_hist;
alter table historico add foreign key fk_num_conta_hist(num_conta_historico) references conta(num_conta) on update restrict on delete cascade;
delete from conta where num_conta = '86340-2'; -- delete from para apagar todas as tuplas
select * from historico;
select * from conta;

