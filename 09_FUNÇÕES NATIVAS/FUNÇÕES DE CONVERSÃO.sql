DECLARE @VALOR DECIMAL(5,2);
SET @VALOR = 155.75;

-- CAST (CONVERTE UMA EXPRESS?O DE UM TIPO DE DADOS EM OUTRO)
-- CAST (EXEMPLO 1)
SELECT CAST(@VALOR AS VARBINARY(20));

-- CAST (EXEMPLO 2)
SELECT CAST(CAST(@VALOR AS VARBINARY(20)) AS DECIMAL(5,2));


-- CONVERT (CONVERTE UMA EXPRESS?O DE UM TIPO DE DADOS EM OUTRO)
-- CONVERT (EXEMPLO 1)
SELECT CONVERT(VARBINARY(20), @VALOR);

-- CONVERT (EXEMPLO 2)
SELECT CONVERT(DECIMAL(5,2), CONVERT(VARBINARY(20),?@VALOR));

-- PARSE (RETORNA O RESULTADO DE UMA EXPRESS?O, CONVERTIDA NO TIPO DE DADOS SOLICITADO)
-- PARSE (EXEMPLO 1)
SELECT PARSE('MONDAY, 25 DECEMBER 2000' AS DATETIME USING 'EN-US') AS RESULTADO;

SELECT PARSE('SEGUNDA-FEIRA, 25 DEZEMBRO 2000' AS DATETIME USING 'PT-BR') AS RESULTADO;

-- PARSE (EXEMPLO 2)
SELECT PARSE('R$515,50' AS MONEY USING 'PT-BR') AS RESULTADO;

SELECT PARSE('$515.50' AS MONEY USING 'EN-US') AS RESULTADO;

-- PARSE (EXEMPLO 3)
SET LANGUAGE 'ENGLISH';
SELECT PARSE('12/25/2010' AS DATETIME) AS RESULTADO;

SET LANGUAGE 'PORTUGU?S';
SELECT PARSE('25/12/2000' AS DATETIME) AS RESULTADO;

SET LANGUAGE 'PORTUGU?S';
SELECT PARSE('12/25/2000' AS DATETIME) AS RESULTADO;


-- TRY_CAST (RETORNA UMA CONVERS?O DE VALOR AO TIPO DE DADOS ESPECIFICADO SE A CONVERS?O FOR BEM SUCEDIDA, CASO CONTR?RIO RETORNA NULO)
-- TRY_CAST (EXEMPLO 1)
SET DATEFORMAT DMY;
SELECT TRY_CAST('12/25/2000' AS DATETIME) AS RESULTADO;

-- TRY_CAST (EXEMPLO 2)
SET DATEFORMAT DMY;
SELECT TRY_CAST('05/12/2000' AS DATETIME) AS RESULTADO;


-- TRY_CONVERT (RETORNA UMA CONVERS?O DE VALOR AO TIPO DE DADOS ESPECIFICADO SE A CONVERS?O FOR BEM SUCEDIDA, CASO CONTR?RIO RETORNA NULO)
-- TRY_CONVERT (EXEMPLO 1)
SET DATEFORMAT DMY;
SELECT TRY_CONVERT(DATETIME, '12/25/2000') AS RESULTADO;

-- TRY_CONVERT (EXEMPLO 2)
SET DATEFORMAT DMY;
SELECT TRY_CONVERT(DATETIME, '25/12/2000') AS RESULTADO;


-- TRY_PARSE (RETORNA O RESULTADO DE UMA EXPRESS?O, CONVERTIDA NO TIPO DE DADOS SOLICITADO, OU NULO SE A CONVERS?O FALHAR)
-- UTILIZADA SOMENTE PARA CONVERTER DA CADEIA DE CARACTERES EM DATA/HORA E TIPOS NUM?RICOS
-- TRY_PARSE (EXEMPLO 1)
SELECT TRY_PARSE('12/25/2000' AS DATETIME USING 'EN-US') AS RESULTADO;

-- TRY_PARSE (EXEMPLO 2)
SELECT TRY_PARSE('TESTE' AS DATETIME USING 'EN-US') AS RESULTADO;