/* PRIMEIRA FORMA NORMAL

REGRAS:
1. TODO CAMPO VETORIZADO SE TORNARÁ OUTRA TABELA.
2. TODO CAMPO MULTIVALORADO SE TORNARÁ OUTRA TABELA.
QUANTO O CAMPO FOR DIVISÍVEL.
3. TODA TABELA NECESSITA DE PELO MENOS UM CAMPO QUE IDENTIFIQUE
TODO O REGISTRO COMO SENDO ÚNICO. ISSO É O QUE CHAMAMOS DE CHAVE PRIMÁRIA
OU PRIMARY KEY. -> A CHAVE PRIMÁRIA IDENTIFICA UM REGISTRO INTEIRO (LINHA) COMO SENDO ÚNICO.
EXISTEM DOIS TIPOS DE CHAVES:
-> NATURAL - PERTENCE A ALGO NATURALMENTE (EX: CPF)
-> ARTIFICIAL - PERTENCE A ALGO ARTIFICIALMENTE (EX: ID)


NO EXEMPLO DA TABELA CLIENTE, TELEFONE É UM CAMPO MULTIVALORADO E ENDEREÇO TAMBÉM, ENTÃO
SÃO TABELAS DIFERENTES, ONDE CLIENTE POSSUI TELEFONE E CLIENTE POSSUI ENDEREÇO.
-> QUEM DEFINE A CARDINALIDADE É A REGRA DE NEGÓCIO

EXEMPLO:
ESTAMOS NO INÍCIO DA MODELAGEM PARA UM SISTEMA E O NOSSO GESTOR NOS PEDIU A MODELAGEM DA TABELA
DE CLIENTES COM A SEGUINTE REGRA DE NEGÓCIO:
ENDERECO - OBRIGATÓRIO O CADASTRO DE UM ENDERECO (NO MÁXIMO 1). (1, 1)
TELEFONE - O CLIENTE NÃO É OBRIGADO A INFORMAR TELEFONE (0, N)
POREM, CASO QUEIRA, ELE PODE INFORMAR MAIS DE UM.

> CARDINALIDADE:
(0,N)
(0,1)
(1,N)
(1,1)
A PRIMEIRA COLUNA: OBRIGATORIEDADE (SE 0 É FALSO, SE 1 É VERDADEIRO)
A SEGUNDA COLUNA: CARDINALIDADE (CARDINALIDADE DEFINE O MÁXIMO: 1 OU MAIS DE 1)

> O ENDEREÇO PRECISA TER CLIENTE? SIM (1) - OBRIGATORIO
> QUANTOS CLIENTES PERTENCEM AO UM ENDEREÇO? 1 (1) - CARDINALIDADE
(1,1)

O RELACIONAMENTO DE CLIENTE E ENDEREÇO É 1X1, POIS UM CLIENTE PERTENCE A UM ENDEREÇO E É OBRIGATÓRIO UM CADASTRO DE ENDEREÇO.
A CARDINALIDADE DE ENDEREÇO É (1,1) E DE CLIENTE É (1,1), LOGO SELECIONA A SEGUNDA COLUNA DE CADA CARDINALIDADE.
ENTÃO, É UM RELACIONAMENTO DE 1 PARA 1.

 */

CREATE DATABASE COMERCIO;
USE COMERCIO;
SHOW DATABASES;

DROP TABLE CLIENTE; -- APAGAR CLIENTE

CREATE TABLE CLIENTE (
	IDCLIENTE INT PRIMARY KEY AUTO_INCREMENT,  -- INCREMENTAR O IDCLIENTE. PK POSSUI VALORES EXCLUSIVOS POR TODA A TABELA.
	NOME VARCHAR (30) NOT NULL,  -- COLUNA NÃO PODE SER NULA 
	SEXO ENUM('M', 'F') NOT NULL, -- ENUM SÓ EXISTE EM MYSQL
	EMAIL VARCHAR(50) UNIQUE, -- EMAIL UNICOM NÃO PODE SE REPETIR
	CPF VARCHAR(15) UNIQUE
);

