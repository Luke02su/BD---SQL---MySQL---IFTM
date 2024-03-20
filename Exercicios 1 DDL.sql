create table editora (
	cod_editora int not null auto_increment primary key,
    descricao varchar(45) not null,
    endereco varchar(45)
);

create table livro(
	cod_livro int not null auto_increment primary key, 
	isbn varchar(45) not null, 
	titulo varchar(45) not null, 
    autor varchar(45) not null, 
	num_edicao int, 
	preco float not null, 
	editora_cod_editora int not null, 
    
	foreign key fk_cod_editora(editora_cod_editora) 
	references editora(cod_editora) on update restrict on delete restrict
);

create table autor (
	cod_autor int not null auto_increment primary key,
    nome varchar(45) not null,
    sexo char,
    data_nascimento date not null
);

create table livro_autor (
	cod_livro int not null,
    cod_autor int not null,
    
	foreign key fk_cod_livro(cod_livro)
		references livro(cod_livro),
        
    foreign key fk_cod_autor(cod_autor)
		references  autor(cod_autor),
        
    constraint pk_la primary key livro_autor (cod_livro, cod_autor)
);

-- 1. Altere nome da coluna descrição da tabela editora para nome
alter table editora change descricao nome varchar(45) not null;

-- 2. Altere a coluna sexo para o tipo varchar(1);
alter table autor modify column sexo varchar(1);

-- 3. Adicione uma restrição onde a coluna isbn tenha valor único
alter table livro modify column isbn varchar(45) not null unique;

-- 4. Adicione uma restrição onde valor padrão do livro seja R$10,00
alter table livro modify column preco float not null default '10.00';

-- 5. Exclua a coluna num_edição da tabela livro e recrie com nome de edição
alter table livro drop column num_edicao;
alter table livro add column edicao int;

/* 6. Crie um nova tabela chamada grupo(id_grupo, nome). Adicione a tabela editora uma
coluna para essa tabela através de um chave estrangeira. Ajuste o comando para
que quando for deletada seja setado null na tabela editora. No caso do update seja
atualizado em cascata. */
create table grupo (
	id_grupo int not null auto_increment primary key,
    nome varchar(25) not null
);
alter table editora add column grupo_id_grupo int;
alter table editora add foreign key fk_grupo_id(grupo_id_grupo) references grupo(id_grupo) on update cascade on delete set null;

