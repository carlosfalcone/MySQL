# SQL - Structured Query Language  

# Bancos de dados - SGBDR
-- Sistema Gerenciador de Banco de Dados Relacional
-- Elementos: Tabelas, Campos (colunas ou atributos), Registros (linhas ou tuplas)

# Criação de um banco de dados
-- CREATE DATABASE db_biblioteca;
	-- Linux é case sensitive (biblioteca é diferente de Biblioteca)
	-- Windows nao é case sensitive
-- SHOW DATABASES;
-- USE db_biblioteca;
select database(); -- mostra o banco de dados que esta selecionado
-- DROP DATABASE db_biblioteca; - exclusao de um banco de dados
show tables; -- mostra as tabelas dentro do banco de dados

# Constraints aplicados a colunas 	- primary key, FK, DEFAULT
-- NOT NULL: nao aceita valor nulo numa linha
-- UNIQUE: valor em uma linha nao poderá se repetir em outra linha. Ex: CPF de uma pessoa
-- PRIMARY KEY: NOT NULL e UNIQUE juntos. Faz link para outras tabelas com FOREIGN KEY
-- FOREIGN KEY: tabela ligada a uma outra tabela com PRIMARY KEY
-- DEFAULT: inserir um valor padrao em todas as linhas de uma coluna, caso nao seja especificado nada durante a inserçao da linha


# CREATE TABLE - criaçao de tabelas
-- CREAT TABLE nome_tabela (nome_coluna tipo_dados constraints);
-- CREAT TABLE IF NOT EXISTS tb_livro (
-- ID_Livro smallint AUTO_INCREMENT PRIMARY KEY,
-- Nome_Livro Varchar(50) NOT NULL,
-- ISBN Varchar(30) NOT NULL,
-- etc...
-- );

# Auto incremento de valores em colunas
-- geraçao de uma sequencia de numeros em ordem sequencial
-- padrao: valor inicial se inicia em 1 e se incrementam em 1
-- inciar em outro valor: AUTO_INCREMENT = 100;
-- Só é permitido usar uma coluna de auto incremento por tabela
-- verificar valor atual do auto incremento 
SELECT MAX(Codigo) FROM tbl_teste_incremento;
select * from tbl_teste_incremento;
describe tbl_teste_incremento;
-- alterar proximo valor no campo de auto incremento
-- ALTER TABLE tbl_teste_incremento AUTO_INCREMENT = 90;

# Tipos de dados
-- INT numeros inteiros
-- TINYINT
-- SMALLINT
-- MEDIUMINT
-- BIGINT
-- DECIMAL(10,2) - 10 digitos no total com 2 digitos decimais
-- FLOAT(10,2) - o padrao é (10,2) se nao for especificado nada
-- CHAR(100) string com tamanho entre 0 e 255 caracteres
-- BOOL / BOOLEAN Valores binarios 0/1. Alias para TINYINT(1)
-- VARCHAR(1000) string de tamanho variavel até 65.535 caracteres!
-- BLOB / MEDIUMBLOB / TINYBLOB binary large objects
-- MEDIUMTEXT permite armazenar 16.777.215 caracteres
-- LONGTEXT permite armazenar até 4.292.967.295 caracteres
-- DATE datas YYYY-MM-DD
-- DATETIME data e hora YYYY-MM-DD HH:MM:SS
-- TIME hora apenas HH:MM:SS
-- YEAR(2) anos nos formatos de 2 ou 4 digitos. O padrao é 4
select curdate();
select current_time();


# ALTER TABLE - alterar tabelas
select * from tbl_autores;
-- ALTER TABLE tbl_Livro
-- DROP COLUMN Id_Autor; -- removendo uma coluna

-- ALTER TABLE tbl_Livro
-- ADD Id_Autor SMALLINT NOT NULL; -- adicionando uma coluna

-- ALTER TABLE tbl_Livro
-- ADD CONSTRAINT fk_Id_Autor
-- FOREIGN KEY (Id_Autor)
-- REFERENCES tbl_Autores (Id_Autor); -- conectando duas tabelas entre si

-- ALTER TABLE tbl_Livro
-- ADD PRIMARY KEY (Id_Cliente); -- acrescentando chave primaria na coluna

DESCRIBE tbl_livro;
DESCRIBE tbl_autores;

# INSERT INTO - inserir dados em tabelas
-- INSERT INTO tbl_Livro (coluna1, coluna2,...)
-- VALUES (valor1, valor2,...);


# SELECT - consultas simples em tabelas
-- SELECT coluna FROM tabela; -- chama 1 coluna
-- SELECT coluna1, coluna2,... FROM tabela; -- chama varias colunas
-- SELECT * FROM tabela; -- chama todas as colunas


# ORDER BY - consultas com ordenaçao
-- SELECT * FROM tabela
-- ORDER BY coluna ASC; -- ordena por ordem ascendente ASC ou descendente DESC

-- SELECT coluna1, coluna2 FROM tabela
-- ORDER BY coluna2 DESC;

# CREATE INDEX - indexaçao em tabelas
-- serve para encontrar registros numa tabela de forma mais rapida
-- indices criados como padrao: chave primaria, chave estrangeira e constraint UNIQUE
-- indice clusterizado ou nao-clusterizado

-- CREATE INDEX nome_indice ON tabela (coluna);
-- ALTER TABLE tabela ADD INDEX nome_indice (coluna);

-- EXPLAIN SELECT * FROM tabela
-- WHERE coluna = 'valor'; -- explica como a funçao será executada


# WHERE - filtrar resultados de consultas
-- SELECT coluna FROM tabela
-- WHERE coluna = valor;

-- SELECT coluna FROM tabela
-- WHERE coluna = 'string';


# AND, OR e NOT - filtrar resultados de consulta
-- SELECT * FROM tabela
-- WHERE coluna1 > valor AND coluna2 > valor;

-- SELECT * FROM tabela
-- WHERE coluna1 > valor OR coluna2 > valor;

-- SELECT * FROM tabela
-- WHERE coluna1 > valor AND NOT coluna2 > valor;


