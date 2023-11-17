CREATE or alter view Karate.MatriculasAtrasadas as SELECT
    M.id_aluno, A.Nome, A.Sobrenome, A.Turma, M.ultimoPgto, M.proxPgto,

    Karate.spEncontraDataLimiteParcela(M.ProxPgto) as DataLimiteParcela,

    case WHEN Karate.spEncontraDataLimiteParcela(M.ProxPgto) < GETDATE() THEN
        DATEDIFF(day,Karate.spEncontraDataLimiteParcela(M.ProxPgto),getdate())
        END
    as DiasAtraso,


    case when Karate.spEncontraDataLimiteParcela(M.ProxPgto) 