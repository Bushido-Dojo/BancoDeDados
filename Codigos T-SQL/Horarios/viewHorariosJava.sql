create or alter view Karate.viewHorariosJava as SELECT
P.Nome, H.HorarioInicio,
    case when H.HorarioInicio is not null THEN
    DATEADD(MINUTE,45,HorarioInicio)
    end as  HorarioFinal,

    H.diaSemana, H.Turma


    from Karate.HorariosAula H join
        Karate.Professor P on P.id_Prof = H.id_Prof
    
    where 1>0

