USE SALES;

-- FUN��ES ESCALARES (SCALAR-VALUED USER DEFINED FUNCTION)
-- AS FUN��ES ESCALARES DEFINIDAS PELO USU�RIO RETORNAM UM VALOR �NICO DE DADO DO TIPO DEFINIDO NA CL�USULA RETURNS.
-- PARA UMA FUN��O ESCALAR EMBUTIDA, N�O H� UM CORPO DE FUN��O, O VALOR ESCALAR � O RESULTADO DE UMA �NICA INSTRU��O.
-- PARA UMA FUN��O ESCALAR DE V�RIAS INSTRU��ES, O CORPO DA FUN��O, DEFINIDO EM UM BLOCO BEGIN...END, CONT�M UMA S�RIE DE INSTRU��ES TSQL, QUE RETORNAM O VALOR �NICO.
-- O TIPO DE RETORNO PODE SER QUALQUER TIPO DE DADO, EXCETO TEXT, NTEXT, IMAGE, CURSOR E TIMESTAMP.

-- EXEMPLO 1
-- CRIANDO FUN��O
CREATE FUNCTION FN_TRIM(@STRING VARCHAR(200))
	RETURNS VARCHAR(200)
		BEGIN
			RETURN(LTRIM(RTRIM(@STRING)))
		END;
-- CHAMANDO FUN��O
SELECT '>' + ('     SQL     ') + '<'
UNION
SELECT '>' + DBO.FN_TRIM('     SQL     ') + '<';
-- ALTERANDO FUN��O
ALTER FUNCTION FN_TRIM(@STRING VARCHAR(400))
	RETURNS VARCHAR(400)
		BEGIN
			RETURN(LTRIM(RTRIM(@STRING)))
		END;
-- APAGANDO FUN��O
DROP FUNCTION FN_TRIM;


-- EXEMPLO 2
-- CRIANDO FUN��O
CREATE FUNCTION FN_SUM(@NUM1 INT, @NUM2 INT)
	RETURNS INT
		BEGIN
			DECLARE @RESULTADO INT
			SET @RESULTADO = @NUM1 + @NUM2
			RETURN(@RESULTADO)
		END;
-- CHAMANDO FUN��O
SELECT 'O RESULTADO �:', DBO.FN_SUM(10,40);
-- CRIANDO TABELA
CREATE TABLE #TESTE_SUM
		(
		VALOR1 INT,
		VALOR2 INT
		);
-- INSERINDO VALORES
INSERT INTO #TESTE_SUM VALUES (1, 10), (2, 10), (3, 10);
-- CHAMANDO FUN��O
SELECT VALOR1,
	   VALOR2,
	   DBO.FN_SUM(VALOR1, VALOR2) AS RESULTADO
FROM #TESTE_SUM;
-- APAGANDO FUN��O
DROP FUNCTION FN_SUM;