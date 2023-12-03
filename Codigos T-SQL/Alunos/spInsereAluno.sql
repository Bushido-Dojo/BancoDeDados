create or alter PROCEDURE Karate.spInsereAluno
@Id_Faixa INT,@nome varchar(50), @sobrenome VARCHAR(50), @cpf CHAR(14), @email VARCHAR(50), @celular char(14), @dataNascimento DATE, @senha VARCHAR(150)
as
BEGIN

INSERT INTO Karate.Aluno (Id_Faixa,nome,Sobrenome,CPF,EMail,Celular,Data_Nascimento,Banido,senha)
VALUES(@Id_Faixa,@nome,@sobrenome,@cpf,@email,@celular,@dataNascimento,'N',@senha)
END