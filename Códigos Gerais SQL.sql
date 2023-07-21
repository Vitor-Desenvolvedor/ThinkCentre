  /**********************************************/
 /* Códigos e comandos para phpmyadmin - MySQL */ 
/**********************************************/

RENAME TABLE nome_antigo TO nome_novo; /* Renomear uma tabela */

DROP DATABASE nome_banco_dados; /* Deletar banco de dados */

DROP TABLE nome_tabela; /* Deletar tabela */

UPDATE nome_tabela SET nome_coluna = 'Novo_dado' WHERE nome_coluna = 'Local_nome_linha'; /* Atualizar dado contido na tabela */

FOREIGN KEY (Nome_coluna) REFERENCES Nome_tabela (Nome_coluna) ON UPDATE CASCADE ON DELETE CASCADE; /* Configurar chave estrangeira para atualizar dado contido na tabela e demais tabelas que estão associadas */

SELECT COUNT(*) FROM nome_tabela; /* Calcula a quantidade */

SELECT AVG(coluna) FROM nome_tabela; /* Calcula a média de uma coluna numérica em uma tabela*/

SELECT SUM(coluna) FROM nome_tabela; /* Soma dos valores de uma coluna numérica em uma tabela */

SELECT MAX(coluna) FROM nome_tabela; /* Retorna o valor máximo de um valor específico em uma coluna */

SELECT MIN(coluna) FROM nome_tabela; /* Retorna o valor mínimo de um valor específico em uma coluna */

/* Cláusula WHERE */
SELECT * FROM Nome_tabela WHERE coluna = valor; /* Filtrar resultados com base em condições específicas */

/* Cláusula GROUP BY */
SELECT coluna, COUNT(*) FROM nome_tabela GROUP BY coluna; /* Agrupar os resultados com base em uma ou mais colunas */

/* Exemplo: */
SELECT fabricante, SUM(quantidade) AS 'quantidade de estoque'
from produtos
GROUP BY fabricante 

SELECT tipo, SUM(quantidade * vlunitario) AS 'valor de estoque' /* (as 'valor de estoque') renomeia uma nova tabela para demonstrar o resultado */
from produtos
GROUP BY tipo 

/* Cláusual HAVING */
/* Filtra o retorno do agrupamento*/
SELECT coluna, COUNT(*) FROM tabela GROUP BY coluna HAVING count(*)>5;

/* Comando DISTINCT */
/* Retorna apenas valores únicos em uma consulta */
SELECT DISTINCT coluna FROM tabela;


  /*********************************/
 /* Atividade - Clínica Boa Saúde */
/*********************************/

CREATE database db_clínica_boa_saúde; /* Criar banco de dados */

USE db_clínica_boa_saúde; /* Selecionar o banco de dados a ser usado */

/* Criar tabela Paciente (-codpac-, nome, endereço, telefone) */
CREATE TABLE tbl_Paciente ( 
    Codpac SMALLINT PRIMARY KEY AUTO_INCREMENT, /* Código do paciente, único, gerado automaticamente */
    Nome varchar(50) NOT null, /* Nome do paciente */
    Endereço varchar(50) NOT null, /* Endereço do empregado */
    Telefone varchar(20) NOT null); /* Telefone do empregado */

/* Criar tabela Medico (-crm-, nome, endereço, telefone, especialidade) */
CREATE TABLE tbl_Médico (
    CRM SMALLINT PRIMARY KEY NOT null AUTO_INCREMENT, /* Número do registro do médico, único */
    Nome varchar(50) NOT null, /* Nome do médico */ 
    Endereço varchar(50) NOT null, /* Endereço do médico */
    Telefone varchar(20) NOT null, /* Telefone do médico */
    Especialidade varchar(50) NOT null); /* Qual a especialidade do médico (Pediatria, Obtestricia, etc...) */

/* Criar a tabela Convenio (-codconv-, nome) */
CREATE TABLE tbl_Convenio (
    Codconv SMALLINT PRIMARY KEY NOT null AUTO_INCREMENT, /* Código do convenio, único */
    Nome varchar(50) NOT null); /* Nome do convênio */