# IN  e NOT IN - filtros com lista de valores
-- filtros em clausulas WHERE

-- SELECT coluna(s) FROM tabela WHERE coluna IN (valor);

SELECT Nome_Livro, Id_Editora
FROM tbl_Livro
-- WHERE Id_Editora = 2 OR Id_Editora = 4;
WHERE Id_Editora IN (2,4); -- mesmo resultado do codigo acima!

select * from tbl_editoras;
SELECT Nome_Livro, Id_Editora
FROM tbl_Livro
WHERE Id_Editora IN (
	SELECT Id_Editora
    FROM tbl_editoras
    WHERE nome_Editora = 'Wiley' OR nome_Editora='Microsoft Press'
    );


# DELETE E TRUNCATE TABLE
-- DELETE FROM tabela WHERE coluna = valor; -- exlusao de toda a linha
-- TRUNCATE TABLE tabela; -- remove todas as linhas da tabela, mas a tabela continua existindo
-- DROP TABLE tabela; -- remove a tabela em si


# Alias com AS
-- SELECT coluna AS alias_coluna FROM tabela AS alias_tabela;
-- SELECT nome_livro AS livro FROM tbl_livro;
-- SELECT nome_livro AS livro FROM tbl_livro AS MeusLivros;
select Nome_Livro as livros -- exemplo de ALIAS
from tbl_livro;
select Nome_Livro 'livros2' -- segundo exemplo de ALIAS
from tbl_livro;
select Nome_Livro Livro -- terceiro exemplo de ALIAS
from tbl_livro;
-- logica do ALIAS: quando se usa aspas antes do nome da coluna, o valor de cada celula é preenchido com o que esta dentro da aspas.
-- quando se usa aspas depois do nome da coluna, a coluna assume esse ALIAS e somente o nome da coluna é alterado!

# Funçoes de agregaçao
select * from tbl_autores;
select count(*) from tbl_autores; -- conta a quantidade de itens da tabela
select count(Sobrenome_Autor) from tbl_autores; -- conta a quantidade de itens de uma coluna especifica
select count(distinct Nome_Autor) from tbl_autores; -- conta a quantidade de itens sem repetir o nome do autor
select * from tbl_livro;
select count(ID_Autor) from tbl_livro;
select count(distinct ID_Autor) from tbl_livro;
select max(Preco_Livro) from tbl_livro;
select min(Preco_Livro) from tbl_livro;
select avg(Preco_Livro) from tbl_livro;
select sum(Preco_Livro) from tbl_livro;

# Renomear tabelas
create table Clientes (
ID_Cliente smallint,
Nome_Cliente varchar(20),
constraint primary key (ID_Cliente)
);
insert into Clientes (ID_Cliente, Nome_Cliente)
values (22, 'Fabio');
insert into Clientes (ID_Cliente, Nome_Cliente)
values (34, 'Alberto');
insert into Clientes (ID_Cliente, Nome_Cliente)
values (63, 'Eric');
select * from Clientes;
Rename table Clientes to Meus_Clientes;
Rename table Meus_Clientes to Clientes;
select * from clientes;
insert into clientes(ID_Cliente, Nome_Cliente) values (76,'Carlos'),(77,'Falcone');

# Modificar registros
select ID_Livro, Nome_Livro
from tbl_livro;
update tbl_livro
set Nome_Livro = 'SSH, the secure shell'
where ID_Livro = 2;


# BETWEEN - Seleção de intervalos em consultas
select * from tbl_Livro;
select * from tbl_Livro
where Data_Pub between '20040517' and '20110517';
select Nome_Livro as Livro, Preco_Livro as Preço 
from tbl_Livro
where Preco_livro between 40 and 60;


# LIKE e NOT LIKE - Padroes de caracteres em consultas
select * from tbl_Livro
where Nome_Livro like 'f%';
select * from tbl_Livro
where Nome_Livro like 'F%';
select * from tbl_Livro
where Nome_Livro like '_%';
select * from tbl_Livro
where Nome_Livro not like 'S%';
select Nome_Livro 
from tbl_Livro
where Nome_Livro like '_i%'; -- primeiro caractere inicia com qualquer letra e a segunda letra é a letra 'i'
select * from tbl_Livro
where Preco_Livro like '8%';


# REGEXP - Expressoes regulares em consultas
select Nome_Livro from tbl_livro;
select Nome_Livro
from tbl_livro
where Nome_Livro regexp '^[FS]'; -- busca palavras que se iniciam (^) com F ou S
select Nome_Livro
from tbl_livro
where Nome_Livro regexp '^[^FS]'; -- busca palavras que se iniciam (^) com qq letra diferente de F ou S
select Nome_Livro
from tbl_livro
where Nome_Livro regexp '[le]$'; -- busca palavras que possuem 'l' ou 'e' no final ($)
select Nome_Livro
from tbl_livro
where Nome_Livro regexp '^[^FS]|Mi'; -- palavras que nao começam com 'f' ou 's' porem se iniciam com 'Mi'
select Nome_Livro
from tbl_livro
where Nome_Livro regexp '^[^M]|Mi'; -- palavras que nao começam com 'm' porem se iniciam com 'Mi'

# DEFAULT - Aplicando valores-padrao em colunas
select * from tbl_autores;
alter table tbl_autores
modify column Sobrenome_Autor varchar(60)
default 'da silva';
insert into tbl_autores (ID_Autor, Nome_Autor)
values (8,'João');
insert into tbl_autores (ID_Autor, Nome_Autor, Sobrenome_Autor)
values (9,'Rita','de Souza');
alter table tbl_autores
modify column Sobrenome_Autor varchar(60); -- desfazer o comando DEFAULT
insert into tbl_autores (ID_Autor, Nome_Autor)
values (10,'Ana');


# mysqldump - Backup do bando de dados
    
    -- Procedimento para realizar backup do banco de dados -- 

cd\ ir para o diretorio raiz
dir lista as pastas dentro de um diretorio
cd\Program Files\MySQL vai para a pasta no caminho selecionado


