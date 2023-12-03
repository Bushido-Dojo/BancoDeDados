create or alter view Karate.viewTurmaB as select

A.Nome+' ' + A.sobrenome as NomeCompleto,

F.Cor as Faixa,

datediff(year,A.Data_Nascimento,GETDATE())  as Idade

FROM Karate.Aluno A JOIN Karate.Faixa F ON A.Id_Faixa = F.Id_Faixa


where F.Turma = 'B'