CREATE TABLE ENDERECO (
	IDENDERECO INT PRIMARY KEY AUTO_INCREMENT,
	RUA VARCHAR (30) NOT NULL,
	BAIRRO VARCHAR (30) NOT NULL,
	CIDADE VARCHAR (30) NOT NULL,
	ESTADO CHAR(2) NOT NULL,
	ID_CLIENTE INT UNIQUE, -- POIS O TIPO DA CHAVE PRIMARIA DE CLIENTE É INT. UNIQUE, POIS O RELACIONAMENTO É DE 1X1.
	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);

CREATE TABLE TELEFONE (
	IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT,
	TIPO ENUM('RES','COM','CEL') NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_CLIENTE INT,
	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);

/* ENDERECO - OBRIGATÓRIO
CADASTRO DE SOMENTE UM.
TELEFONE - NÃO OBRIGATÓRIO
CADASTRO DE MAIS DE UM (OPCIONAL)*/

-- FOREIGN KEY (FK)--
/*É A CHAVE PRIMÁRIA DE UMA TABELA QUE VAI ATÉ OUTRA
TABELA PARA FAZER REFERÊNCIA ENTRE REGISTROS. */

/* 
-> EM RELACIONAMENTO 1 X 1 A CHAVE ESTRANGEIRA FICA NA TABELA MAIS FRACA
-> EM RELACIONAMENTO 1 X N A CHAVE ESTRANGEIRA SEMPRE FICARÁ NA CARDINALIDADE N
*/

DESC CLIENTE; -- SABER COMO A TABELA FOI FORMADA
INSERT INTO CLIENTE VALUES(NULL, 'JOÃO ALMEIDA', 'M', 'JOAOGUI@GMAIL.COM', '438473864');  -- O NULL: PARA O PRÓPRIO SISTEMA INCREMENTAR
INSERT INTO CLIENTE VALUES(NULL, 'CLARA RUIZ', 'F', 'CLARARUIZ@GMAIL.COM', '756533864');
INSERT INTO CLIENTE VALUES(NULL, 'LUCAS PEDRO', 'M', NULL, '9877233864');
INSERT INTO CLIENTE VALUES(NULL, 'TONI ALMEIDA', 'M', 'TONI@GMAIL.COM', '4092223864');
INSERT INTO CLIENTE VALUES(NULL, 'IAGO ABAX', 'M', 'IGO@GMAIL.COM', '232313864');
INSERT INTO CLIENTE VALUES(NULL, 'LUNA CALS', 'F', 'LUNA@GMAIL.COM', '1212123864');

SELECT * FROM CLIENTE;

+-----------+--------------+------+---------------------+------------+
| IDCLIENTE | NOME         | SEXO | EMAIL               | CPF        |
+-----------+--------------+------+---------------------+------------+
|         1 | JOÃO ALMEIDA | M    | JOAOGUI@GMAIL.COM   | 438473864  |
|         2 | CLARA RUIZ   | F    | CLARARUIZ@GMAIL.COM | 756533864  |
|         3 | LUCAS PEDRO  | M    | NULL                | 9877233864 |
|         4 | TONI ALMEIDA | M    | TONI@GMAIL.COM      | 4092223864 |
|         5 | IAGO ABAX    | M    | IGO@GMAIL.COM       | 232313864  |
|         6 | LUNA CALS    | F    | LUNA@GMAIL.COM      | 1212123864 |
+-----------+--------------+------+---------------------+------------+

INSERT INTO ENDERECO VALUES(NULL, 'ANTONIO SÁ', 'CENTRO', 'BELO HORIZONTE', 'MG', 4);
INSERT INTO ENDERECO VALUES(NULL, 'DO VALE', 'RENASCENÇA', 'SÃO LUÍS', 'MA', 1);
INSERT INTO ENDERECO VALUES(NULL, 'DOM QUIXOTE', 'FLORES', 'SÃO PAULO', 'SP', 2);
INSERT INTO ENDERECO VALUES(NULL, 'DA VILLA', 'CENTRO', 'NITERÓI', 'RJ', 3);
INSERT INTO ENDERECO VALUES(NULL, 'ANTONIO SÁ', 'CENTRO', 'BELO HORIZONTE', 'MG', 5);
INSERT INTO ENDERECO VALUES(NULL, 'AUGUSTO', 'NIVEA', 'SÃO JOSÉ DOS CAMPOS', 'PR', 6);