/* Criar tabela Consulta (-codconsulta-, data, horário, medico, paciente, convenio, porcent) */
CREATE TABLE tbl_Consulta (
    Codconsulta SMALLINT PRIMARY KEY NOT null AUTO_INCREMENT, /* Código da consulta, único, gerado automaticamente */
    Dt_consulta date NOT null, /* Data da consulta */ 
    Horario time NOT null, /* Horário da consulta */
    Medico SMALLINT NOT null, /* Busca chave estrangeira - Código do médico que realizou a consulta */
    Paciente SMALLINT NOT null, /* Busca chave estrangeira - Código do paciente que recebeu a consulta */
    Convenio SMALLINT NOT null, /* Busca chave estrangeira - Código do convenio pelo qual foi feita a consulta */
    Porcent decimal NOT null, /* Porcentagem que o convênio paga da consulta */
    FOREIGN KEY (Medico) REFERENCES tbl_Médico (CRM) ON UPDATE CASCADE ON DELETE CASCADE,  /* Chave estrangeira - Identifica médico e atualiza as demais chaves associadas. */
    FOREIGN KEY (Paciente) REFERENCES tbl_paciente (codpac) ON UPDATE CASCADE ON DELETE CASCADE, /* Chave estrangeira - Identifica paciente e atualiza as demais chaves associadas. */
    FOREIGN KEY (Convenio) REFERENCES tbl_convenio (codconv) ON UPDATE CASCADE ON DELETE CASCADE); /* Chave estrangeira - Identifica convenio e atualiza as demais chaves associadas. */


/* Criar tabela Atende (-medico-, -convenio-) */
CREATE TABLE tbl_atende (
    Medico SMALLINT, /* Busca chave estrangeira - Código do médico */
    Convenio SMALLINT, /* Busca chave estrangeira - Código do convênio */
    FOREIGN KEY (Medico) REFERENCES tbl_Médico (CRM) ON UPDATE CASCADE ON DELETE CASCADE, /* Chave estrangeira - Código do médico */
    FOREIGN KEY (Convenio) REFERENCES tbl_Convenio (Codconv) ON UPDATE CASCADE ON DELETE CASCADE, /* Chave estrangeira - Código do convênio */
    PRIMARY KEY (medico, convenio)); /* Classificando como chave primária composta */

/* Criar tabela Possui (-paciente-, -convenio-, tipo, vencimento) */
CREATE TABLE tbl_possui (
    Paciente SMALLINT NOT null, /* Busca chave estrangeira - Código do paciente */
    Convenio SMALLINT NOT null, /* Busca chave estrangeira - Código do convênio */
    Tipo SMALLINT NOT null, /* Tipo do convênio (E-Enfermaria, S-Standard) */
    Vencimento date NOT null, /* Data de validade do convênio */
    FOREIGN KEY (paciente) REFERENCES tbl_paciente (codpac) ON UPDATE CASCADE ON DELETE CASCADE, /* Chave estrangeira - Identifica paciente e atualiza as demais chaves associadas. */
    FOREIGN KEY (convenio) REFERENCES tbl_convenio (codconv) ON UPDATE CASCADE ON DELETE CASCADE, /* Chave estrangeira - Identifica convenio e atualiza as demais chaves associadas. */
    PRIMARY KEY (paciente, convenio)); /* Classificando como chave primária composta */

/* Preencher tabelas / Inserir valores / Povoar */

/* Inserir valores nas colunas da tabela - tbl_paciente */
INSERT INTO tbl_paciente (codpac, nome, endereço, telefone) VALUES /* Comando para inserção */
(1, 'João', 'Rua 1', '9809-9756'), /* Dados para a 1° Linha */
(2, 'José', 'Rua B', '3621-8978'), /* Dados para a 2° Linha */
(3, 'Maria', 'Rua 10', '4567-9872'), /* Dados para a 3° Linha */
(4, 'Joana', 'Rua J', '3343-9889'); /* Dados para a 4° Linha */

/* Inserir valores nas colunas da tabela - tbl_médico */
INSERT INTO tbl_médico (crm, nome, endereço, telefone, especialidade) VALUES
(18739, 'Elias', 'Rua X', '8738-1221', 'Pediatria'),
(7646, 'Ana', 'Av Z', '7829-1233', 'Obstetricia'),
(39872, 'Pedro', 'Tv H', '9888-2333', 'Oftalmologia');

/* Inserir valores nas colunas da tabela - tbl_convenio */
INSERT INTO tbl_convenio (codconv, nome) VALUES
(189, 'Cassi'),
(232, 'Unimed'),
(454, 'Santa Casa'),
(908, 'Copasa'),
(435, 'São Lucas');

