create or alter PROCEDURE Karate.spEncontraParcelasAtrasadas
@diasAtraso INT, @parcelasAtrasadas int OUTPUT
as
BEGIN

exec Karate.spEncontraDiasAtrasados 