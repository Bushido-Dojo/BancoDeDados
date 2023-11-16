CREATE OR ALTER PROCEDURE Karate.spRealizaPgto
@Id_Aluno INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @ultimoPgto DATE;

        SELECT @ultimoPgto = ultimoPgto
        FROM Karate.Matricula
        WHERE Id_Aluno = @Id_Aluno;

        IF (@ultimoPgto IS NULL)
        BEGIN
            RAISERROR('Aluno n�o encontrado', 16, 1);
        END

        DECLARE @valorParcela DECIMAL(18, 2), @valorMulta DECIMAL(18, 2);

        SELECT @valorParcela = valorParcela, @valorMulta = valorMulta
        FROM Karate.ValorPgto;

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
        END

        UPDATE Karate.Matricula
        SET ultimoPgto = GETDATE(),
            proxPgto = DATEADD(DAY, 30, GETDATE())
        WHERE Id_Aluno = @Id_Aluno;

        INSERT INTO Karate.Pagamento (Id_Aluno, valorPago, dataPgto)
        VALUES (@Id_Aluno, @valorParcela, GETDATE());

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT @ErrorMessage = ERROR_MESSAGE(),
               @ErrorSeverity = ERROR_SEVERITY(),
               @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