/* Inserir valores nas colunas da tabela - tbl_consulta */
INSERT INTO tbl_consulta (codconsulta, Dt_consulta, horario, medico, paciente, convenio, porcent) VALUES
(1, '2013-05-10', '10:00', 18739, 1, 189, 5),
(2, '2013-05-12', '10:00', 7646, 2, 232, 10),
(3, '2013-05-12', '11:00', 18739, 3, 908, 15),
(4, '2013-05-13', '10:00', 7646, 4, 435, 13),
(5, '2013-05-14', '13:00', 7646, 2, 232, 10),
(6, '2013-05-14', '14:00', 39872, 1, 189, 5);

/* Inserir valores nas colunas da tabela - tbl_atende */
INSERT INTO tbl_atende (medico, convenio) VALUES
(18739, 189),
(18739, 908),
(7646, 232),
(39872, 189);

/* Inserir valores nas colunas da tabela - tbl_possui */
INSERT INTO tbl_possui (paciente, convenio, tipo, vencimento) VALUES
(1, 189, 'E', '2016-12-31'),
(2, 232, 'S', '2014-12-31'),
(3, 908, 'S', '2017-12-31'),
(4, 435, 'E', '2016-12-31'),
(1, 232, 'S', '2016-12-31');

/* Atualização - Endereço do paciente João para 'Rua do Bonde' */
UPDATE tbl_paciente SET endereço = 'Rua do Bonde' WHERE nome = 'João';

/* Atualização - Dados do médico Elias para 'Rua Z' e telefone '9838-7867' */
UPDATE tbl_médico SET endereço = 'Rua Z', telefone = '9838-7867' WHERE nome = 'Elias';
 
 /* Fim - Atividade - Clínica Boa Saúde */
/***************************************/


  /************************/
 /* Atividade - Livraria */
/************************/

/* Cria banco de dados chamado db_Livraria */
CREATE DATABASE db_Livraria;

/* Seleciona para uso, o banco de dados criado */
USE db_Livraria;

/* Cria tabela Autor */
CREATE TABLE tbl_Autor (
    ID_Autor SMALLINT PRIMARY KEY NOT null,
    Nome varchar(50),
    Email varchar(50));

/* Cria tabela Cliente */
CREATE TABLE tbl_Cliente (
    ID_Cliente SMALLINT PRIMARY KEY NOT null,
    Nome varchar(50),
    Telefone varchar(50));

/* Cria tabela Gênero */
CREATE TABLE tbl_Genero (
    ID_Gênero SMALLINT PRIMARY KEY NOT null,
    Descrição varchar(200));

/* Cria tabela Editora */
CREATE TABLE tbl_Editora (
    ID_Editora SMALLINT PRIMARY KEY NOT null,
    Nome varchar(50),
    Telefone varchar(50));

/* Cria tabela Livro */
CREATE TABLE tbl_Livro (
    ID_Livro SMALLINT PRIMARY KEY NOT null,
    Título varchar(100),
    Preço varchar(30),
    Estoque INT,
    ID_Gênero SMALLINT,
    ID_Editora SMALLINT,
    FOREIGN KEY (ID_Gênero) REFERENCES tbl_Genero (ID_Gênero) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ID_Editora) REFERENCES tbl_Editora (ID_Editora) ON UPDATE CASCADE ON DELETE CASCADE);

/* Cria tabela Escreve */
CREATE TABLE tbl_Escreve (
    ID_Livro SMALLINT,
    ID_Autor SMALLINT,
    PRIMARY KEY (ID_Livro, ID_Autor),
    FOREIGN KEY (ID_Livro) REFERENCES tbl_Livro (ID_Livro) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ID_Autor) REFERENCES tbl_Autor (ID_Autor) ON UPDATE CASCADE ON DELETE CASCADE);

/* Cria tabela Venda */
CREATE TABLE tbl_Venda (
    ID_Venda SMALLINT PRIMARY KEY NOT null,
    Datas DATE,
    Total INT,
    ID_Cliente SMALLINT,
    FOREIGN KEY (ID_Cliente) REFERENCES tbl_Cliente (ID_Cliente) ON UPDATE CASCADE ON DELETE CASCADE);

/* Cria tabela Itens_da_venda */
CREATE TABLE tbl_Itens_da_venda(
    ID_Venda SMALLINT NOT null,
    ID_Livro SMALLINT NOT null,
    Qtd SMALLINT,
    Subtotal INT,
    PRIMARY KEY (ID_Venda, ID_Livro),
    FOREIGN KEY (ID_Venda) REFERENCES tbl_Venda (ID_Venda) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ID_Livro) REFERENCES tbl_Livro (ID_Livro) ON UPDATE CASCADE ON DELETE CASCADE);

