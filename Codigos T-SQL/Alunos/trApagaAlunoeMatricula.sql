create or alter trigger Karate.trApagaAlunoeMatricula
on Karate.Aluno
INSTEAD of DELETE
as
BEGIN

    DECLARE @id_aluno int

    select @id_aluno = id_aluno from deleted

    delete Karate.Matricula where id_aluno = @id_aluno

    delete Karate.Aluno where Id_Aluno = @id_aluno
END
