USE SALES;

-- CURSORES (EXEMPLO 3 - INSERT)

-- CRIANDO TABELA CADASTRO PARA EXEMPLO
CREATE TABLE CADASTRO
	(
	ID_CLIENTE INT NOT NULL PRIMARY KEY,
	NOME_CLIENTE VARCHAR(50) NOT NULL,
	ENDERECO_COMPLETO VARCHAR(150) NOT NULL
	);
-- VERIFICANDO DADOS
SELECT * FROM CADASTRO;
-- DECLARANDO VARI�VEIS
DECLARE @ID_CLIENTE INT,
		@NOME_CLIENTE VARCHAR(50),
		@ENDERECO VARCHAR(150),
		@NUMERO VARCHAR(10),
		@ENDERECO_COMPLETO VARCHAR(150)
-- DECLARANDO CURSOR
DECLARE MEU_CURSOR3
CURSOR FOR SELECT ID_CLIENTE,
				  NOME_CLIENTE,
				  ENDERECO,
				  NUMERO
FROM CLIENTE
-- ABRINDO CURSOR
OPEN MEU_CURSOR3
-- LENDO A PR�XIMA LINHA
FETCH NEXT FROM MEU_CURSOR3 INTO @ID_CLIENTE, @NOME_CLIENTE, @ENDERECO, @NUMERO
-- PERCORRENDO LINHAS DO CURSOR (ENQUANTO HOUVEREM)
WHILE @@FETCH_STATUS = 0
	BEGIN
	SET @ENDERECO_COMPLETO = @ENDERECO + ', ' + @NUMERO
	INSERT INTO CADASTRO VALUES (@ID_CLIENTE, @NOME_CLIENTE, @ENDERECO_COMPLETO)
-- LENDO A PR�XIMA LINHA
	FETCH NEXT FROM MEU_CURSOR3 INTO @ID_CLIENTE, @NOME_CLIENTE, @ENDERECO, @NUMERO
	END
-- FECHANDO CURSOR
CLOSE MEU_CURSOR3
-- FINALIZANDO CURSOR
DEALLOCATE MEU_CURSOR3
-- VERIFICANDO DADOS
SELECT * FROM CADASTRO;
-- EXCLUINDO TABELA CADASTRO CRIADA PARA EXEMPLO
DROP TABLE CADASTRO;