-- CRIANDO DATABASE DE EXEMPLO
CREATE DATABASE DB_COMPRESSAO;

USE DB_COMPRESSAO;

-- CRIANDO SCHEMA
CREATE SCHEMA STAGING;

-- CRIANDO TABELA STAGING.NORMAL
CREATE TABLE STAGING.NORMAL
	(
	USER_ID INT,
	PRODUTO VARCHAR(50),
	GENERO CHAR(1),
	IDADE VARCHAR(10),
	OCUPACAO INT,
	CAT_CIDADE CHAR(1),
	MORA_ANOS INT,
	ESTADO_CIVIL VARCHAR(20),
	PROD_CAT_1 INT,
	PROD_CAT_2 INT,
	PROD_CAT_3 INT,
	VAL_COMPRA DECIMAL(10,2),
	GENERO_X_ST_CIVIL VARCHAR(20),
	RESIDENCIA VARCHAR(20)
	);

-- CRIANDO TABELA STAGING.COMPRESSAO_LINHA
CREATE TABLE STAGING.COMPRESSAO_LINHA
	(
	USER_ID INT,
	PRODUTO VARCHAR(50),
	GENERO CHAR(1),
	IDADE VARCHAR(10),
	OCUPACAO INT,
	CAT_CIDADE CHAR(1),
	MORA_ANOS INT,
	ESTADO_CIVIL VARCHAR(20),
	PROD_CAT_1 INT,
	PROD_CAT_2 INT,
	PROD_CAT_3 INT,
	VAL_COMPRA DECIMAL(10,2),
	GENERO_X_ST_CIVIL VARCHAR(20),
	RESIDENCIA VARCHAR(20)
	);

-- CRIANDO TABELA STAGING.COMPRESSAO_PAGINA
CREATE TABLE STAGING.COMPRESSAO_PAGINA
	(
	USER_ID INT,
	PRODUTO VARCHAR(50),
	GENERO CHAR(1),
	IDADE VARCHAR(10),
	OCUPACAO INT,
	CAT_CIDADE CHAR(1),
	MORA_ANOS INT,
	ESTADO_CIVIL VARCHAR(20),
	PROD_CAT_1 INT,
	PROD_CAT_2 INT,
	PROD_CAT_3 INT,
	VAL_COMPRA DECIMAL(10,2),
	GENERO_X_ST_CIVIL VARCHAR(20),
	RESIDENCIA VARCHAR(20)
	);

-- CRIANDO TABELA STAGING.COMPRESSAO_COLUNA
CREATE TABLE STAGING.COMPRESSAO_COLUNA
	(
	USER_ID INT,
	PRODUTO VARCHAR(50),
	GENERO CHAR(1),
	IDADE VARCHAR(10),
	OCUPACAO INT,
	CAT_CIDADE CHAR(1),
	MORA_ANOS INT,
	ESTADO_CIVIL VARCHAR(20),
	PROD_CAT_1 INT,
	PROD_CAT_2 INT,
	PROD_CAT_3 INT,
	VAL_COMPRA DECIMAL(10,2),
	GENERO_X_ST_CIVIL VARCHAR(20),
	RESIDENCIA VARCHAR(20)
	);


-- CARGA DOS DADOS NA TABELA STAGING.NORMAL
BULK INSERT STAGING.NORMAL
FROM 'C:\TEMP\BULK\COMPRESSAO.CSV'
WITH (
	 CODEPAGE = 'ACP',
	 DATAFILETYPE = 'CHAR',
	 FIELDTERMINATOR = ';',
	 ROWTERMINATOR = '\n',
	 MAXERRORS = 0,
	 FIRE_TRIGGERS,
	 FIRSTROW = 2
	 );

-- CARGA DOS DADOS NA TABELA STAGING.COMPRESSAO_LINHA
BULK INSERT STAGING.COMPRESSAO_LINHA
FROM 'C:\TEMP\BULK\COMPRESSAO.CSV'
WITH (
	 CODEPAGE = 'ACP',
	 DATAFILETYPE = 'CHAR',
	 FIELDTERMINATOR = ';',
	 ROWTERMINATOR = '\n',
	 MAXERRORS = 0,
	 FIRE_TRIGGERS,
	 FIRSTROW = 2
	 );

