create database conta;
use conta;

create table cliente (
	cpf varchar(14) not null primary key,
    nome varchar(45) not null,
    endereco varchar(100),
    sexo char(1)
);

create table banco (
	codigo int not null auto_increment primary key,
    nome varchar(45)
);

create table telefone_cliente (
	cpf_cli varchar(14) not null,
    telefone varchar(20) not null,
    
    foreign key fk_cpf_cli(cpf_cli) references cliente(cpf),
    
    constraint pk_telefone_cliente primary key telefone_cliente (cpf_cli, telefone)
);

create table conta (
	num_conta varchar(7) not null primary key,
    saldo float not null,
    tipo_conta int,
    num_agencia int not null,
	
    foreign key fk_num_agencia(num_agencia) references agencia(numero_agencia)
);

create table agencia (
	numero_agencia int not null auto_increment,
    cod_banco int not null,
    endereco varchar(100),
    
    foreign key fk_cod_banco(cod_banco) references banco(codigo),
    
    constraint pk_agencia primary key agencia (numero_agencia, cod_banco)
);

create table historico (
	cpf_cliente varchar(14) not null,
    num_conta_historico varchar(7) not null,
	data_inicio date,
    
    foreign key fk_cpf_cli_hist(cpf_cliente) references cliente(cpf),
    foreign key fk_num_conta_hist(num_conta_historico) references conta(num_conta),
    
    constraint pk_historico primary key historico (cpf_cliente, num_conta_historico)
);

-- ligacao continua: estrangeira e primaria viram chave composta;
-- ligacao tracejada: sem chave composta