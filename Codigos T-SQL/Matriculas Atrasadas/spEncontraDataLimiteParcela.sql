CREATE OR ALTER PROCEDURE Karate.spEncontraDataLimiteParcela
    @ProxPgto DATE,
    @dataLimite DATE OUTPUT
AS
BEGIN
    SET @dataLimite = DATEADD(DAY, 15, @ProxPgto)
END;
