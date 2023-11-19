create or alter PROCEDURE Karate.spInsereAluno
@nome varCHAR, @sobrenome VARCHAR, @cpf CHAR(11), @email VARCHAR(50), @celular char(11), @dataNascimento DATE
as
BEGIN
BEGIN TRANSACTION


if(@cpf in (select CPF FROM Karate.aluno))
BEGIN
    RAISERROR('O cpf ja está Registrado.',15,2)
    ROLLBACK TRANSACTION
END

declare @idade int = DATEDIFF(year,@dataNascimento,GETDATE())

IF(@idade<=12)
BEGIN
    RAISERROR('O individuo tem menos de 13 anos!',15,2)
    ROLLBACK TRANSACTION
END

INSERT INTO Karate.Aluno (Id_Faixa,nome,Sobrenome,CPF,EMail,Celular,Data_Nascimento,Banido)
VALUES(0,@nome,@sobrenome,@cpf,@email,@celular,@dataNascimento,'N')
COMMIT TRANSACTION
END