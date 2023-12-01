CREATE or alter TRIGGER Karate.trVerificaDadosAlunos
ON Karate.Aluno
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    declare @Id_Faixa int, @nome varchar(50), @sobrenome varchar(50), @cpf CHAR(14), @email VARCHAR(50), @celular char(14), @dataNascimento DATE, @Id_Aluno INT

    SELECT TOP 1 @Id_Faixa = Id_Faixa,
                 @nome = nome,
                 @sobrenome = sobrenome,
                 @cpf = CPF,
                 @email = EMail,
                 @celular = Celular,
                 @dataNascimento = Data_Nascimento
    FROM inserted

    select @Id_Aluno = id_aluno from Karate.Aluno where CPF = @cpf

    IF (CHARINDEX('%[0-9]%', @nome) > 0)
    BEGIN
        RAISERROR('Nome do aluno não pode conter números.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF (CHARINDEX('%[0-9]%', @sobrenome) > 0)
    BEGIN
        RAISERROR('Sobrenome do aluno não pode conter números.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF (PATINDEX('%[^0-9.-]%', @cpf) != 0)
    BEGIN
        RAISERROR('CPF do aluno deve conter apenas números.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF LEN(@cpf) != 14
    BEGIN
        RAISERROR('CPF do aluno deve conter 11 dígitos.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF NOT (@email LIKE '%@%')
    BEGIN
        RAISERROR('E-mail do aluno deve conter um endereço de e-mail válido.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF (PATINDEX('%[^0-9()-]%', @celular) <> 0)
    BEGIN
        RAISERROR('Celular do aluno deve conter apenas números.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF LEN(@celular) != 14
    BEGIN
        DECLARE @msgErro VARCHAR(100)
        SET @msgErro = 'Celular do aluno contém ' + CAST(LEN(@celular) AS VARCHAR) + ' dígitos: ' + @celular
        RAISERROR(@msgErro, 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END


    IF @dataNascimento > GETDATE()
    BEGIN
        RAISERROR('Data de nascimento do aluno não pode ser posterior à data atual.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF DATEDIFF(YEAR, @dataNascimento, GETDATE()) < 13
    BEGIN
        RAISERROR('Aluno precisa ter mais de 12 anos.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF EXISTS (SELECT CPF FROM Karate.Aluno WHERE CPF = @cpf AND Id_Aluno != @Id_Aluno)
    BEGIN
        RAISERROR('CPF já cadastrado.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF EXISTS (SELECT EMail FROM Karate.Aluno WHERE EMail = @email AND Id_Aluno != @Id_Aluno)
    BEGIN
        RAISERROR('E-mail já cadastrado.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END
    IF EXISTS (SELECT celular FROM Karate.Aluno WHERE celular = @celular AND Id_Aluno != @Id_Aluno)
    BEGIN
        RAISERROR('Celular já cadastrado.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END
    -- Se todas as condições forem atendidas, o trigger continua sem erros
    PRINT @Id_Aluno
END
