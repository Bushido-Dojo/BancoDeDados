CREATE FUNCTION Karate.fnEncontraDiasAtrasados(@ProxPgto DATE)
RETURNS INT
AS
BEGIN
    DECLARE @dataLimiteCalculada DATE;
    DECLARE @diasAtraso INT;

    set @dataLimiteCalculada = Karate.fnEncontraDataLimiteParcela(@ProxPgto)

    SET @diasAtraso = DATEDIFF(DAY, @dataLimiteCalculada, GETDATE());

    IF @diasAtraso < 0
        SET @diasAtraso = 0;

    RETURN @diasAtraso;
END;