1-caminho do executavel do mysqldump:
C:\Program Files\MySQL\MySQL Server 8.0\bin

2-abri o prompt de comando (cmd) e selecionar o caminho do executavel acima
cd\ vai para o diretorio raiz c:\
depois digita o comando abaixo:
cd\Program Files\MySQL\MySQL Server 8.0\bin

3- escrever o comando abaixo para realizar o backup
mysqldump -u root -p db_biblioteca > C:/Users/Falcone/Documents/0_SQL/db_biblioteca_backup.sql

4- entrar com a senha do mysql

	-- Restauraçao do banco de dados --

1 - criar um banco de dados vazio do mysql

2 - digitar o comando ao lado, dentro do diretorio onde esta o executavel do mysqldump: mysql -u root -p teste_restauracao < C:/Users/Falcone/Documents/0_SQL/db_biblioteca_backup.sql
create database teste_restauracao;
	
    -- ver o restante da operaçao no arquivo do bloco de notas
    -- selecionar este banco de dados para ver se realmente esta funcionando
    -- set as default schema
select database();
select * from tbl_livro;    


# GROUP BY - Agrupamento de registros
create table vendas (
id smallint primary key,
nome_vendedor varchar(20), -- nao aceita o caracter '-'. Somente '_'
quantidade int,
produto varchar(20),
cidade varchar(20)
);
insert into vendas (id, nome_vendedor, quantidade, produto, cidade)
values (10, 'jorge', 1400,'mouse', 'sao paulo');
insert into vendas (id, nome_vendedor, quantidade, produto, cidade)
values (12, 'tatiana', 1220,'teclado', 'sao paulo');
insert into vendas (id, nome_vendedor, quantidade, produto, cidade)
values (14, 'ana', 1700,'teclado', 'rio de janeiro');
insert into vendas (id, nome_vendedor, quantidade, produto, cidade)
values (15, 'rita', 2120,'webcam', 'recife');
insert into vendas (id, nome_vendedor, quantidade, produto, cidade)
values (18, 'marcos', 980,'mouse', 'sao paulo');
insert into vendas (id, nome_vendedor, quantidade, produto, cidade)
values (19, 'carla', 1120,'webcam', 'recife');
insert into vendas (id, nome_vendedor, quantidade, produto, cidade)
values (22, 'roberto', 3145,'mouse', 'sao paulo');
insert into vendas (id, nome_vendedor, quantidade, produto, cidade)
values (25, 'amilcar', 2000,'teclado', 'sao paulo');
insert into vendas (id, nome_vendedor, quantidade, produto, cidade)
values (46, 'carlos', 1000,'mouse', 'belo horizonte');
insert into vendas (id, nome_vendedor, quantidade, produto, cidade)
values (50, 'Leo', 500,'mouse', 'belo horizonte');
select*from vendas;
select count(*) from vendas;
select * from vendas
where produto = 'mouse'; -- seleçao sem group by
select sum(quantidade) as total_mouses
from vendas
where produto = 'mouse';
select cidade, sum(quantidade) as total_mouses
from vendas
where produto = 'mouse'
group by cidade;
select cidade, sum(quantidade) as total
from vendas
group by cidade;
select cidade, sum(quantidade) as total_teclados
from vendas
where produto = 'teclado'
group by cidade;
select cidade, count(*) as total
from vendas -- neste caso este comando retorno uma informaçao errada, pois o software pega o nome da primeira cidade somente.
group by cidade; -- necessario acrescentar essa linha para a informaçao ficar correta.
select * from vendas;

-- questao do quiz do linkedin
	-- Q60. You are working with the tables as shown in this diagram. You need to get the number of cars sold per the home state of each customer's residence. How can you accomplish this?
create table tbl_customers (
id char(10) primary key,
lastname varchar(45),
firstname varchar(45),
phone char(15),
address varchar(100),
city varchar(50),
state char(5),
zip char(10)
);
select *from tbl_customers;
create table tbl_purchases (
customer_id char(10),
car_id char(10),
dates date,
price decimal
);
select*from tbl_purchases;
create table tbl_cars (
id char(10) primary key,
make char(25),
model varchar(45),
years int,
color char(15),
price decimal
);
select*from tbl_cars;
drop table tbl_cars;
ALTER TABLE tbl_purchases
ADD CONSTRAINT fk_customer_id
FOREIGN KEY (customer_id)
REFERENCES tbl_customers (id);
ALTER TABLE tbl_purchases
ADD CONSTRAINT fk_car_id
FOREIGN KEY (car_id)
REFERENCES tbl_cars (id);

insert into tbl_customers (id, firstname, state)
values (1, 'carlos', 'MG'),
(2, 'filipe', 'RJ'),
(3, 'leo', 'AM'),
(4, 'eloisa', 'MG'),
(5, 'marcelo', 'MG');
insert into tbl_cars (id, make)
values (100,'VW'), -- volkswagen
(200, 'Fiat'), -- fiat
(300, 'GM'), -- GM
(400,'Honda'); -- honda
insert into tbl_purchases (customer_id, car_id)
values (1, 100), -- volkswagen
(2, 200), -- fiat
(3, 200), -- fiat
(3, 300), -- GM
(4, 300), -- GM
(5, 400); -- honda
select*from tbl_customers;
select*from tbl_purchases;
select*from tbl_cars;
describe tbl_cars;

select * 
from tbl_customers as c
inner join tbl_purchases as p
on c.id=p.customer_id
inner join tbl_cars as cars
on p.car_id=cars.id;

	-- Q60. You are working with the tables as shown in this diagram. You need to get the number of cars sold (purchased) per the home state of each customer's residence. How can you accomplish this?
-- opção C - correta
SELECT state, COUNT(*)  -- conta quantas vezes um estado especifico apareceu na tabela
FROM tbl_customers c, tbl_purchases p 
WHERE c.id = p.customer_id
GROUP BY state;

-- para o codigo abaixo existe a explicaçao seguinte, mas o resultado deu o mesmo!!
-- Explanation: THe difference between 2 and 3 is that LEFT JOIN will return 1 row per customer before grouping. If replaced with RIGHT JOIN it would return the correct info.
-- opçao B
SELECT state, COUNT(*) 
FROM tbl_customers c
LEFT JOIN tbl_purchases p 
ON c.id = p.customer_id
GROUP BY state;


