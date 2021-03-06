-- COALESCE
-- AVALIA OS ARGUMENTOS NA ORDEM E RETORNA O VALOR ATUAL DA PRIMEIRA EXPRESS?O QUE N?O ? AVALIADA COMO NULL INICIALMENTE

-- COALESCE (EXEMPLO 1)
SELECT COALESCE(0, 150, 300, NULL, NULL);
SELECT COALESCE(NULL, 100, 150, 300, 450);
SELECT COALESCE(NULL, NULL, 300, NULL, NULL);

-- CRIANDO TABELA DE EXEMPLO
CREATE TABLE SALARIO
		(
		 MATRICULA INT IDENTITY,
		 SALARIO_HORA DECIMAL,
		 SALARIO_FIXO DECIMAL,
		 COMISSAO DECIMAL,
		 VENDAS INT
		);
-- INSERINDO REGISTROS
INSERT SALARIO (SALARIO_HORA, SALARIO_FIXO, COMISSAO, VENDAS)
VALUES
	(10.00, NULL, NULL, NULL),  
    (20.00, NULL, NULL, NULL),  
    (30.00, NULL, NULL, NULL),  
    (40.00, NULL, NULL, NULL),  
    (NULL, 10000.00, NULL, NULL),  
    (NULL, 20000.00, NULL, NULL),  
    (NULL, 30000.00, NULL, NULL),  
    (NULL, 40000.00, NULL, NULL),  
    (NULL, NULL, 15000, 2),  
    (NULL, NULL, 25000, 2),  
    (NULL, NULL, 35000, 4),  
    (NULL, NULL, 45000, 4);
-- VERIFICANDO REGISTROS
SELECT * FROM SALARIO;

-- COALESCE (EXEMPLO 2)
SELECT MATRICULA,
	   SALARIO_HORA,
	   SALARIO_FIXO,
	   COMISSAO,
	   VENDAS,
	   CAST(COALESCE(SALARIO_HORA * 40 * 52, SALARIO_FIXO, COMISSAO * VENDAS) AS MONEY) AS TOTAL_SALARIO
FROM SALARIO
ORDER BY MATRICULA;