-- CARGA DOS DADOS NA TABELA STAGING.COMPRESSAO_PAGINA
BULK INSERT STAGING.COMPRESSAO_PAGINA
FROM 'C:\TEMP\BULK\COMPRESSAO.CSV'
WITH (
	 CODEPAGE = 'ACP',
	 DATAFILETYPE = 'CHAR',
	 FIELDTERMINATOR = ';',
	 ROWTERMINATOR = '\n',
	 MAXERRORS = 0,
	 FIRE_TRIGGERS,
	 FIRSTROW = 2
	 );

-- CARGA DOS DADOS NA TABELA STAGING.COMPRESSAO_COLUNA
BULK INSERT STAGING.COMPRESSAO_COLUNA
FROM 'C:\TEMP\BULK\COMPRESSAO.CSV'
WITH (
	 CODEPAGE = 'ACP',
	 DATAFILETYPE = 'CHAR',
	 FIELDTERMINATOR = ';',
	 ROWTERMINATOR = '\n',
	 MAXERRORS = 0,
	 FIRE_TRIGGERS,
	 FIRSTROW = 2
	 );


-- VERIFICANDO INFORMA??ES DE ESPA?O EM KB
SELECT
	T.NAME AS ENTIDADE,
	P.ROWS AS REGISTROS,
	SUM(A.TOTAL_PAGES) * 8 AS ESPACO_TOTAL_KB,
	SUM(A.USED_PAGES) * 8 AS ESPACO_USADO_KB,
	(SUM(A.TOTAL_PAGES) - SUM(A.USED_PAGES)) * 8 AS ESPACO_NAO_USADO_KB
FROM SYS.TABLES AS T
INNER JOIN SYS.INDEXES AS I ON T.OBJECT_ID = I.OBJECT_ID
INNER JOIN SYS.PARTITIONS AS P ON I.OBJECT_ID = P.OBJECT_ID AND I.INDEX_ID = P.INDEX_ID
INNER JOIN SYS.ALLOCATION_UNITS AS A ON P.PARTITION_ID = A.CONTAINER_ID
LEFT OUTER JOIN SYS.SCHEMAS AS S ON T.SCHEMA_ID = S.SCHEMA_ID
WHERE
    T.NAME NOT LIKE 'dt%'
    AND T.IS_MS_SHIPPED = 0
    AND I.OBJECT_ID > 255
GROUP BY T.NAME, S.NAME, P.ROWS
ORDER BY REGISTROS DESC;

-- VERIFICANDO INFORMA??ES DE QUANTIDADE DE P?GINAS UTILIZADAS NAS TABELAS
SELECT
	OBJECT_NAME(OBJECT_ID) NOME_TABELA,
	TOTAL_PAGES * 8 PAGES_KB, AU.*
FROM SYS.SYSTEM_INTERNALS_ALLOCATION_UNITS AS AU
INNER JOIN SYS.PARTITIONS AS P ON AU.CONTAINER_ID = P.Partition_ID
WHERE
	OBJECT_ID = OBJECT_ID('STAGING.COMPRESSAO_PAGINA')
	OR OBJECT_ID = OBJECT_ID('STAGING.COMPRESSAO_LINHA')
	OR OBJECT_ID = OBJECT_ID('STAGING.COMPRESSAO_COLUNA')
	OR OBJECT_ID = OBJECT_ID('STAGING.NORMAL')
ORDER BY 1;


-- CRIANDO INDEXES
CREATE INDEX IDX1 ON STAGING.NORMAL (USER_ID);
CREATE INDEX IDX2 ON STAGING.COMPRESSAO_LINHA (USER_ID);
CREATE INDEX IDX3 ON STAGING.COMPRESSAO_PAGINA (USER_ID);
CREATE INDEX IDX4 ON STAGING.COMPRESSAO_COLUNA (USER_ID);

-- ESTIMANDO ESPA?O
EXEC SP_ESTIMATE_DATA_COMPRESSION_SAVINGS 'STAGING', 'COMPRESSAO_LINHA', NULL, NULL, 'ROW';
EXEC SP_ESTIMATE_DATA_COMPRESSION_SAVINGS 'STAGING', 'COMPRESSAO_PAGINA', NULL, NULL, 'PAGE';
EXEC SP_ESTIMATE_DATA_COMPRESSION_SAVINGS 'STAGING', 'COMPRESSAO_COLUNA', NULL, NULL, 'COLUMNSTORE'; -- VERS?O 2019 OU SUPERIOR

