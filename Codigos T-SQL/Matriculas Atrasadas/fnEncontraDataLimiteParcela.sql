CREATE FUNCTION Karate.fnEncontraDataLimiteParcela(@ProxPgto DATE)
RETURNS DATE
AS
BEGIN
    DECLARE @dataLimite DATE;

    SET @dataLimite = DATEADD(DAY, 15, @ProxPgto);

    RETURN @dataLimite;
END;


