CREATE OR ALTER TRIGGER Karate.trVerificaDadosProf 
ON Karate.Professor
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_Prof INT, @nome VARCHAR(20), @sobrenome VARCHAR(20), @cpf CHAR(14), @sexo CHAR(1), @telefone CHAR(14), @dataCadastro DATE

    SELECT TOP 1 @nome = nome,
                 @sobrenome = sobrenome,
                 @cpf = CPF,
                 @sexo = sexo,
                 @telefone = telefone,
                 @dataCadastro = dataCadastro
    FROM inserted

    SELECT @id_Prof = id_Prof FROM Karate.Professor WHERE CPF = @cpf

    IF (PATINDEX('%[^0-9.-]%', @cpf) != 0)
    BEGIN
        RAISERROR('CPF do Professor deve conter apenas números e hífens.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF LEN(@cpf) != 14
    BEGIN
        RAISERROR('CPF do Professor deve conter 14 caracteres.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF (PATINDEX('%[^0-9()-]%', @telefone) != 0)
    BEGIN
        RAISERROR('Telefone do professor deve conter apenas números, parênteses e hífens.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF LEN(@telefone) != 14
    BEGIN
        RAISERROR('Telefone do professor deve conter 14 caracteres.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF @dataCadastro > GETDATE()
    BEGIN
        RAISERROR('Data de cadastro do professor não pode ser posterior à data atual.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF EXISTS (SELECT CPF FROM Karate.Professor WHERE CPF = @cpf AND id_Prof != @id_Prof)
    BEGIN
        RAISERROR('CPF já cadastrado.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF EXISTS (SELECT telefone FROM Karate.Professor WHERE telefone = @telefone AND id_Prof != @id_Prof)
    BEGIN
        RAISERROR('Telefone já cadastrado.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END
END
