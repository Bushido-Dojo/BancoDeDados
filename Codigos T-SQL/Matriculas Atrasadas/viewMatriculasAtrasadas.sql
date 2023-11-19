CREATE or alter view Karate.MatriculasAtrasadas as SELECT
    M.id_aluno, A.Nome, A.Sobrenome, A.Turma, M.ultimoPgto, M.proxPgto,

    Karate.spEncontraDataLimiteParcela(M.ProxPgto) as DataLimiteParcela,

    case WHEN Karate.spEncontraDataLimiteParcela(M.ProxPgto) < GETDATE() THEN
        Karate.spEncontraDiasAtrasados(Karate.spEncontraDataLimiteParcela(M.ProxPgto))
        END
    as DiasAtraso,

    case when Karate.spEncontraDiasAtrasados(Karate.spEncontraDataLimiteParcela(M.proxPgto)) > 30 then
    