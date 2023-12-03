CREATE or alter TRIGGER Karate.trMatriculaAtrasada
ON Karate.Matricula
AFTER UPDATE, insert
AS
BEGIN
    SET NOCOUNT ON;
    

    UPDATE A
    SET A.Banido = 'S'
    FROM Karate.Aluno A
    INNER JOIN Karate.Matricula I ON A.Id_Aluno = I.Id_Aluno
    WHERE DATEDIFF(MONTH,dateadd(day,15,proxPgto), GETDATE()) > 2;

    DELETE FROM Karate.Matricula
    WHERE DATEDIFF(MONTH,dateadd(day,15,proxPgto), GETDATE()) > 2;
END