+------------+-------------+------------+---------------------+--------+------------+
| IDENDERECO | RUA         | BAIRRO     | CIDADE              | ESTADO | ID_CLIENTE |
+------------+-------------+------------+---------------------+--------+------------+
|          1 | ANTONIO SÁ  | CENTRO     | BELO HORIZONTE      | MG     |          4 |
|          2 | DO VALE     | RENASCENÇA | SÃO LUÍS            | MA     |          1 |
|          3 | DOM QUIXOTE | FLORES     | SÃO PAULO           | SP     |          2 |
|          4 | DA VILLA    | CENTRO     | NITERÓI             | RJ     |          3 |
|          5 | ANTONIO SÁ  | CENTRO     | BELO HORIZONTE      | MG     |          5 |
|          6 | AUGUSTO     | NIVEA      | SÃO JOSÉ DOS CAMPOS | PR     |          6 |
+------------+-------------+------------+---------------------+--------+------------+

INSERT INTO TELEFONE VALUES(NULL, 'CEL', '87834394', 5);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '92831232', 5);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '94232032', 1);
INSERT INTO TELEFONE VALUES(NULL, 'CEL', '32038922', 2);
INSERT INTO TELEFONE VALUES(NULL, 'COM', '12782378', 3);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '34243121', 2);

+------------+------+----------+------------+
| IDTELEFONE | TIPO | NUMERO   | ID_CLIENTE |
+------------+------+----------+------------+
|          1 | CEL  | 87834394 |          5 |
|          2 | RES  | 92831232 |          5 |
|          3 | RES  | 94232032 |          1 |
|          4 | CEL  | 32038922 |          2 |
|          5 | COM  | 12782378 |          3 |
|          6 | RES  | 34243121 |          2 |
+------------+------+----------+------------+

/* SELECAO, PROJECAO E JUNCAO */

/* PROJECAO -> É TUD QUE VOCÊ QUER VER NA TELA ( SELECT * FROM ... ) */
SELECT NOW() AS DATA_ATUAL;
SELECT 2 + 2 AS SOMA;
SELECT 2 + 2 AS SOMA, NOME, NOW()
FROM CLIENTE;
-- Exemplo: 'quero o nome, sexo, tipo, telefone, bairro'
-- SELECT NOME, SEXO, TIPO, TELEFONE, BAIRRO

/* SELECAO -> É UM SUBCONJUNTO DO CONJUNTO TOTAL DE REGISTROS DE UMA TABELA
A CLÁUSULA DE SELEÇÃO É O WHERE*/
-- Exemplo: trazer nome e email das mulheres
SELECT NOME, SEXO, EMAIL  -- PROJECAO
FROM CLIENTE  -- ORIGEM
WHERE SEXO = 'F';  -- SELECAO

SELECT NUMERO
FROM TELEFONE
WHERE TIPO = 'CEL';

/* JUNCAO -> JOIN */  -- JUNTAR TABELAS
SELECT NOME, EMAIL, IDCLIENTE
FROM CLIENTE;
+--------------+---------------------+-----------+
| NOME         | EMAIL               | IDCLIENTE |
+--------------+---------------------+-----------+
| JOÃO ALMEIDA | JOAOGUI@GMAIL.COM   |         1 |
| CLARA RUIZ   | CLARARUIZ@GMAIL.COM |         2 |
| LUCAS PEDRO  | NULL                |         3 |
| TONI ALMEIDA | TONI@GMAIL.COM      |         4 |
| IAGO ABAX    | IGO@GMAIL.COM       |         5 |
| LUNA CALS    | LUNA@GMAIL.COM      |         6 |
+--------------+---------------------+-----------+

SELECT ID_CLIENTE, BAIRRO, CIDADE
FROM ENDERECO;
+------------+------------+---------------------+
| ID_CLIENTE | BAIRRO     | CIDADE              |
+------------+------------+---------------------+
|          4 | CENTRO     | BELO HORIZONTE      |
|          1 | RENASCENÇA | SÃO LUÍS            |
|          2 | FLORES     | SÃO PAULO           |
|          3 | CENTRO     | NITERÓI             |
|          5 | CENTRO     | BELO HORIZONTE      |
|          6 | NIVEA      | SÃO JOSÉ DOS CAMPOS |
+------------+------------+---------------------+