-- opçao A
SELECT state, COUNT(*) 
FROM tbl_customers 
WHERE id IN (
	SELECT customer_id 
	FROM tbl_purchases) 
GROUP BY state;

-- Entendendo o codigo acima
SELECT customer_id 
FROM tbl_purchases;

SELECT *
FROM tbl_customers 
WHERE id IN (
	SELECT customer_id 
	FROM tbl_purchases);

-- opçao D
SELECT state, COUNT(*) 
FROM tbl_customers
GROUP BY state;


-- termino da questao do linkedin



# HAVING - Filtrando os resultados do agrupamento do GROUP BY
select * from vendas;
select cidade, sum(quantidade) as total
from vendas
group by cidade
having sum(quantidade) < 2500;
select cidade, sum(quantidade) as total_teclados
from vendas
where produto = 'teclado' -- rodando o codigo ate aqui, o resultado mostra a soma total de teclados. cuidado!!
group by cidade
having sum(quantidade) < 1800;
select cidade, sum(quantidade) as total_mouses
from vendas
where produto = 'mouse' -- rodando o codigo ate aqui, o resultado mostra a soma total de mouses. cuidado!!
group by cidade
having sum(quantidade) < 1800;
select * from vendas;


# VIEWS - Criando tabelas virtuais
create view vw_teste as
select id_livro, Nome_livro
from tbl_livro;

select*from vw_teste;

select * from tbl_livro;
describe tbl_livro;
select * from tbl_autores;
describe tbl_autores;
create view vw_LivrosAutores as 
select tbl_livro.Nome_Livro as livro,
tbl_autores.Nome_Autor as autor
from tbl_livro
inner join tbl_autores
on tbl_livro.ID_Autor = tbl_autores.ID_Autor; -- foreign key = primary key
select * from vw_livrosautores;
select livro, autor
from vw_livrosautores
order by autor;

-- corrigir uma VIEW
alter view vw_LivrosAutores as
select tbl_livro.Nome_Livro as livro,
tbl_autores.Nome_Autor as autor,
Preco_Livro as valor
from tbl_livro
inner join tbl_autores
on tbl_livro.ID_Autor = tbl_autores.ID_Autor;
select *
from vw_livrosautores
order by valor;

-- exclusao de uma VIEW
drop view vw_livrosautores;


# INNER JOIN - Consultar dados em duas ou mais tabelas
select * from tbl_livro;
select * from tbl_autores;
select * from tbl_livro
inner join tbl_autores
on tbl_livro.ID_Autor = tbl_autores.ID_Autor; -- chave estrangeira e chave primaria
describe tbl_livro;

select tbl_livro.Nome_Livro,
tbl_livro.ISBN,
tbl_autores.Nome_Autor
from tbl_livro
inner join tbl_autores
on tbl_livro.ID_Autor = tbl_autores.ID_Autor;

-- escrevendo o codigo acima de forma simplificada
select Nome_Livro,
ISBN,
Nome_Autor
from tbl_livro
inner join tbl_autores
on tbl_livro.ID_Autor = tbl_autores.ID_Autor;

select tbl_livro.Nome_Livro, -- exemplo do que nao se deve fazer!
tbl_livro.ISBN,
tbl_autores.Nome_Autor
from tbl_livro, tbl_autores;

select L.Nome_Livro as livros,
E.Nome_editora as editoras
from tbl_livro as L
inner join tbl_editoras as E
on L.ID_editora = E.ID_editora
where E.Nome_Editora like 'M%';

select L.Nome_Livro as livros,
A.Nome_Autor as autor,
E.Nome_editora as editoras
from tbl_livro as L
inner join tbl_autores as A
on L.ID_Autor = A.ID_Autor
inner join tbl_editoras as E
on L.ID_editora = E.ID_editora;


# OUTER JOIN - LEFT E RIGHT JOIN - Consultar dados em duas ou mais tabelas
select * from tbl_livro;
select * from tbl_autores;

select * from tbl_autores
left join tbl_livro 
on tbl_livro.ID_Autor = tbl_autores.ID_Autor;

select * from tbl_autores
right join tbl_livro -- right join para comparar com o codigo de cima. Apresenta somente o que as duas tabelas tem em comum.
on tbl_livro.ID_Autor = tbl_autores.ID_Autor;

select * from tbl_livro
left join tbl_autores
on tbl_livro.ID_Autor = tbl_autores.ID_Autor;

select * from tbl_livro
right join tbl_autores
on tbl_livro.ID_Autor = tbl_autores.ID_Autor;

select * from tbl_autores
left join tbl_livro
on tbl_livro.ID_Autor = tbl_autores.ID_Autor
where tbl_livro.id_autor is null;


-- RIGHT JOIN
select * from tbl_autores
right join tbl_livro
on tbl_livro.ID_Autor = tbl_autores.ID_Autor;

insert into tbl_editoras (ID_Editora, Nome_Editora)
values (6, 'Companhia das Letras');

select * from tbl_editoras;
select * from tbl_livro;
select * from tbl_livro as Li
right join tbl_editoras as Ed
on Li.ID_editora = Ed.ID_Editora;

select * from tbl_livro as Li
right join tbl_editoras as Ed
on Li.ID_editora = Ed.ID_Editora
where Li.ID_editora is null;


# CONCAT, IFNULL, COALESCE - Concatenaçao de strings
select concat ('Carlos ', 'Falcone') as 'Meu Nome';
select concat(nome_autor, ' ', sobrenome_autor)
as 'Nome Completo'
from tbl_autores;
select concat('Eu gosto do livro ', nome_livro)
as 'Livro Preferido'
from tbl_livro 
where ID_Autor = 3;
select * from tbl_livro;

