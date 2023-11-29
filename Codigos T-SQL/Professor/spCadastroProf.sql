create or alter PROCEDURE Karate.spCadastroProf
@Nome varchar (20),@sobrenome varchar(20),@CPF char(14), @sexo char(1),@Telefone char(14)
as
BEGIN

insert into Karate.Professor (nome,sobrenome,cpf,sexo,telefone,dataCadastro) VALUES
(@nome,@sobrenome,@cpf,@sexo,@telefone,GETDATE())

END
