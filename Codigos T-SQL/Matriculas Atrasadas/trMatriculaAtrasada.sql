CREATE TRIGGER Karate.trMatriculaAtrasada
ON Karate.Matricula
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE A
    SET A.Banido = 'S'
    FROM Karate.Aluno A
    INNER JOIN Karate.Matricula I ON A.Id_Aluno = I.Id_Aluno
    WHERE DATEDIFF(MONTH, I.proxPgto, GETDATE()) > 3;

    DELETE FROM Karate.Matricula
    WHERE DATEDIFF(MONTH, proxPgto, GETDATE()) > 3;
END;
