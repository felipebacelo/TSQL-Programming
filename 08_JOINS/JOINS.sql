-- CRIANDO TABELAS DE EXEMPLO
CREATE TABLE ALUNOS
	(
	ID_ALUNO INT IDENTITY(1,1) NOT NULL,
	NOME VARCHAR(20) NOT NULL,
	CONSTRAINT PK1_ALUNOS PRIMARY KEY (ID_ALUNO)
	);

CREATE TABLE DISCIPLINA
	(
	ID_DISCIPLINA INT IDENTITY(1,1),
	NOME_DISCIPLINA VARCHAR(20),
	CONSTRAINT PK2_DISCIPLINA PRIMARY KEY (ID_DISCIPLINA)
	);

CREATE TABLE MATRICULA
	(
	ID_ALUNO INT NOT NULL,
	ID_DISCIPLINA INT NOT NULL,
	PERIODO VARCHAR(10),
	CONSTRAINT PK3_MATRICULA PRIMARY KEY (ID_ALUNO, ID_DISCIPLINA),
	CONSTRAINT FK1_MATRICULA FOREIGN KEY (ID_ALUNO) REFERENCES ALUNOS (ID_ALUNO),
	CONSTRAINT FK2_MATRICULA FOREIGN KEY (ID_DISCIPLINA) REFERENCES DISCIPLINA (ID_DISCIPLINA)
	);
  
-- INSERINDO REGISTROS NA TABELA ALUNOS
INSERT INTO ALUNOS VALUES ('MARIA'),('JOS�'),('CRISTINA'),('JO�O'),('MARTA');

-- INSERINDO REGISTROS NA TABELA DISCIPLINA
INSERT INTO DISCIPLINA VALUES ('BANCO DE DADOS'),('PROGRAMA��O WEB'),('TESTE DE SOFTWARE'),('METODOLOGIA �GIL'),('MODELAGEM DE DADOS');

-- INSERINDO REGISTROS NA TABELA MATRICULA
INSERT INTO MATRICULA VALUES ('1','1','NOTURNO');
INSERT INTO MATRICULA VALUES ('1','2','VESPERTINO');
INSERT INTO MATRICULA VALUES ('1','3','MATUTINO');
INSERT INTO MATRICULA VALUES ('2','3','NOTURNO');
INSERT INTO MATRICULA VALUES ('2','4','NOTURNO');
INSERT INTO MATRICULA VALUES ('3','1','NOTURNO');
INSERT INTO MATRICULA VALUES ('3','3','NOTURNO');
INSERT INTO MATRICULA VALUES ('3','4','NOTURNO');
INSERT INTO MATRICULA VALUES ('5','1','MATUTINO');
INSERT INTO MATRICULA VALUES ('5','2','VESPERTINO');
INSERT INTO MATRICULA VALUES ('5','4','NOTURNO');

-- INNER JOIN
-- RETORNA SOMENTE QUANDO TEMOS CHAVES CORRESPONDENTES (S� EXIBE REGISTROS QUE EXISTAM NAS DUAS TABELAS, QUALQUER REGISTRO QUE N�O TENHA UM VALOR COMUM NAS DUAS TABELAS SER� EXCLU�DO)
SELECT A.ID_ALUNO,
	   A.NOME,
	   C.NOME_DISCIPLINA,
	   B.PERIODO
FROM ALUNOS AS A
INNER JOIN MATRICULA AS B
ON A.ID_ALUNO = B.ID_ALUNO
INNER JOIN DISCIPLINA AS C
ON B.ID_ALUNO = C.ID_DISCIPLINA;

-- LEFT JOIN
-- RETORNA TODOS OS REGISTROS DA TABELA DA ESQUERDA E SOMENTE OS CORRESPONDENTES NA TABELA DA DIREITA
SELECT A.ID_ALUNO,
	   A.NOME,
	   C.NOME_DISCIPLINA,
	   B.PERIODO
FROM ALUNOS AS A
LEFT JOIN MATRICULA AS B
ON A.ID_ALUNO = B.ID_ALUNO
LEFT JOIN DISCIPLINA AS C
ON B.ID_ALUNO = C.ID_DISCIPLINA;

-- RIGHT JOIN
-- RETORNA TODOS OS REGISTROS DA TABELA DA DIREITA E SOMENTE OS CORRESPONDENTES NA TABELA DA ESQUERDA
SELECT A.ID_ALUNO,
	   A.NOME,
	   C.NOME_DISCIPLINA,
	   B.PERIODO
FROM ALUNOS AS A
RIGHT JOIN MATRICULA AS B
ON A.ID_ALUNO = B.ID_ALUNO
RIGHT JOIN DISCIPLINA AS C
ON B.ID_ALUNO = C.ID_DISCIPLINA
ORDER BY A.ID_ALUNO ASC;

-- FULL JOIN
-- RETORNA TODOS OS REGISTROS DE TODAS AS TABELAS
SELECT A.ID_ALUNO,
	   A.NOME,
	   C.NOME_DISCIPLINA,
	   B.PERIODO
FROM ALUNOS AS A
FULL JOIN MATRICULA AS B
ON A.ID_ALUNO = B.ID_ALUNO
FULL JOIN DISCIPLINA AS C
ON B.ID_ALUNO = C.ID_DISCIPLINA
ORDER BY A.ID_ALUNO ASC;