-- CONCAT com celulas NULL
create table teste_nulos(
id smallint primary key auto_increment,
item varchar(20),
quantidade smallint null);
insert into teste_nulos (id, item, quantidade)
values (1, 'Pendrive', 5);
insert into teste_nulos (id, item, quantidade)
values (2, 'Monitor', 7);
insert into teste_nulos (id, item, quantidade)
values (3, 'Teclado', null);
select * from teste_nulos;
describe teste_nulos;

select concat('A quantidade adquirida é ', quantidade)
from teste_nulos
where item= 'monitor';
select concat('A quantidade adquirida é ', quantidade)
from teste_nulos
where item= 'Teclado'; -- retorna somente null
-- para contornar o problema acima
-- funçoes IFNULL e COALESCE (retorna o primeiro valor nao nulo)
select concat('A quantidade adquirida é ', ifnull(quantidade,0)) -- substituir null por zero
from teste_nulos
where item= 'Teclado';
select concat('A quantidade adquirida é ', 
coalesce(null, quantidade, null, 0))
from teste_nulos
where item= 'Teclado';
select concat('A quantidade adquirida é ', 
coalesce(null, quantidade, null, 0)) as resultado
from teste_nulos
where item= 'Monitor';
select concat('A quantidade adquirida é ', 
coalesce(quantidade, 0)) as resultado
from teste_nulos
where item= 'Monitor';
select concat('A quantidade adquirida é ', 
coalesce(quantidade, 0)) as resultado
from teste_nulos
where item= 'Teclado';


# Funções matematicas e operadores aritmeticos
select 3*9;
select nome_livro, preco_livro * 5 as 'Preço de 5 unidades'
from tbl_livro;
select 2*9/3;
select nome_livro, preco_livro/2 as 'Preço com 50% de desconto'
from tbl_livro;
select 10/3;
select 10 mod 3; -- resto da divisao
select 10 mod 4; -- resto da divisao
select 10 mod 6; -- resto da divisao

# funçoes matematicas
-- CEILING() ARREDONDA PRA CIMA
-- FLOOR() ARREDONDA PRA BAIXO
-- PI() RETORNA O VALOR DE PI
select pi();
-- POW(X,Y) X ELEVADO A Y
-- SQRT() RAIZ QUADRADA
-- SIN() SENO EM RADIANOS
-- HEX() CONVERSAO DE DECIMAL PARA HEXADECIMAL

select nome_livro, ceiling(preco_livro*5) as 'Preço arredondado'
from tbl_livro;
select pi();
select pow(2,4) as resultado;
select sqrt(81);
select sin(pi());
select hex(1200);
select bin(3);
select binary(3); -- o que é isso??


# CREATE FUNCTION - Rotinas Armazenadas
SET GLOBAL log_bin_trust_function_creators = 1; -- linha de comando para nao dar erro durante a criaçao da funçao. Link: https://stackoverflow.com/questions/26015160/deterministic-no-sql-or-reads-sql-data-in-its-declaration-and-binary-logging-i
create function fn_teste (a decimal(10,2), b int)
returns int
return a * b;
select fn_teste(2.5,4) as Resultado;
select nome_livro, fn_teste(preco_livro,6) as 'Preço de 6 unidades'
from tbl_livro
where ID_Livro = 2;
drop function fn_teste;


# Stored procedures - Procedimentos armazenados
create procedure pro_teste2 (a decimal(10,2), b int)
select a*b as Resultado;
call pro_teste2(2.5,4);
drop procedure pro_teste2;

create procedure pro_verPreco (var_idlivro smallint)
select concat('O preço é ', preco_livro) as Preço
from tbl_livro
where ID_Livro=var_idlivro;
call pro_verpreco(3);
select * from tbl_livro;
drop procedure pro_verpreco;


# Blocos BEGIN...END em funçoes e procedimentos armazenados
drop function teste3;
DELIMITER $$
CREATE FUNCTION teste3 (a decimal(10,2))
RETURNS INTEGER
BEGIN
RETURN a + 3;
END $$
delimiter ;
SELECT teste3(10);

delimiter //
create procedure pro_verPreco2 (var_idlivro smallint)
begin
select concat('O preço é ', preco_livro) as Preço
from tbl_livro
where ID_Livro=var_idlivro;
select 'Procedimento executado com sucesso';
end //
delimiter ;
call pro_verPreco2(3);
drop procedure pro_verPreco2;


# Parametros IN, OUT e INOUT em Procedimentos Armazenados
select * from tbl_livro;

-- exemplo 0
create procedure pro_teste (in var_a int, out var_resultado int)
select var_a*2 as Resultado
into var_resultado;
set @var_a = 4;
select @var_a;
call pro_teste(@var_a, @var_resultado);
select @var_resultado;
drop procedure pro_teste;

-- exemplo 01
select * from tbl_livro;
select * from tbl_editoras;
delimiter //
create procedure pro_editora_livro (in var_editora varchar(50))
begin
select L.Nome_livro, E.Nome_editora
from tbl_livro as L
inner join tbl_editoras as E
on L.ID_editora = E.ID_Editora
where E.Nome_Editora = var_editora;
end //
delimiter ;
call pro_editora_livro ('wiley');
call pro_editora_livro ('Microsoft Press');
call pro_editora_livro ('Companhia das Letras'); -- nao tem correspondenciana tabela livros
set @minhaeditora = 'Prentice Hall';
call pro_editora_livro(@minhaeditora);

-- exemplo 02
delimiter //
create procedure pro_aumenta_preco (in var_codigo int, var_taxa decimal(10,2))
begin
update tbl_livro
set preco_livro = tbl_livro.Preco_Livro + tbl_livro.Preco_Livro* var_taxa/100
where id_livro = var_codigo;
end //
delimiter ;
select * from tbl_livro where ID_Livro = 4; -- verificar o preço atual
set @livro = 4; -- aplicando o procedimento acima
set @aumento = 20;
call pro_aumenta_preco(@livro, @aumento); -- este procedimento mudou o valor do livro na tabela definitivamente, por causa do comando UPDATE
select * from tbl_livro;

