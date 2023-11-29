-- Inserir dados do Professor 1 (Rafael Moreira Silva Costa)
INSERT INTO Karate.Professor (Id_Prof, Nome)
VALUES (1, 'Rafael Moreira Silva Costa');

-- Inserir horários para o Professor 1 (Rafael Moreira Silva Costa)
INSERT INTO Karate.HorariosAula (Id_Prof, DiaSemana, HorarioInicio)
 VALUES 
       (1, 'Segunda-Feira', '18:00:00'), -- Segunda-feira às 18:00
       (1,'Quarta-Feira', '18:00:00'); -- Quarta-feira às 18:00

-- Inserir dados do Professor 2 (Roger Otávio Nemo)
INSERT INTO Karate.Professor (Id_Prof, Nome)
VALUES (2, 'Roger Otávio Nemo');

-- Inserir horários para o Professor 2 (Roger Otávio Nemo)
INSERT INTO Karate.HorariosAula (Id_Prof, DiaSemana, HorarioInicio)
VALUES
       (2,'Terça-Feira', '19:00:00'), -- Terça-feira às 18:00
       (2, 'Quinta-Feira', '19:00:00'), -- Quinta-feira às 18:00
       (2, 'Sexta-Feira', '19:30:00'); -- Sexta-feira às 18:00




--Inserts Faixas.

INSERT INTO Karate.Faixa (Id_Faixa,Cor)
VALUES (0,'Branca'), 
       (1,'Amarela'), 
       (2,'Laranja'), 
       (3,'Verde'), 
       (4,'Azul'), 
       (5,'Roxa'), 
       (6,'Marrom'), 
       (7,'Preta');

-- Inserts Turma

INSERT into Karate.Turmas(turma)
VALUES ('A'),('B')



--Update Tabela Horario

Update Karate.HorariosAula
set Turma = 'A'
where Id_Prof = 1

Update Karate.HorariosAula
set Turma = 'B'
where Id_Prof = 2



select * from Karate.Aluno

--Insert Tabela ADM

INSERT INTO Karate.ADM (nome,cpf,senha) VALUES ('Pedro Sápiras','168.388.312-90','BloodsADM')



