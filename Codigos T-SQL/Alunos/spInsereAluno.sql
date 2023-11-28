create or alter PROCEDURE Karate.spInsereAluno
@Id_Faixa INT,@nome CHAR(20), @sobrenome VARCHAR(20), @cpf CHAR(14), @email VARCHAR(50), @celular char(14), @dataNascimento DATE
as
BEGIN

INSERT INTO Karate.Aluno (Id_Faixa,nome,Sobrenome,CPF,EMail,Celular,Data_Nascimento,Banido)
VALUES(@Id_Faixa,@nome,@sobrenome,@cpf,@email,@celular,@dataNascimento,'N')
END