-- exemplo 03
delimiter //
create procedure pro_teste_out (in var_id int, out var_livro varchar(50))
begin
select nome_livro
into var_livro
from tbl_livro
where ID_Livro = var_id;
end //
delimiter ;
call pro_teste_out(4,@livro);
select @livro;
select * from tbl_livro;

-- exemplo 04 - INOUT
delimiter //
create procedure pro_aumento (inout var_valor decimal(10,2), var_taxa decimal(10,2))
begin
set var_valor = var_valor + var_valor * var_taxa/100;
end //
delimiter ;
set @valor = 20;
select @valor;
call pro_aumento(@valor, 15.00);
select@valor;
select @var_taxa;
drop procedure pro_aumento;

-- exemplo 05 - INOUT
delimiter //
create procedure pro_aumento2 (inout var_valor decimal(10,2), inout var_taxa decimal(10,2))
begin
set var_valor = var_valor + var_valor * var_taxa/100;
end //
delimiter ;
set @valor = 20;
set @taxa=15;
select @valor;
select @taxa;
call pro_aumento2(@valor, @taxa);
select@valor;
select @var_taxa;
drop procedure pro_aumento2;

# DECLARE - variaveis locais e escopo
SET GLOBAL log_bin_trust_function_creators = 1; -- linha de comando para nao dar erro durante a criaçao da funçao. Link: https://stackoverflow.com/questions/26015160/deterministic-no-sql-or-reads-sql-data-in-its-declaration-and-binary-logging-i

delimiter //
create function fun_calcula_desconto (varlivro int, vardesconto decimal(10,2))
returns decimal(10,2)
begin
declare preco decimal(10,2);
select preco_livro from tbl_livro
where ID_Livro = varlivro into preco;
-- return preco;
return preco - vardesconto;
end //
delimiter ;
select * from tbl_livro where ID_Livro=4;
select fun_calcula_desconto(4,10);
drop function fun_calcula_desconto;

# IF, ELSE, CASE - blocos condicionais
delimiter //
create function fun_calcula_imposto(varsalario dec(8,2))
returns dec(8,2)
begin
declare valor_imposto dec(8,2);
if varsalario < 1000 then
set valor_imposto = 0;
elseif varsalario < 2000 then
set valor_imposto = varsalario*0.15;
elseif varsalario < 3000 then
set valor_imposto = varsalario*0.22;
else
set valor_imposto = varsalario*0.27;
end if;
return valor_imposto;
end//
delimiter ;
select fun_calcula_imposto(3000);
drop function fun_calcula_imposto;

delimiter //
create function fun_calcula_imposto_case(varsalario dec(8,2))
returns dec(8,2)
begin
declare valor_imposto dec(8,2);
case
when varsalario < 1000 then
set valor_imposto = 0;
when varsalario < 2000 then
set valor_imposto = varsalario*0.15;
when varsalario < 3000 then
set valor_imposto = varsalario*0.22;
else
set valor_imposto = varsalario*0.27;
end case;
return valor_imposto;
end//
delimiter ;
select fun_calcula_imposto_case(3000);

-- Exercicio 97 
-- https://github.com/Ebazhanov/linkedin-skill-assessments-quizzes/blob/main/mysql/mysql-quiz.md
SET GLOBAL log_bin_trust_function_creators = 1; -- linha de comando para nao dar erro durante a criaçao da funçao. Link: https://stackoverflow.com/questions/26015160/deterministic-no-sql-or-reads-sql-data-in-its-declaration-and-binary-logging-i

delimiter //
create function fun_teste(var1 dec(8,2),var2 dec(8,2))
returns dec(8,2)
begin
declare varA dec(8,2);
if var1 = 1 then
set varA =  var1;
return varA;
elseif var1 = 2 then
set varA =  var2;
return varA;
end if;
end//
delimiter ;
select fun_teste(2,9);
drop function fun_teste;

delimiter //
create function fun_teste2(var1 dec(8,2),var2 dec(8,2))
returns dec(8,2)
begin
declare varA dec(8,2);
case
when var1 = 1 then
set varA =  var1;
return varA;
when var1 = 2 then
set varA =  var2;
return varA;
end case;
end//
delimiter ;
select fun_teste2(1,9);
drop function fun_teste2;




# SHOW, DESCRIBE e Mysqlshow
show create procedure pro_aumenta_preco; -- exibe o codigo que criou o procedimento
show columns from tbl_livro; -- key MUL (MULTIPLES) - suporta multiplos valores repetidos por ser chave estrangeira
show columns from tbl_editoras;
describe tbl_editoras;
show tables;

--Mysqlshow
Entrar no diretorio do MySQL e digitar o camando para carregar o mysql
cd\ vai para o diretorio raiz c:\
depois digita o comando abaixo:
cd\Program Files\MySQL\MySQL Server 8.0\bin
depois digita o comando abaixo para carregar o executavel do mysql:
mysql -u root -p
entra com a senha

digitar help show para listar todos os comandos show


# LOOP - Estruturas de repetiçao
delimiter //
create procedure pro_acumula (inlimite int)
begin
	declare contador int default 0;
	declare soma int default 0;
	loop_teste: loop
		set soma = soma + contador;
        set contador = contador +1;
		if contador > inlimite then
			leave loop_teste;
		end if;
	end loop loop_teste;
	select soma;
end //
delimiter ;
call pro_acumula(10);
drop procedure pro_acumula;


# REPEAT - Estrutura de repetiçao
delimiter //
create procedure pro_acumula_repete (inlimite tinyint unsigned)
begin
	declare contador tinyint unsigned default 0;
	declare soma int default 0;
	repeat
		set soma = soma + contador;
        set contador = contador +1;
	until contador > inlimite
	end repeat;
	select soma;
end //
delimiter ;
call pro_acumula_repete(0);
call pro_acumula_repete(5);
drop procedure pro_acumula_repete;


# WHILE - Estrutura de repetiçao
delimiter //
create procedure pro_acumula_while (inlimite tinyint unsigned)
begin
	declare contador tinyint unsigned default 0;
	declare soma int default 0;
	while contador <= inlimite do
    set soma = soma + contador;
    set contador = contador +1;
	end while;
	select soma;
