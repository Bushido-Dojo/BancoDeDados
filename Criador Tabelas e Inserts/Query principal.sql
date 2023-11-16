create schema Karate

CREATE TABLE Karate.Faixa (
    Id_Faixa INT PRIMARY KEY IDENTITY(1,1),
    Cor VARCHAR(50)
);

CREATE TABLE Karate.Aluno (
    Id_Aluno INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(50),
    Sobrenome VARCHAR(50),
    CPF BIGINT,
    EMail VARCHAR(30),
    Celular BIGINT,
    Data_Nascimento DATE
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

CREATE TABLE Karate.Professor (
    Id_Prof INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(50),
    Horarios DATETIME
);

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