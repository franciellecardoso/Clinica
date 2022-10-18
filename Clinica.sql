--Criação de uma Database (Inicializar um BD)
CREATE DATABASE primeiro_exercicio_SQL_clinica

--Deixar a database ativa
GO
USE primeiro_exercicio_SQL_clinica 

-- Criação de tabela paciente
CREATE TABLE paciente (
num_beneficiario       INT              NOT NULL,
nome                   VARCHAR(200)     NOT NULL,
logradouro             VARCHAR(200)     NOT NULL,
numero                 INT              NOT NULL,
CEP                    CHAR(8)          NULL,
complemento            VARCHAR(255)     NULL,
telefone               VARCHAR(11)      NOT NULL
PRIMARY KEY (num_beneficiario)
)    
--Verificar as características paciente
EXEC sp_help paciente

--Criação tabela especialidade
CREATE TABLE especialidade (
id                  INT                 NOT NULL,
especialidade       VARCHAR(100)        NOT NULL,
PRIMARY KEY (id)
)
--Verificar as características especialidade
EXEC sp_help especialidade

--Criação de tabela medico
CREATE TABLE medico (
codigo              INT                 NOT NULL,
nome                VARCHAR(100)        NOT NULL,
logradouro          VARCHAR(200)        NOT NULL,
numero              INT                 NOT NULL,
CEP                 CHAR(8)             NOT NULL,
complemento         VARCHAR(255)        NULL,
contato             VARCHAR(11)         NOT NULL,
especialidade_id    INT                 NOT NULL
PRIMARY KEY (codigo)
FOREIGN KEY (especialidade_id) 
	REFERENCES especialidade (id)
)
--Verificar as características medico
EXEC sp_help medico

--Criação de tabela consulta
CREATE TABLE consulta (
paciente_num_beneficiario       INT            NOT NULL,
medico_codigo                   INT            NOT NULL,
data_hora                       DATETIME       NOT NULL,
observacao                      VARCHAR(255)   NOT NULL
PRIMARY KEY (paciente_num_beneficiario, medico_codigo,
	data_hora)
FOREIGN KEY (paciente_num_beneficiario)
	REFERENCES paciente(num_beneficiario),
FOREIGN KEY (medico_codigo)
	REFERENCES medico(codigo)
)
--Verificar as características consulta
EXEC sp_help consulta

--Inserção de Dados paciente
INSERT INTO paciente(num_beneficiario, nome, logradouro, numero, CEP, complemento, telefone)
VALUES               (99901, 'Washington Silva', 'R. Anhaia', 150, '02345000', 'Casa', '922229999')

INSERT INTO paciente(num_beneficiario, nome, logradouro, numero, CEP, complemento, telefone)
VALUES               (99902, 'Luis Ricardo', 'R. Voluntarios da Pátria', 2251, '03254010', 'Bloco B. Apto 25', '923450987')

INSERT INTO paciente(num_beneficiario, nome, logradouro, numero, CEP, complemento, telefone)
VALUES               (99903, 'Maria Elisa', 'Av. Aguia de Haia', 1188, '06987020', 'Apto 1208', '912348765')

INSERT INTO paciente(num_beneficiario, nome, logradouro, numero, CEP, complemento, telefone)
VALUES               (99904, 'José Araujo', 'R. XY de Novembro', 18, '03678000', 'Casa', '945674312')

INSERT INTO paciente(num_beneficiario, nome, logradouro, numero, CEP, complemento, telefone)
VALUES               (99905, 'Joana Paula', 'R. 7 de Abril', 97, '01214000', 'Conjunto 3 Apto 801', '912095674')

--Consulta todas as linhas e todas as colunas paciente
SELECT * FROM paciente   

--Inserção de Dados especialidade
INSERT INTO especialidade(id, especialidade)
VALUES       (1 , 'Otorrinolaringologista')

INSERT INTO especialidade(id, especialidade)
VALUES       (2 , 'Urologista')

INSERT INTO especialidade(id, especialidade)
VALUES       (3 , 'Geriatra')

INSERT INTO especialidade(id, especialidade)
VALUES       (4 , 'Pediatra')

--Consulta todas as linhas e todas as colunas especialidade
SELECT * FROM especialidade

--Inserção de Dados medico
INSERT INTO medico(codigo, nome, logradouro, numero, CEP, complemento, contato, especialidade_id)
VALUES          (100001, 'Ana Paula', 'R. 7 de Setembro', 256, 03698000, 'Casa', 915689456, 1)

INSERT INTO medico(codigo, nome, logradouro, numero, CEP, complemento, contato, especialidade_id)
VALUES          (100002, 'Maria Aparecida', 'Av. Brasil', 32, 02145070, 'Casa', 923235454, 1)

INSERT INTO medico(codigo, nome, logradouro, numero, CEP, complemento, contato, especialidade_id)
VALUES          (100003, 'Lucas Borges', 'Av. do Estado', 3210, 05241000, 'Apto 205', 963698585, 2)

INSERT INTO medico(codigo, nome, logradouro, numero, CEP, complemento, contato, especialidade_id)
VALUES          (100004, 'Gabriel Oliveira', 'Av. Dom Helder Camara', 350, 03145000, 'Apto 602', 93245845, 3)

--Consulta todas as linhas e todas as colunas medico
SELECT * FROM medico

--Inserção de Dados consulta
INSERT INTO consulta(paciente_num_beneficiario, medico_codigo, data_hora, observacao)
VALUES              (99901, 100002, '2021-09-04 13:20', 'Infecção Urina')

INSERT INTO consulta(paciente_num_beneficiario, medico_codigo, data_hora, observacao)
VALUES              (99902, 100003, '2021-09-04 13:15', 'Gripe')

INSERT INTO consulta(paciente_num_beneficiario, medico_codigo, data_hora, observacao)
VALUES              (99901, 100001, '2021-09-04 12:30', 'Infecção Garganta')

--Consulta todas as linhas e todas as colunas consulta
SELECT * FROM consulta

--Criação da coluna dia_atendimento para medico
ALTER TABLE medico
ADD dia_atendimento  VARCHAR(100)  NULL
--EXEC sp_help medico

--Atualizar Dados e Adicionar os dias da semana para medico
UPDATE medico
SET dia_atendimento = '2ª feira'
WHERE codigo = 100001

UPDATE medico
SET dia_atendimento = '4ª feira'
WHERE codigo = 100002

UPDATE medico
SET dia_atendimento = '2ª feira'
WHERE codigo = 100003

UPDATE medico
SET dia_atendimento = '5ª feira'
WHERE codigo = 100004
--SELECT * FROM medico

--Excluir especialidade Pediatra
DELETE especialidade
WHERE id = 4
--SELECT * FROM especialidade

--Modificar nome de coluna
EXEC sp_rename 'dbo.medico.dia_atendimento',
               'dia_semana_atendimento' , 'column'

--Atualizar Dados medico Lucas logradouro, numero, complemento e cep
UPDATE medico
SET logradouro = 'Av. Bras Leme'
WHERE codigo = 100003

UPDATE medico
SET numero = 876
WHERE codigo = 100003

UPDATE medico
SET complemento = 'apto 504'
WHERE codigo = 100003

UPDATE medico
SET CEP = 02122000
WHERE codigo = 100003

--Modificar tipo de coluna observacao na consulta
ALTER TABLE consulta
ALTER COLUMN observacao VARCHAR(200)   NOT NULL


