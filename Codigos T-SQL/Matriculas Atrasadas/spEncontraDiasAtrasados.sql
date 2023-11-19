CREATE OR ALTER PROCEDURE Karate.spEncontraDiasAtrasados
    @ProxPgto DATE,
    @diasAtraso INT OUTPUT
AS
BEGIN
    DECLARE @dataLimiteCalculada DATE;

    EXEC Karate.spEncontraDataLimiteParcela @ProxPgto, @dataLimite = @dataLimiteCalculada OUTPUT;

    SET @diasAtraso = DATEDIFF(DAY, @dataLimiteCalculada, GETDATE());

    IF @diasAtraso < 0
        SET @diasAtraso = 0;
END;