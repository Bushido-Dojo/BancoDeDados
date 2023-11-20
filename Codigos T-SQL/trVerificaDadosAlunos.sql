create or alter trigger Karate.trVerificaDadosAlunos
on Karate.Aluno
after insert, update
as
begin
    declare @Id_Faixa int, @nome varCHAR, @sobrenome VARCHAR, @cpf CHAR(11), @email VARCHAR(50), @celular char(11), @dataNascimento DATE

    select @Id_Faixa = Id_Faixa from inserted
    select @nome = nome from inserted
    select @sobrenome = sobrenome from inserted
    select @cpf = CPF from inserted
    select @email = EMail from inserted
    select @celular = Celular from inserted
    select @dataNascimento = Data_Nascimento


    