end //
delimiter ;
call pro_acumula_while(0);
call pro_acumula_while(10);
drop procedure pro_acumula_while;


# ITERATE - Estruturas de repetiçao
delimiter //
create procedure pro_acumula_iterate (inlimite tinyint unsigned)
begin
	declare contador tinyint unsigned default 0;
	declare soma int unsigned default 0;
	teste: loop
		set soma = soma + contador;
		set contador = contador +1;
		if contador <= inlimite then
			iterate teste;
		end if;
		leave teste;
	end loop teste;
	select soma;
end //
delimiter ;
call pro_acumula_iterate(5);
drop procedure pro_acumula_iterate;


# Triggers - definição, sintaxe e criação
-- procedimento invocado quando um comando DML (insert, update, delete) é executado
-- associado a uma tabela especifica
create table tbl_produto (
Id_Produto int not null auto_increment,
Nome_Produto varchar(45) null,
Preco_Normal decimal(10,2) null,
Preco_Desconto decimal(10,2) null,
primary key (Id_Produto));
drop table tbl_produto;
select*from tbl_produto;

-- criando o trigger
create trigger tri_desconto before insert
on tbl_produto
for each row
set new.Preco_Desconto = new.Preco_Normal * 0.9; -- palavra NEW é necessaria pois as colunas indicadas ainda nao existem (devido ao comando before insert)
insert into tbl_produto (Nome_Produto, Preco_Normal)
values ('DVD', 1), ('Pendrive', 18);
select * from tbl_produto;


# Gerenciamento de usuarios do sistema


# Definindo privilegios de acesso com GRANT e REVOKE
	-- ver depois
   
# ENUM - Tipo de dado de enumeraçao
create table tbl_camisas (
idCamisa tinyint primary key auto_increment,
nome varchar(25),
tamanho enum ('pequena', 'media', 'grande','extra-grande')
);
insert into tbl_camisas (nome, tamanho)
values ('regata', 'grande');
select*from tbl_camisas;
insert into tbl_camisas (nome, tamanho)
values ('social', 'medium'); -- valor medium nao foi aceito, pois nao foi cadastrado na restriçao ENUM
insert into tbl_camisas (nome, tamanho)
values 
('social', 'media'),
('polo', 'pequena'),
('polo', 'grande'),
('camiseta', 'extra-grande');
show columns from tbl_camisas like 'tamanho'; -- mostra os tipos permissiveis para o registro
select nome, tamanho+0 -- mostra o numero dos indices
from tbl_camisas;
select*from tbl_camisas
order by tamanho; -- ordem dos valores inseridos durante a criaçao da tabela
select*from tbl_camisas
order by cast(tamanho as char); -- ordem alfabetica
drop table camisas;

   
# Campos gerados - colunas calculadas
create table tbl_mult (
Id smallint primary key auto_increment,
num1 smallint not null,
num2 smallint not null,
num3 smallint generated always as (num1*num2) virtual -- virtual significa que esta coluna é gerada toda vez que a tabela é carregada
);
insert into tbl_mult (num1,num2)
values (2,1), (2,2), (2,3), (2,4);
select * from tbl_mult;
update tbl_mult
set num2=8
where Id=2;

create table tbl_vendas (
Id_Venda smallint primary key auto_increment,
Preco_Produto decimal(6,2) not null,
Qtde tinyint not null,
Desconto decimal(4,2) not null,
Preco_Total decimal(6,2) as (Preco_Produto * Qtde * (1- Desconto/100)) stored -- valores armazenados efetivamente na tabela
);
insert into tbl_Vendas (Preco_Produto, Qtde, Desconto)
values
(50,2,20),
(65,3,15),
(100,1,12),
(132,3,18);
select * from tbl_Vendas;


# UNION - Unir dois ou mai resultados de consultas
select Nome_Livro Livro, Preco_Livro Preço, 'Livro Caro' Resultado
from tbl_livro
where Preco_Livro>=60
union
select Nome_Livro Livro, Preco_Livro Preço, 'Preço Razoável' Resultado
from tbl_livro
where Preco_Livro<60
order by Preço;

select Nome_Livro Livro, -- nome da coluna renomeado pelo ALIAS
Data_Pub 'Data de Publicação', -- nome da coluna entre aspas ALIAS
Preco_Livro 'Preço Normal', -- nome da coluna entre aspas ALIAS
Preco_Livro*0.9 'Preço Ajustado' -- nome da coluna entre aspas ALIAS
from tbl_livro
where Preco_Livro > 65
union
select Nome_Livro Livro, -- nome da coluna renomeado pelo ALIAS
Data_Pub 'Data de Publicação', -- nome da coluna entre aspas ALIAS
Preco_Livro 'Preço Normal', -- nome da coluna entre aspas ALIAS
Preco_Livro*1.15 'Preço Ajustado' -- nome da coluna entre aspas ALIAS
from tbl_livro
where Data_Pub < '20020415';
select * from tbl_livro;

-- outro exemplo baseado no exemplo acima, onde os itens ficam duplicados, com resultados diferentes
select Nome_Livro Livro, -- nome da coluna renomeado pelo ALIAS
Data_Pub 'Data de Publicação', -- nome da coluna entre aspas ALIAS
Preco_Livro 'Preço Normal', -- nome da coluna entre aspas ALIAS
Preco_Livro*0.9 'Preço Ajustado' -- nome da coluna entre aspas ALIAS
from tbl_livro
where Preco_Livro > 50
union
select Nome_Livro Livro, -- nome da coluna renomeado pelo ALIAS
Data_Pub 'Data de Publicação', -- nome da coluna entre aspas ALIAS
Preco_Livro 'Preço Normal', -- nome da coluna entre aspas ALIAS
Preco_Livro*1.15 'Preço Ajustado' -- nome da coluna entre aspas ALIAS
from tbl_livro
where Data_Pub < '20020415';


# Como conectar script python a um banco de dados MySQL
-- pip install mysql-connector-python


# Como agendar eventos no MySQL


