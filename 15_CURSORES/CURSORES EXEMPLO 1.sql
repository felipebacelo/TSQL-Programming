USE SALES;

-- CURSORES (EXEMPLO 1 - SELECT)

-- DECLARANDO VARI�VEIS
DECLARE @MINHA_VARIAVEL VARCHAR(100),
		@ID_PROD INT
-- DECLARANDO CURSOR
DECLARE MEU_CURSOR1
CURSOR LOCAL FOR SELECT ID_PROD, NOME_PRODUTO FROM PRODUTOS
-- ABRINDO CURSOR
OPEN MEU_CURSOR1
-- LENDO A PR�XIMA LINHA
FETCH NEXT FROM MEU_CURSOR1 INTO @ID_PROD, @MINHA_VARIAVEL
-- PERCORRENDO LINHAS DO CURSOR (ENQUANTO HOUVEREM)
WHILE @@FETCH_STATUS = 0
	BEGIN
	PRINT CAST(@ID_PROD AS VARCHAR(10)) + ' - ' + @MINHA_VARIAVEL + ' FETCH_STATUS -> ' + CAST(@@FETCH_STATUS AS VARCHAR(10))
-- LENDO A PR�XIMA LINHA
	FETCH NEXT FROM MEU_CURSOR1 INTO @ID_PROD, @MINHA_VARIAVEL
	END
	PRINT 'FETCH_STATUS -> ' + CAST(@@FETCH_STATUS AS VARCHAR(10))
-- FECHANDO CURSOR
CLOSE MEU_CURSOR1
-- FINALIZANDO CURSOR
DEALLOCATE MEU_CURSOR1