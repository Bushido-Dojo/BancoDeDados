CREATE OR ALTER PROCEDURE Karate.spRealizaPgto
@Id_Aluno INT
AS
BEGIN
        BEGIN TRANSACTION;

        DECLARE @ultimoPgto DATE, @dataMatricula date;

        SELECT @ultimoPgto = ultimoPgto
        FROM Karate.Matricula
        WHERE Id_Aluno = @Id_Aluno;

        select @dataMatricula = dataMatricula
        from karate.Matricula
        where id_aluno = @Id_Aluno


        DECLARE @valorParcela DECIMAL(18, 2), @valorMulta DECIMAL(18, 2);

        SELECT @valorParcela = valorParcela, @valorMulta = valorMulta
        FROM Karate.ValorPgto;


        if(@dataMatricula IS NULL)
        BEGIN
            if((select Banido from Karate.Aluno where id_aluno = @id_aluno) = 'S')
            BEGIN
                set @valorParcela = (@valorParcela * 3) + (@valorMulta * 2)
                
                INSERT INTO Karate.Pagamento (Id_Aluno, valorPago, dataPgto,Turma)
                VALUES (@Id_Aluno, @valorParcela, GETDATE(),(select turma from Karate.Aluno where id_aluno = @id_aluno));

            end
            insert into Karate.Matricula(Id_Aluno,ultimoPgto,proxPgto,dataMatricula,turma)
            VALUES(@id_aluno,GETDATE(),DATEADD(day,30,GETDATE()),GETDATE(),(select turma from Karate.Aluno where id_aluno = @id_aluno))

        END

        DECLARE @daysDiff INT;
        SET @daysDiff = DATEDIFF(DAY, @ultimoPgto, GETDATE());

        IF (@daysDiff < 0)
        BEGIN
            RAISERROR('A data do pagamento � inv�lida', 16, 1);
        END
        ELSE IF (@daysDiff BETWEEN 0 AND 30)
        BEGIN
            SET @valorParcela = @valorParcela;
        END
        ELSE IF (@daysDiff BETWEEN 31 AND 60)
        BEGIN
            SET @valorParcela = @valorParcela + @valorMulta;
        END
        ELSE IF (@daysDiff BETWEEN 61 AND 90)
        BEGIN
            SET @valorParcela = (@valorParcela * 2) + @valorMulta;
        END
        ELSE
        BEGIN
            DELETE FROM Karate.Matricula WHERE Id_Aluno = @Id_Aluno;
            RAISERROR('Matr�cula deletada. Prazo de pagamento ultrapassado.', 16, 1);
            
            update Karate.Aluno
            set Banido = 'S'
            where id_aluno = @id_aluno
        END

        UPDATE Karate.Matricula
        SET ultimoPgto = GETDATE(),
            proxPgto = DATEADD(DAY, 30, GETDATE())
        WHERE Id_Aluno = @Id_Aluno;

        INSERT INTO Karate.Pagamento (Id_Aluno, valorPago, dataPgto,Turma)
        VALUES (@Id_Aluno, @valorParcela, GETDATE(),(select turma from Karate.Aluno where id_aluno = @id_aluno));

        COMMIT TRANSACTION;
END