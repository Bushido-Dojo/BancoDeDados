create or alter PROCEDURE Karate.spInsereAluno
@nome varCHAR(20), @sobrenome VARCHAR(20), @cpf CHAR(14), @email VARCHAR(50), @celular char(11), @dataNascimento DATE
as
BEGIN

INSERT INTO Karate.Aluno (Id_Faixa,nome,Sobrenome,CPF,EMail,Celular,Data_Nascimento,Banido)
VALUES(0,@nome,@sobrenome,@cpf,@email,@celular,@dataNascimento,'N')
END