-- Alter Table

-- Adicionar email para os músicos
alter table musico 
	add column email varchar(100);
    
-- Tornar campo email obrigatório
alter table musico
	modify column email varchar(100) not null;
    
-- Adicionar gênero musical à sinfonia
alter table sinfonia
	add column genero_musical varchar(50);
    
-- Adicionar nível dos músicos com determinado instrumento
alter table musico_instrumento
	add column nivel_proficiencia enum ('Iniciante', 'Intermediario', 'Avançado');
    
-- Adicionar condição do instrumento
alter table instrumento
	add column condicao enum ('Antigo', 'Usado', 'Novo');

-- Aumentar o nome do campo nome da orquestra
alter table orquestra
	modify column nome varchar(150);
    
-- Adicionar valor padrão para data
alter table musico_funcao_sinfonia
	modify column data_assumicao date default current_timestamp;
    
-- Renomear tabela Função
alter table funcao
	rename to cargo;

-- Renomear coluna
alter table musico
	rename column identidade to documento_identificacao;
    
-- Excluir coluna
alter table orquestra
	drop column data_criacao;
 
