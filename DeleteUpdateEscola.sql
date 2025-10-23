-- Delete e Update

-- Deletar músico específico
delete from musico
	where nome = "Hugo Rocha";
    
-- Deletar músicos pertencentes a uma nacionalidade específica
delete from musico
	where nacionalidade = "alemão" or nacionalidade = "alemã";

-- Deletar sinfonia por compositor
delete from sinfonia
	where compositor like "%Beethoven";

-- Deletar orquestra de uma cidade específica
delete from orquestra
	where cidade = "São Paulo";

-- Deletar músicos com mais de 50 anos
delete from musico
	where data_nascimento < date_sub(curdate(), interval 50 year);

-- Deletar sinfonias criadas antes de 1900
delete from sinfonia
	where data_criacao < '1900-01-01';

-- Deletar instrumento não utilizado
delete from instrumento
	where id_instrumento not in (select distinct id_instrumento from musico_instrumento);

-- Deletar orquestras sem músicos
delete from orquestra
where id_orquestra not in (select distinct id_orquestra from musico);

-- Deletar sinfonias de vários compositores
delete from sinfonia
	where compositor like "%Tchaikovsky" or 
    compositor like "%Chopin" or
    compositor like "%Schumann";

-- Atualizar nacionalidade
update musico
	set nacionalidade = "Brasileiro" 
		where nacionalidade = "Português";

-- Atualizar cidade de uma orquestra
update orquestra
	set cidade = "São Paulo", pais = "Brasil"
		where nome = "Orquestra Sinfônica Brasileira";

-- Atualizar nome de função
update funcao
	set nome_funcao = "Primeiro Violino"
		where nome_funcao = "Spalla";

-- Atualizar data para função recente
update musico_funcao_sinfonia
	set data_assumicao = "2024-01-15"
		where data_assumicao < "2024-01-01"
			and id_funcao = 1;

-- Atualizar nome de instrumento
update instrumento
	set nome_instrumento = "Violino elétrico"
		where nome_instrumento = "Violino";

-- Atualizar nome adicionando sufixo
update orquestra
	set nome = concat(nome, " - Orquestra");
    
-- Atualizar nome adicionando sufixo
update sinfonia
	set nome = concat(nome, " - Sinfonia");

-- Atualizar data de nascimento
update musico
	set data_nascimento = "1985-05-20"
		where id_musico = 1;

-- Atualizar compositor de sinfonia
update sinfonia
	set compositor = "Ludwig van Beethoven"
		where nome like "%Sinfonia nº 5%";

-- Atualizar função
update funcao
	set nome_funcao = "Regente Assistente"
		where id_funcao = 5;

-- Atualizar função adicionando instrumento
update funcao
	set nome_funcao = concat(nome_funcao, " / Violino Barroco")
		where nome_funcao like "%Violino%";

 