# O que sao subconsultas (Subqueries)
use db_biblioteca;
select Nome_Livro, Preco_Livro, ID_Editora
from tbl_livro
where Id_Editora = 
	(select ID_editora
    from tbl_editoras
    where Nome_Editora='Wiley');
    select * from tbl_editoras;
    update tbl_livro
    set Preco_Livro = Preco_Livro*1.12
    where Id_Editora=
		(select Id_Editora
        from tbl_editoras
        where Nome_Editora='Microsoft Press');
select * from tbl_livro;


# ROUND, FLOOR, CEILING, TRUNCATE: Funçoes de arredondamento
-- ROUND arredonda de acordo com as regras de arredondamento matematico
-- FLOOR arredonda para baixo
-- CEILING arredonda para cima
-- TRUNCATE trunca o numero e é obrigatorio informar o numero de casas decimais


# COMMIT e ROLLBACK - transaçoes no MySQL
-- Propriedades ACID - atomicidade (açao executada de forma completa ou nao acontece nada. Ex: transferencia bancaria)
-- consistencia, isolamento e durabilidade
-- transaçao efetivada com sucesso - COMMIT (consolidaçao da transaçao)
-- falha na transaçao - ROLLBACK
-- Ex:
-- START TRANSACTION;
--		xxxx
--		xxx
-- ROLLBACK;

# Importar e exportar arquivos .csv em tabelas do MySQL

-- importar
select * from tbl_autores;
describe tbl_autores;
describe tbl_teste_incremento;

show variables like 'secure_file_priv'; -- pasta onde sera importado ou exportado os arquivos .csv. Esse linha dentro do arquivo .ini pode ser comentada para nao ser considerada.
use db_biblioteca;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/TesteImportacao.csv'
into table tbl_autores
fields terminated by ','
-- enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(id_autor,nome_autor, sobrenome_autor);
select * from tbl_autores;

-- exportar
(select 'Livro', 'Preço', 'Editora')
union
select L.nome_Livro, L.preco_livro, E.nome_Editora
from tbl_livro L
inner join tbl_editoras E
on L.id_Editora = E.id_Editora
into outfile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/teste4.csv'
fields terminated by ','
lines terminated by '\n';
 
select * from tbl_livro;

update tbl_livro
set Nome_Livro = 'SSH-The secure shell'
where ID_Livro = 2;


# MATCH e AGAINST

select * from tbl_autores
where match (tbl_autores.Sobrenome_Autor,tbl_autores.Nome_Autor) against ('Barret'); -- nao funcionou! Ver msg de erro!!

select * 
from tbl_autores
where match (Sobrenome_Autor) against ('carter');
 -- nao funcionou! Ver msg de erro!!

# UPPERCASE e LOWERCASE
insert into tbl_autores (id_autor, nome_autor, sobrenome_autor)
values (100,'DANIEL', 'Fernandes');
select*from tbl_autores;
select * from tbl_autores where nome_autor='daniel';
select * from tbl_autores where upper(nome_autor)='DANIEL';
select * from tbl_autores where lower(nome_autor)='daniel';


show engines;

show databases;
select database();

show triggers;

# ROLLUP -- YOUTUBE Ronan Vico
# https://www.youtube.com/watch?v=PQhTb5LUPvw

create table vendas2 (
Empresa varchar(30),
Filial varchar(2),
Vendas float
);

insert into vendas2 (Empresa, Filial, Vendas)
values 
('Empresa 1', 'SP', 831),
('Empresa 2', 'SP', 957),
('Empresa 1', 'SP', 269),
('Empresa 1', 'MG', 459),
('Empresa 1', 'RJ', 195),
('Empresa 1', 'RJ', 843),
('Empresa 2', 'RJ', 791),
('Empresa 2', 'SP', 147),
('Empresa 2', 'SP', 191),
('Empresa 2', 'RJ', 442),
('Empresa 2', 'MG', 511),
('Empresa 2', 'MG', 279),
('Empresa 3', 'RJ', 503),
('Empresa 3', 'SP', 218),
('Empresa 3', 'SP', 689),
('Empresa 3', 'RJ', 547),
('Empresa 3', 'MG', 954),
('Empresa 3', 'MG', 546);

select * from vendas2;

select Empresa, Filial, sum(vendas)
from vendas2;

select Empresa, Filial, sum(vendas)
from vendas2
group by empresa;

select Empresa, Filial, sum(vendas)
from vendas2
group by empresa,filial
order by empresa, filial;

select Empresa, Filial, sum(vendas)
from vendas2
group by empresa,filial
with rollup;

select
ifnull(relatorio.empresa,'Total') as Empresa,
ifnull(relatorio.filial,'Subtotal') as Filial,
relatorio.Vendas
-- para remover o Subtotal da ultima linha
-- precisa acrescentar if Empresa=Total e Filial=Subtotal, entao Filial = ''.
from
(
select Empresa, Filial, sum(vendas) as Vendas
from vendas2
group by empresa,filial
with rollup
)
as relatorio;

# CTE - Common Table Expression (parecido com view / subqueries)
with ConsultaCTE (Cliente, total)
as (select CL.nome_Cliente as Cliente,
PR.Preco_Produto * CO.Quantidade as Total
from Clientes as CL
inner join Compras as CO
on CL.ID_Cliente = CO.ID_Cliente
inner join Produtos as PR
on CO.ID_Produto = PR.ID_Produto)

select Cliente, sum(Total) as ValorTotal
from ConsultaCTE
group by cliente
order by ValorTotal;

-- https://www.w3schools.com/quiztest/result.asp
select * from tbl_autores;
SELECT * FROM tbl_autores WHERE Nome_Autor='Gerald'; 
SELECT * FROM tbl_autores WHERE Nome_Autor='Gerald' AND Sobrenome_Autor='Carter'; 
SELECT * FROM tbl_autores WHERE Nome_Autor='Gerald' AND Sobrenome_Autor='Silva'; 


CREATE DATABASE db_sistemabancario;
USE db_sistemabancario;
select* from tbl_conta;
select* from tbl_cliente;
DROP TABLE tbl_conta;
DROP TABLE tbl_cliente;