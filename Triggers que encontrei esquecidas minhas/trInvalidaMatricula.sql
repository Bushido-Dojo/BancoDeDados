USE [BD23319]
GO
/****** Object:  Trigger [Karate].[trInvalidaMatricula]    Script Date: 19/11/2023 16:02:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   trigger [Karate].[trInvalidaMatricula]
on [Karate].[Pagamento]
after insert, update
as
begin
	declare @dataLimite int = 30

	if exists (
		select 1 
		from inserted 
		where dataultimoPag < dateadd(day, -@dataLimite, GETDATE())
	)
	begin
		raiserror('A matricula foi deletada. Prazo de pagamento excedido!',15,1)
		DELETE FROM Karate.Matricula
		WHERE Id_Aluno IN (
			SELECT Id_Aluno
			FROM inserted
			WHERE dataUltimoPag < DATEADD(DAY, -@dataLimite, GETDATE())
		)
	end
end
