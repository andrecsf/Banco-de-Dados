-- Views

-- Informações dos músicos + Informações das orquestras
create view musicos_info_orquestra_info as
	select m.id_musico "ID",
		m.nome "Nome do músico",
        m.nacionalidade "Nacionalidade",
        timestampdiff(year, m.data_nascimento, curdate()) "Idade",
        o.nome "Nome da Orquestra",
        o.cidade "Cidade",
        o.pais "País"
        from musico m
        inner join orquestra o on m.id_orquestra = o.id_orquestra
			order by m.id_musico;
        
        select * from musicos_info_orquestra_info;
        
-- Sinfonias com detalhes da orquestra
create view sinfonia_detalhada as
	select s.id_sinfonia "ID",
		s.nome "Nome da Sinfonia",
        s.compositor "Compositor",
        year(s.data_criacao) "Ano de Composição",
        o.nome "Orquestra",
		o.cidade "Cidade",
        o.pais "País"
        from sinfonia s
        inner join orquestra o on s.id_orquestra = o.id_orquestra
			order by s.id_sinfonia;
		
        select * from sinfonia_detalhada;
        
-- Instrumentos por músico
create view instrumento_musico as
	select m.nome "Nome do Músico",
		o.nome "Orquestra",
        group_concat(i.nome_instrumento order by i.nome_instrumento separator ", ") "Instrumentos",
        count(mi.id_instrumento) "Quantidade de Instrumentos"
        from musico m
        inner join orquestra o on m.id_orquestra = o.id_orquestra
        inner join musico_instrumento mi on m.id_musico = mi.id_musico
        inner join instrumento i on mi.id_instrumento = i.id_instrumento
			group by m.id_musico, m.nome, o.nome
				order by count(mi.id_instrumento) desc;
                
		select * from instrumento_musico;

-- Participação em sinfonias
create view participacao_sinfonia as
	select m.nome "Nome do Músico",
		o.nome "Orquestra",
        s.nome "Sinfonia",
        f.nome_funcao "Função",
        i.nome_instrumento "Instrumento",
        date_format(mfs.data_assumicao, "%d/%m/%Y") "Data de Entrada"
        from musico m 
        inner join orquestra o on m.id_orquestra = o.id_orquestra
        inner join musico_funcao_sinfonia mfs on m.id_musico = mfs.id_musico
        inner join sinfonia s on mfs.id_sinfonia = s.id_sinfonia
        inner join funcao f on mfs.id_funcao = f.id_funcao
        inner join instrumento i on mfs.id_instrumento = i.id_instrumento
			order by m.nome;
            
		select * from participacao_sinfonia;


-- Estatísticas por orquestra
create view estatisticas_orquestra as
	select o.nome "Orquestra",
		o.cidade "Cidade",
        o.pais "País",
        year(o.data_criacao) "Ano de Funcação",
        count(distinct m.id_musico) "Total de Músicos",
        count(distinct s.id_sinfonia) "Total de Sinfonias",
        count(distinct mi.id_instrumento) "Total de Instrumentos Utilizados"
        from orquestra o
        left join musico m on o.id_orquestra = m.id_orquestra
        left join sinfonia s on o.id_orquestra = s.id_orquestra
        left join musico_instrumento mi on m.id_musico = mi.id_musico
			group by o.id_orquestra, o.nome, o.cidade, o.pais, o.data_criacao
				order by o.nome;

		select * from estatisticas_orquestra;
        
-- Músicos por faixa etária
create view musicos_faixa_etaria as
	select m.nome "Nome do Músico",
		timestampdiff(year, m.data_nascimento, curdate()) "Idade",
		case
			when timestampdiff(year, m.data_nascimento, curdate()) < 25 then "Jovem"
			when timestampdiff(year, m.data_nascimento, curdate()) between 25 and 40 then "Adulto"
			when timestampdiff(year, m.data_nascimento, curdate()) between 41 and 60 then "Experiente"
			else "Sênior"
			end "Faixa Etária",
		o.nome "Orquestra",
		m.nacionalidade "Nacionalidade"
		from musico m
		inner join orquestra o on m.id_orquestra = o.id_orquestra
			order by m.nome;

		select * from musicos_faixa_etaria;

-- Função por Instrumento
create view funcao_instrumento as
	select i.nome_instrumento "Instrumento",
		f.nome_funcao "Função",
		count(mfs.id_musico) "Total Ocorrências",
		concat(round(count(mfs.id_musico) * 100.0 / (
		select count(*)
		from musico_funcao_sinfonia mfs2
		where mfs2.id_instrumento = i.id_instrumento
		), 1), "%") "Frequência"
		from instrumento i 
		inner join musico_funcao_sinfonia mfs on i.id_instrumento = mfs.id_instrumento
		inner join funcao f on mfs.id_funcao = f.id_funcao
			group by i.id_instrumento, i.nome_instrumento, f.id_funcao, f.nome_funcao
				having count(mfs.id_musico) > 0
					order by i.nome_instrumento, count(mfs.id_musico) desc;

		select * from funcao_instrumento;

-- Composições por Autor
create view composicoes_autor as
	select s.compositor "Autor",
		count(s.id_sinfonia) "Total de Sinfonias",
		group_concat(distinct o.nome order by o.nome separator "; ") "Orquestras",
		min(year(s.data_criacao)) "Primeira Composição",
		max(year(s.data_criacao)) "Última Composição"
		from sinfonia s
		inner join orquestra o on s.id_orquestra = o.id_orquestra
			group by s.compositor
				order by count(s.id_sinfonia) desc;

		select * from composicoes_autor;

-- Músicos Multinstrumentalistas
create view musicos_multinstrumentalistas as
	select m.nome "Músico",
		o.nome "Orquestra",
        count(distinct mi.id_instrumento) "Quantidade de Instrumentos",
        group_concat(distinct i.nome_instrumento order by i.nome_instrumento separator ", ") "Instrumentos"
        from musico m 
        inner join orquestra o on m.id_orquestra = o.id_orquestra
        inner join musico_instrumento mi on m.id_musico = mi.id_musico
        inner join instrumento i on mi.id_instrumento = i.id_instrumento
			group by m.id_musico, m.nome, o.nome
				having count(distinct mi.id_instrumento) > 1
					order by m.nome;
		
        select * from musicos_multinstrumentalistas;

-- Instrumentos Mais Populares
create view instrumentos_populares as
	select i.nome_instrumento "Instrumento",
   		count(distinct mi.id_musico) "Total de Músicos",
    	round(count(distinct mi.id_musico) * 100.0 / (select count(distinct id_musico) from
    	musico_instrumento), 1) "Percentual"
    	from instrumento i
    	left join musico_instrumento mi on i.id_instrumento = mi.id_instrumento
			group by i.id_instrumento, i.nome_instrumento
				order by count(distinct mi.id_musico) desc;
            
		select * from instrumentos_populares;
