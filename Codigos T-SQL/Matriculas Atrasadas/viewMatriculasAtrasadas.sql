CREATE or alter view Karate.MatriculasAtrasadas as SELECT
    M.Id_Aluno, A.Nome, A.Sobrenome, F.Turma, M.ultimoPgto, M.proxPgto,

    Karate.fnEncontraDataLimiteParcela(M.ProxPgto) as DataLimiteParcela,

    case WHEN Karate.fnEncontraDataLimiteParcela(M.ProxPgto) < GETDATE() THEN
        Karate.fnEncontraDiasAtrasados(M.ProxPgto)
        END
    as DiasAtraso,

    case when dateadd(MONTH,1,M.proxPgto) < GETDATE() then
        DATEDIFF(month,M.proxPgto,GETDATE())
        END
    as ParcelasAtraso


    FROM Karate.Matricula M 
    JOIN Karate.Aluno A ON M.Id_Aluno = A.Id_Aluno
    JOIN Karate.Faixa F ON A.Id_Faixa = F.Id_Faixa
    WHERE M.proxPgto<GETDATE();
