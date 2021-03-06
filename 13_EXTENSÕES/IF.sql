USE SALES;

-- IF
-- A ESTRUTURA CONDICIONAL IF SER? EXECUTADA SE A CONDI??O FOR SATISFEITA: A EXPRESS?O BOOLEANA RETORNA TRUE.
-- A PALAVRA-CHAVE OPCIONAL ELSE INTRODUZ OUTRA INSTRU??O CONDI??O QUE SER? EXECUTADA QUANDO A CONDI??O IF N?O FOR ATENDIDA: A EXPRESS?O BOOLIANA RETORNA FALSE.

-- IF (EXEMPLO 1)
IF 10 = 10
	BEGIN
		PRINT 'CORRETO'
	END
	ELSE
		PRINT 'ERRADO';

-- IF (EXEMPLO 2)
IF 10 = 10 AND 20 <> 20
	BEGIN
		PRINT 'CORRETO'
	END
	ELSE
		PRINT 'ERRADO';

-- IF (EXEMPLO 3)
IF 10 = 10 AND 20 = 300
	BEGIN
		PRINT 'CORRETO'
	END
	ELSE
		PRINT 'ERRADO';

-- IF (EXEMPLO 4)
IF 10 <> 10 OR 20 = 20
	BEGIN
		PRINT 'CORRETO'
	END
	ELSE
		PRINT 'ERRADO';

-- IF (EXEMPLO 5)
DECLARE @IDADE INT;
SET @IDADE = 70;

IF @IDADE < 18
	PRINT 'POSSUI MENOS DE 18 ANOS';
ELSE IF @IDADE >= 18 AND @IDADE < 65
	PRINT 'POSSUI MAIS DE 18 ANOS';
ELSE
	PRINT 'POSSUI 65 ANOS OU MAIS';

-- IF (EXEMPLO 6)
DECLARE @ID_CATEGORIA INT;
SET @ID_CATEGORIA = '1';
IF (SELECT COUNT(*)
	FROM PRODUTOS
	WHERE ID_CATEGORIA = @ID_CATEGORIA) = 0
		BEGIN
			PRINT 'CATEGORIA N?O ENCONTRADA'
		END
		ELSE
		BEGIN
			PRINT 'CATEGORIA ENCONTRADA';
			SELECT B.NOME_CATEGORIA, A.NOME_PRODUTO, A.PRECO
			FROM PRODUTOS AS A
			INNER JOIN CATEGORIA AS B
			ON A.ID_CATEGORIA = B.ID_CATEGORIA
			AND A.ID_CATEGORIA = @ID_CATEGORIA
		END;