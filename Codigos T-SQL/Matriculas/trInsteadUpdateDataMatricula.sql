CREATE or ALTER TRIGGER trDataMatricula
ON Karate.Matricula
INSTEAD OF UPDATE
AS
BEGIN

if UPDATE ([dataMatricula])
BEGIN
    RAISERROR('Não é permitido mudar a data da matrícula.',16,1)
    ROLLBACK TRANSACTION
END
ELSE
BEGIN
    UPDATE Karate.Matricula set ultimoPgto = inserted.ultimoPgto, proxPgto = inserted.ProxPgto
END
END
