CREATE OR ALTER VIEW Karate.viewMatriculas as SELECT
M.Id_Matricula,

M.id_aluno,

A.nome + ' ' +A.sobrenome as nomeCompleto,

M.dataMatricula,

M.ultimoPgto,

dateadd(day,15,M.proxPgto) as VencimentoParcela

FROM Karate.Matricula M JOIN 
Karate.Aluno A ON A.Id_Aluno = M.Id_Aluno


WHERE M.Id_Matricula is not null