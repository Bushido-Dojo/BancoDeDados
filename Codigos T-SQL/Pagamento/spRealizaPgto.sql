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
                set @valorParcela = (@valorParcela * 4) + (@valorMulta * 3)
                
                INSERT INTO Karate.Pagamento (Id_Aluno, valorPago, dataPgto)
                VALUES (@Id_Aluno, @valorParcela, GETDATE());

            end
            insert into Karate.Matricula(Id_Aluno,ultimoPgto,proxPgto,dataMatricula)
            VALUES(@id_aluno,GETDATE(),DATEADD(month,1,@ultimoPgto),GETDATE())

        END

        DECLARE @proximoPgto  DATE

        select @proximoPgto = proxPgto from karate.matricula where id_aluno = @id_aluno

        if(GETDATE()>= dateadd(day,15,@proximoPgto))
        BEGIN
            DECLARE @diasAtraso INT = DATEDIFF(day,dateadd(day,15,@proximoPgto),GETDATE())
            if(@diasAtraso<=0)
            begin 
                set @valorParcela = @valorParcela
            END

            else if(@diasAtraso>=1 and @diasAtraso <= 30 )
            BEGIN
                set @valorParcela = @valorParcela + @valorMulta
            END
            else if(@diasAtraso>30 and @diasAtraso<=60)
            BEGIN
                set @valorParcela = (@valorParcela * 2) + (@valorMulta*2)
            END

        UPDATE Karate.Matricula

        SET proxPgto = DATEADD(month, 1,ultimoPgto),
        ultimoPgto = GETDATE()
            
        WHERE Id_Aluno = @Id_Aluno;

        INSERT INTO Karate.Pagamento (Id_Aluno, valorPago, dataPgto)
        VALUES (@Id_Aluno, @valorParcela, GETDATE());

        COMMIT TRANSACTION;
        END
        END