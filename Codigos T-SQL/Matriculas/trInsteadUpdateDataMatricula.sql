CREATE OR ALTER TRIGGER trDataMatricula
ON Karate.Matricula
INSTEAD OF UPDATE
AS
BEGIN
    IF UPDATE ([dataMatricula])
    BEGIN
        RAISERROR('Não é permitido mudar a data da matrícula.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
