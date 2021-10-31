USE SALES;

-- OPENROWSET
-- INCLUI TODAS AS INFORMA��ES DE CONEX�O EXIGIDAS PARA ACESSAR DADOS REMOTOS DE UMA FONTE DE DADOS OLE DB.
-- ESTE M�TODO � UMA ALTERNATIVA PARA ACESSAR TABELAS EM UM SERVIDOR VINCULADO E SE TRATA DE UM M�TODO DE USO �NICO E AD HOC PARA CONEX�O E ACESSO A DADOS REMOTOS POR MEIO DE OLE DB.
-- A FUN��O OPENROWSET PODE SER REFERENCIADA NA CL�USULA FROM DE UMA CONSULTA COMO SE FOSSE UM NOME DE TABELA.
-- A FUN��O OPENROWSET TAMB�M PODE SER REFERENCIADA COMO A TABELA DE DESTINO DE UMA INSTRU��O INSERT, UPDATE OU DELETE, SUJEITO �S FUNCIONALIDADES DO PROVEDOR OLE DB.
-- EMBORA A CONSULTA POSSA RETORNAR V�RIOS CONJUNTOS DE RESULTADOS, OPENROWSET RETORNA SOMENTE O PRIMEIRO DELES.

-- EXEMPLO

-- CONFIGURA��O PARA ATIVAR AD HOC DISTRIBU�DA
SP_CONFIGURE 'SHOW ADVANCED OPTIONS', 1;
RECONFIGURE;
SP_CONFIGURE 'AD HOC DISTRIBUTED QUERIES', 1;
RECONFIGURE;

-- CONFIGURA��O PARA DESATIVAR AD HOC DISTRIBU�DA
SP_CONFIGURE 'SHOW ADVANCED OPTIONS', 0;
RECONFIGURE;
SP_CONFIGURE 'AD HOC DISTRIBUTED QUERIES', 0;
RECONFIGURE;

-- OPENROWSET (SELECT)
SELECT * FROM
OPENROWSET ('SQLNCLI', 'SERVER = FELIPEBACELO\SQLEXPRESS; TRUSTED_CONNECTION = YES;', 
			'SELECT * FROM SALES.DBO.ESTOQUE');

-- OPENROWSET (INSERT)
INSERT OPENROWSET ('SQLNCLI', 'SERVER = FELIPEBACELO\SQLEXPRESS; TRUSTED_CONNECTION = YES;', 
				   'SELECT * FROM SALES.DBO.ESTOQUE') VALUES (21, 'SCANNER', 250);

-- OPENROWSET (UPDATE)
UPDATE OPENROWSET ('SQLNCLI', 'SERVER = FELIPEBACELO\SQLEXPRESS; TRUSTED_CONNECTION = YES;', 
				   'SELECT * FROM SALES.DBO.ESTOQUE WHERE ID_PROD = 21')
SET PRECO = 300;

-- OPENROWSET (DELETE)
DELETE OPENROWSET ('SQLNCLI', 'SERVER = FELIPEBACELO\SQLEXPRESS; TRUSTED_CONNECTION = YES;', 
				   'SELECT * FROM SALES.DBO.ESTOQUE WHERE ID_PROD = 21');