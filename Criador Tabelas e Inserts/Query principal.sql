create schema Karate

CREATE TABLE Karate.Faixa (
    Id_Faixa INT PRIMARY KEY IDENTITY(1,1),
    Cor VARCHAR(50)
);

CREATE TABLE Karate.Aluno (
    Id_Aluno INT identity(1,1) not null,
    Id_Faixa INT not NULL,
    Nome VARCHAR(50) not null,
    Sobrenome VARCHAR(50) not null,
    CPF CHAR(11) not null,
    EMail VARCHAR(50),
    Celular char(11),
    Data_Nascimento DATE not null,
    Banido char(1) not null,
    CONSTRAINT PK_Aluno PRIMARY KEY (Id_Aluno)
);


CREATE TABLE Karate.Pagamento (
    Cod_Pgmnto INT PRIMARY KEY IDENTITY(1,1),
    Id_Matr�cula INT,
    Id_Aluno INT,

    FOREIGN KEY (Id_Aluno) REFERENCES Karate.Aluno(Id_Aluno)
);


CREATE TABLE Karate.Matr�cula (
    Id_Matricula INT PRIMARY KEY IDENTITY (1,1),
    Id_Aluno INT,
    Id_Prof INT,
    FOREIGN KEY (Id_Aluno) REFERENCES Karate.Aluno(Id_Aluno),
    FOREIGN KEY (Id_Prof) REFERENCES Karate.Professor(Id_Prof)
);

create table Karate.Professor(
	Id_Prof int identity(1,1) primary key,
	nome varchar (20) not null,
	sobrenome varchar(20) not null,
	CPF char(14) not null,
	sexo char(1) not null,
	telefone char(14) not null,
	dataCadastro date not null
	)

ALTER TABLE Karate.Pagamento
ADD CONSTRAINT FK_Matricula_Pagamento
FOREIGN KEY (Id_Matr�cula) REFERENCES Karate.Matr�cula(Id_Matricula);


ALTER TABLE KARATE.Aluno
ADD CONSTRAINT FK_Faixa_Aluno
FOREIGN KEY (Id_Faixa) REFERENCES Karate.Faixa(Id_Faixa);




ALTER TABLE Karate.Matr�cula
add Situacao varchar(11)


alter table Karate.Matr�cula
Add ultimoPgto date, proxPgto date


create table Karate.ValorPgto(
valorParcela money,
valorMulta money
)

insert Karate.ValorPgto
(valorParcela, valorMulta)
values (59.99,15.00)

alter table karate.pagamento
add valorPago money not null;


select * from Karate.Matr�cula

alter table Karate.Matr�cula
drop column Cod_Pgmnto,situacao

alter table Karate.Matr�cula
drop constraint [FK__Matr�cula__Cod_P__70FDBF69]


alter table Karate.Matr�cula
add Id_Matricula int primary key identity(100,1)


alter table Karate.Pagamento
drop column Cod_Pgmnto

alter table Karate.Pagamento
add CodPgto int identity(1000,50) primary key


ALTER TABLE Karate.Pagamento
ALTER COLUMN Id_Aluno IT NOT NULL;


ALTER TABLE Karate.Pagamento
ADD dataPgto DATE NOT NULL;
UPDATE Karate.Pagamento
SET dataPgto = dataUltimoPag;

-- Remover a coluna antiga
ALTER TABLE Karate.Pagamento
DROP COLUMN dataUltimoPag;

--remover coluna horario
alter table Karate.professor
drop column Horarios


CREATE TABLE Karate.HorariosAula (
    Id_Horario INT PRIMARY KEY IDENTITY(1,1),
    Id_Prof INT,
    DiaSemana INT,
    HorarioInicio TIME,
    FOREIGN KEY (Id_Prof) REFERENCES Karate.Professor(Id_Prof)
);


select * from Karate.HorariosAula 



CREATE TABLE Karate.Turmas(
    turma VARCHAR(1) primary key 
)


alter TABLE karate.Faixa
ADD Turma varCHAR(1)
FOREIGN key(Turma) REFERENCES Karate.Turmas (Turma)

select * from Karate.Faixa


UPDATE Karate.Faixa
SET Turma = 'A'
WHERE Id_Faixa BETWEEN 0 AND 3;


UPDATE Karate.Faixa
SET Turma = 'B'
WHERE Id_Faixa BETWEEN 4 AND 7;



alter TABLE Karate.Professor
add Turma VARCHAR(1)
FOREIGN key (Turma) REFERENCES Karate.Turmas (Turma)

update Karate.Professor
set Turma = 'A'
WHERE Id_Prof = 1

UPDATE Karate.Professor
set Turma = 'B'
WHERE Id_Prof = 2

SELECT * from Karate.Turmas

alter TABLE karate.HorariosAula
add Turma varchar(1)
FOREIGN KEY(Turma) REFERENCES Karate.Turmas (Turma)

SELECT * from Karate.HorariosAula
-- atualiza tabela matricula para nova lógica(remove id_Prof da tabela e adiciona coluna dataMatricula);

alter table Karate.Matricula
ADD dataMatricula date not NULL

alter table karate.Matricula
drop CONSTRAINT [FK__Matrícula__Id_Pr__71F1E3A2]

alter table karate.Matricula
drop column Id_Prof

--------

alter TABLE karate.pagamento
add Turma VARCHAR(1)

ALTER TABLE karate.Pagamento
ADD CONSTRAINT FK_Pagamento_Id_Aluno FOREIGN KEY (Id_Aluno,Turma) REFERENCES Karate.Aluno(Id_Aluno,Turma)


alter table Karate.Matricula
add turma VARCHAR(1)

ALTER TABLE karate.Matricula
ADD CONSTRAINT FK_Matricula_Id_Aluno FOREIGN KEY (Id_Aluno,Turma) REFERENCES Karate.Aluno(Id_Aluno,Turma)

alter TABLE Karate.Professor
drop column Turma

--adiciona mais dados a tabela professor
alter table Karate.Professor
add CPF char(11), Sexo char(1),Telefone varchar(11)


--adiciona coluna Banido a tabela aluno para saber se ele está banido, caso estiver banido ele tem uma divida ao dojo, só sera desbanido após pagar a divida.
ALTER TABLE Karate.Aluno
alter COLUMN Banido CHAR(1) not null;


select * from Karate.Aluno

select * from Karate.Matricula
select * from Karate.Pagamento


SELECT * FROM Karate.MatriculasAtrasadas

select * from Karate.Faixa



CREATE TABLE Karate.ADM(
    Id_Adm int IDENTITY (1,1) not null,
    username VARCHAR(20) not null,
    cpf CHAR(14) NOT NULL,
    senha VARCHAR(20) not NULL,
    PRIMARY KEY (Id_Adm)
)


SELECT * FROM Karate.viewMatriculas

exec Karate.spRealizaPgtos 116

delete Karate.Aluno where Id_Aluno = 217

select * from Karate.Aluno