/* NOME, SEXO, BAIRRO, CIDADE */

-- NÃO RECOMENDADO
SELECT NOME, SEXO, BAIRRO, CIDADE -- PROJECAO
FROM CLIENTE, ENDERECO -- ORIGEM
WHERE IDCLIENTE = ID_CLIENTE; -- JUNCAO

+--------------+------+------------+---------------------+
| NOME         | SEXO | BAIRRO     | CIDADE              |
+--------------+------+------------+---------------------+
| JOÃO ALMEIDA | M    | RENASCENÇA | SÃO LUÍS            |
| CLARA RUIZ   | F    | FLORES     | SÃO PAULO           |
| LUCAS PEDRO  | M    | CENTRO     | NITERÓI             |
| TONI ALMEIDA | M    | CENTRO     | BELO HORIZONTE      |
| IAGO ABAX    | M    | CENTRO     | BELO HORIZONTE      |
| LUNA CALS    | F    | NIVEA      | SÃO JOSÉ DOS CAMPOS |
+--------------+------+------------+---------------------+

/* WHERE - SELECAO */
-- NÃO RECOMENDADO
SELECT NOME, SEXO, BAIRRO, CIDADE
FROM CLIENTE, ENDERECO
WHERE IDCLIENTE = ID_CLIENTE  -- SEMPRE IRÁ VERIFICAR PRIMEIRO O IDCLIENTE = ID_CLIENTE, MAS SEMPRE DARÁ TRUE
AND SEXO = 'F';

/* INNER JOIN */
SELECT NOME, SEXO, BAIRRO, CIDADE
FROM CLIENTE
	INNER JOIN ENDERECO
	ON IDCLIENTE = ID_CLIENTE;
+--------------+------+------------+---------------------+
| NOME         | SEXO | BAIRRO     | CIDADE              |
+--------------+------+------------+---------------------+
| JOÃO ALMEIDA | M    | RENASCENÇA | SÃO LUÍS            |
| CLARA RUIZ   | F    | FLORES     | SÃO PAULO           |
| LUCAS PEDRO  | M    | CENTRO     | NITERÓI             |
| TONI ALMEIDA | M    | CENTRO     | BELO HORIZONTE      |
| IAGO ABAX    | M    | CENTRO     | BELO HORIZONTE      |
| LUNA CALS    | F    | NIVEA      | SÃO JOSÉ DOS CAMPOS |
+--------------+------+------------+---------------------+

SELECT NOME, SEXO, BAIRRO, CIDADE -- PROJECAO
FROM CLIENTE -- ORIGEM
	INNER JOIN ENDERECO -- JUNCAO
	ON IDCLIENTE = ID_CLIENTE 
WHERE SEXO = 'F'; -- SELECAO
+------------+------+--------+---------------------+
| NOME       | SEXO | BAIRRO | CIDADE              |
+------------+------+--------+---------------------+
| CLARA RUIZ | F    | FLORES | SÃO PAULO           |
| LUNA CALS  | F    | NIVEA  | SÃO JOSÉ DOS CAMPOS |
+------------+------+--------+---------------------+

/* NOME, SEXO, EMAIL, TIPO, NUMERO */
SELECT NOME, SEXO, EMAIL, TIPO, NUMERO
FROM CLIENTE
	INNER JOIN TELEFONE
	ON IDCLIENTE = ID_CLIENTE;

-- INNER JOIN - JUNÇÃO DE TABELAS
/* NOME, SEXO, BAIRRO, CIDADE, TIPO, NUMERO */

SELECT CLIENTE.NOME, CLIENTE.SEXO, ENDERECO.BAIRRO, ENDERECO.CIDADE, TELEFONE.TIPO, TELEFONE.NUMERO
FROM CLIENTE
INNER JOIN ENDERECO
ON CLIENTE.IDCLIENTE = ENDERECO.ID_CLIENTE
INNER JOIN TELEFONE
ON CLIENTE.IDCLIENTE = TELEFONE.ID_CLIENTE;