-- TESTANTO PERFORMANCE AGREGANDO VALOR POR C?DIGO CLIENTE
-- TABELA STAGING.COMPRESSAO_LINHA
SELECT
	ESTADO_CIVIL,
	COUNT(*)
FROM STAGING.COMPRESSAO_LINHA AS A
GROUP BY ESTADO_CIVIL;
-- TABELA STAGING.COMPRESSAO_PAGINA
SELECT
	ESTADO_CIVIL,
	COUNT(*)
FROM STAGING.COMPRESSAO_PAGINA AS A
GROUP BY ESTADO_CIVIL;
-- TABELA STAGING.COMPRESSAO_COLUNA
SELECT
	ESTADO_CIVIL,
	COUNT(*)
FROM STAGING.COMPRESSAO_COLUNA AS A
GROUP BY ESTADO_CIVIL;


-- COMPRIMINDO
ALTER TABLE STAGING.COMPRESSAO_LINHA REBUILD PARTITION = ALL WITH(DATA_COMPRESSION = ROW); -- LINHA
ALTER TABLE STAGING.COMPRESSAO_PAGINA REBUILD PARTITION = ALL WITH(DATA_COMPRESSION = PAGE); -- P?GINA
-- RECRIANDO ?NDICES COM COMPRESS?O
ALTER INDEX IDX2 ON STAGING.COMPRESSAO_LINHA REBUILD WITH(DATA_COMPRESSION=ROW); -- LINHA
ALTER INDEX IDX3 ON STAGING.COMPRESSAO_PAGINA REBUILD WITH(DATA_COMPRESSION=PAGE); -- P?GINA
-- CRIANDO COLUMNSTORE
CREATE CLUSTERED COLUMNSTORE INDEX IDX4 ON STAGING.COMPRESSAO_COLUNA
       WITH ( DATA_COMPRESSION = COLUMNSTORE,
              DROP_EXISTING = ON);


-- VERIFICANDO INFORMA??ES DE ESPA?O EM KB
SELECT
	T.NAME AS ENTIDADE,
	P.ROWS AS REGISTROS,
	SUM(A.TOTAL_PAGES) * 8 AS ESPACO_TOTAL_KB,
	SUM(A.USED_PAGES) * 8 AS ESPACO_USADO_KB,
	(SUM(A.TOTAL_PAGES) - SUM(A.USED_PAGES)) * 8 AS ESPACO_NAO_USADO_KB
FROM SYS.TABLES AS T
INNER JOIN SYS.INDEXES AS I ON T.OBJECT_ID = I.OBJECT_ID
INNER JOIN SYS.PARTITIONS AS P ON I.OBJECT_ID = P.OBJECT_ID AND I.INDEX_ID = P.INDEX_ID
INNER JOIN SYS.ALLOCATION_UNITS AS A ON P.PARTITION_ID = A.CONTAINER_ID
LEFT OUTER JOIN SYS.SCHEMAS AS S ON T.SCHEMA_ID = S.SCHEMA_ID
WHERE
    T.NAME NOT LIKE 'dt%'
    AND T.IS_MS_SHIPPED = 0
    AND I.OBJECT_ID > 255
GROUP BY T.NAME, S.NAME, P.ROWS
ORDER BY REGISTROS DESC;

-- VERIFICANDO INFORMA??ES DE QUANTIDADE DE P?GINAS UTILIZADAS NAS TABELAS
SELECT
	OBJECT_NAME(OBJECT_ID) NOME_TABELA,
	TOTAL_PAGES * 8 PAGES_KB, AU.*
FROM SYS.SYSTEM_INTERNALS_ALLOCATION_UNITS AS AU
INNER JOIN SYS.PARTITIONS AS P ON AU.CONTAINER_ID = P.Partition_ID
WHERE
	OBJECT_ID = OBJECT_ID('STAGING.COMPRESSAO_PAGINA')
	OR OBJECT_ID = OBJECT_ID('STAGING.COMPRESSAO_LINHA')
	OR OBJECT_ID = OBJECT_ID('STAGING.COMPRESSAO_COLUNA')
	OR OBJECT_ID = OBJECT_ID('STAGING.NORMAL')
ORDER BY 1;