/* Dados para inserir na tabela Autor: */
INSERT INTO `tbl_Autor` VALUES (1,'Roberto Martins Figueiredo',NULL),
(2,'Daniel Kahneman',NULL),(3,'Hilary Duff',NULL),(4,'Robson Pinheiro',NULL),
(5,'Cecelia Ahern',NULL),(6,'Arlene Einsenberg',NULL),(7,'Sandee Hathaway',NULL),
(8,'Heidi Murkoff',NULL),(9,'Julio Cesar de Barros',NULL),(10,'Maria José Valero',NULL); 

/* Dados para inserir na tabela Cliente: */
INSERT INTO `tbl_Cliente` VALUES (1,'Joao Silva ','1111'),(2,'Maria Cunha','2222'),
(3,'Pedro Aguiar','8888'),(4,'Elaine Luciana','9374'),(5,'Antonio Pereira','3764'),
(6,'Catarina Dias','999'),(7,'Felipe Escolar','8787'),(8,'Nando Caixinha','5478'),
(9,'Pelé Golias','7811'),(10,'Tito Vardones','7489'); 

/* Dados para inserir na tabela Editora: */
INSERT INTO `tbl_Editora` VALUES 
(1,'Um',NULL),(2,'Dois',NULL),(3,'Tres',NULL),(4,'Quatro',NULL),
(5,'Cinco',NULL),(6,'Seis',NULL),(7,'Sete',NULL); 

/* Dados para inserir na tabela Gênero: */
INSERT INTO `tbl_Genero` VALUES (1,'Espiritualismo'),(2,'Infanto Juvenil'),(3,'Economia'),
(4,'Medicina'),(5,'Romance'),(6,'Historia'),(7,'Fantasia'),(8,'Auto Ajuda'),
(9,'Informática'),(10,'Humor'); 

/* Dados para inserir na tabela Livro: */
INSERT INTO `tbl_Livro` VALUES (1,'Pelas Ruas de Calcutá',36.1,5,1,1),
(2,'Devoted - Devoção',27.2,4,2,2),(3,'Rápido e Devagar - Duas Formas de Pensar',43.9,8,3,3),
(4,'Xô, Bactéria! Tire Suas Dúvidas Com Dr. Bactéria',32.7,6,4,4),
(5,'P.s. - Eu Te Amo',23.5,10,5,5),(6,'O Que Esperar Quando Você Está Esperando',37.8,20,4,6),
(7,'As Melhores Frases Em Veja',23.9,0,6,7),(8,'Bichos Monstruosos',24.9,12,2,6),(9,'Casas Mal Assombradas',27.9,0,2,6);

/* Dados para inserir na tabela Escreve: */
INSERT INTO `tbl_Escreve` VALUES (1,1),(2,3),(3,2),(5,5),(6,6),(6,7),(6,8),(7,9),(8,10),(9,10);

/* Dados para inserir na tabela Venda: */
INSERT INTO `tbl_Venda` VALUES (1,'2012-01-01',30,1),(2,'2012-02-02',60,2),
(3,'2012-03-03',90,3),(4,'2012-04-04',120,4),(5,'2012-05-05',50,5),(6,'2012-06-06',600,6),
(7,'2012-07-07',70,7),(8,'2012-08-08',85,8),(9,'2012-09-09',100,9),(11,'2012-11-11',99,1),
(12,'2012-12-12',59,2),(13,'2011-01-02',46,3),(14,'2011-02-01',399,4),(15,'2011-03-04',42,5),
(16,'2011-04-03',79,6),(17,'2011-05-06',130,7),(18,'2011-06-05',245,8),(19,'2011-07-06',19,9);

/* Dados para inserir na tabela Itens da Venda: */
INSERT INTO `tbl_Itens_da_venda` VALUES 
(1,1,1,NULL),(1,2,1,NULL),(2,2,2,NULL),(2,3,1,NULL),(3,4,1,NULL),(4,5,1,NULL),(5,5,1,NULL),(6,5,1,NULL),(7,6,1,NULL),(8,7,2,NULL),(9,8,3,NULL),(10,9,1,NULL),(11,6,1,NULL),
(12,1,1,NULL),(13,4,1,NULL),(14,7,2,NULL),(15,9,1,NULL),(16,3,1,NULL),(17,8,4,NULL),(18,2,1,NULL),(19,4,1),(20,6,1);