+--------------+------+------------+----------------+------+----------+
| NOME         | SEXO | BAIRRO     | CIDADE         | TIPO | NUMERO   |
+--------------+------+------------+----------------+------+----------+
| JOÃO ALMEIDA | M    | RENASCENÇA | SÃO LUÍS       | RES  | 94232032 |
| CLARA RUIZ   | F    | FLORES     | SÃO PAULO      | RES  | 34243121 |
| CLARA RUIZ   | F    | FLORES     | SÃO PAULO      | CEL  | 32038922 |
| LUCAS PEDRO  | M    | CENTRO     | NITERÓI        | COM  | 12782378 |
| IAGO ABAX    | M    | CENTRO     | BELO HORIZONTE | RES  | 92831232 |
| IAGO ABAX    | M    | CENTRO     | BELO HORIZONTE | CEL  | 87834394 |
+--------------+------+------------+----------------+------+----------+

/* MAIS COMUM - PONTEIRAMENTO. [AJUDA NA PERFORMANCE]*/
SELECT C.NOME, C.SEXO, E.BAIRRO, E.CIDADE, T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.CLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

/* COMANDOS DE DML - DATA MANIPULATION LANGUAGE
DDL - DATA DEFINITION LANGUAGE
DCL - DATA CONTROL LANGUAGE
TCL - TRANSACTION CONTROL LANGUAGE
*/
-- DML
/* INSERT */
INSERT INTO CLIENTE VALUES(NULL, 'PAULA', 'M', NULL, '777545335');
INSERT INTO ENDERECO VALUES(NULL, 'RUA JOAQUIM', 'ALVORADA', 'NITEROI', 'RJ', '7');

/* FILTROS */
SELECT * FROM CLIENTE
WHERE SEXO = 'M';

/* UPDATE */
-- VERIFICANDO SE IREI ALTERAR O CORRETO
SELECT * FROM CLIENTE
WHERE IDCLIENTE = 7;
--
UPDATE CLIENTE
SET SEXO = 'F'
WHERE IDCLIENTE = 7;

/* DELETE */
INSERT INTO CLIENTE VALUES(NULL, 'XXX', 'M', NULL, 'XXX');

SELECT CLIENTE, IDCLIENTE FROM CLIENTE
WHERE IDCLIENTE = 8;

DELETE FROM CLIENTE WHERE IDCLIENTE = 8;

-- DDL

CREATE TABLE PRODUTO(
	IDPRODUTO INT PTIMARY KEY AUTO_INCREMENT,
	NOME_PRODUTO VARCHAR(30) NOT NULL,
	PRECO INT,
	FRETE FLOAT(10, 2) NOT NULL
);

/* ALTER TABLE 
ALTERANDO O NOME DE UMA COLUNA - CHANGE */

ALTER TABLE PRODUTO
CHANGE PRECO VALOR_UNITARIO INT NOT NULL;  -- ALTERANDO O NOME

ALTER TABLE PRODUTO
CHANGE VALOR_UNITARIO VALOR_UNITARIO INT;  -- ALTERANDO O TIPO

/* MODIFY */
ALTER TABLE PRODUTO
MODIFY VALOR_UNITARIO VARCHAR(50) NOT NULL;  -- ALTERANDO O TIPO

/* ADICIONANDO COLUNAS */
ALTER TABLE PRODUTO
ADD PESO FLOAT(10, 2) NOT NULL;

/* APAGANDO UMA COLUNA */
ALTER TABLE PRODUTO
DROP COLUMN PESO;

/* ADICIONANDO COLUNA EM ORDEM ESPECÍFICA */ -- FUNÇÃO DO MYSQL
-- AFTER - DEPOIS DE UMA COLUNA ESPECÍFICA
ALTER TABLE PRODUTO
ADD COLUMN PESO FLOAT(10, 2) NOT NULL
AFTER NOME_PRODUTO;

-- FIRST - ANTES DE UMA COLUNA ESPECÍFICA
ALTER TABLE PRODUTO
ADD COLUMN PESO FLOAT(10, 2) NOT NULL
FIRST;