USE SALES;

-- BULK
-- O COMANDO BULK INSERT � UTILIZADO PARA COPIAR/IMPORTAR DADOS DE UM ARQUIVO DE TEXTO OU NATIVO DO SQL SERVER, TAMB�M CHAMADOS DE FLAT FILE.

-- PRINCIPAIS PAR�METROS
-- CODEPAGE: DEFINE A P�GINA DE C�DIGOS A SER USADA NA IMPORTA��O E, POR CONSEQU�NCIA, SE OS CARACTERES V�M ACENTUADOS OU N�O (ACP, OEM, RAW, CODE_PAGE).
-- DATAFILETYPE: DEFINE QUE A IMPORTA��O UTILIZAR� O VALOR DE TIPO DE ARQUIVO DE DADOS ESPECIFICADO (CHAR, NATIVE, WIDECHAR, WIDENATIVE).
-- FIELDTERMINATOR: CARACTERE UTILIZADO PARA SEPARAR UMA COLUNA DA OUTRA. (POR DEFAULT � O CARACTERE [TAB] TAMB�M REPRESENTADO POR \t).
-- ROWTERMINATOR: CARACTERE UTILIZADO PARA SEPARAR UMA LINHA DA OUTRA (POR DEFAULT � O CARACTERE [ENTER] TAMB�M REPRESENTADO POR \n).
-- MAXERRORS: DEFINE A QUANTIDADE M�XIMA DE ERROS QUE PODE OCORRER NUMA IMPORTA��O DE DADOS.
-- FIRE_TRIGGERS: SE INFORMADO, DISPARA AS TRIGGERS NA EXECU��O DO COMANDO (POR DEFAULT N�O DISPARA).
-- KEEP IDENTITY: SE INFORMADO, IMPEDE QUE A NUMERA��O AUTOM�TICA (COLUNA IDENTITY DA TABELA) SEJA USADA.
-- FIRSTROW: DEFINE QUAL SER� A PRIMEIRA LINHA IMPORTADA.
-- LASTROW: DEFINE QUAL SER� A �LTIMA LINHA IMPORTADA.


-- EXEMPLO
-- CRIANDO TABELA  DE EXEMPLO
CREATE TABLE FORNECEDORES
		(
		COD_FORNECEDOR NVARCHAR(5),
		NOME NVARCHAR(20)
		);

-- IMPORTANDO DADOS COM BULK INSERT
BULK INSERT FORNECEDORES
FROM 'C:\TEMP\BULK\FORNECEDORES.TXT'
WITH (
	 CODEPAGE = 'ACP',
	 DATAFILETYPE = 'CHAR',
	 FIELDTERMINATOR = '|',
	 ROWTERMINATOR = '\n',
	 MAXERRORS = 0,
	 FIRSTROW = 1,
	 LASTROW = 5
	 );

-- VERIFICANDO DADOS IMPORTADOS COM BULK INSERT
SELECT * FROM FORNECEDORES;