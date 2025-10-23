-- Relatórios com Select e Join

-- Relatório básico de músicos e suas respectivas orquestras
select m.nome "Nome do Músico",
	m.nacionalidade "Nacionalidade",
    date_format(m.data_nascimento, "%d/%m/%Y") "Data de Nascimento",
	o.nome "Nome da Orquestra",
    o.cidade "Cidade de Origem (Orquestra)",
    o.pais "País de Origem (Orquestra)"
    from musico m
    inner join orquestra o on m.id_orquestra = o.id_orquestra;
    
-- Relatório mostrando os músicos em Orquestras com nome 'Orquestra Sinfônica'
select m.nome "Nome do Músico",
	m.nacionalidade "Nacionalidade",
    o.nome "Nome da Orquestra"
    from musico m
    inner join orquestra o on m.id_orquestra = o.id_orquestra
		where o.nome like "Orquestra Sinfônica%";

-- Relatório de Orquestras com músicos de determinada nacionalidade
select o.nome "Orquestra",
	o.cidade "Cidade da Orquestra",
    o.pais "País da Orquestra",
    m.nacionalidade "Nacionalidade",
    group_concat(m.nome separator ', ') "Músicos"
    from orquestra o
    inner join musico m on o.id_orquestra = m.id_orquestra
    where m.nacionalidade like "Brasileir%"
    group by o.id_orquestra, o.nome, o.cidade, o.pais, m.nacionalidade;

-- Relatório de Orquestra e sua relação com as sinfonias
select o.nome "Orquestra",
	concat(o.cidade, " - ", o.pais) "Localização",
    year(o.data_criacao) "Ano de Fundação",
    s.nome "Nome da Sinfonia",
    s.compositor "Compositor da Sinfonia",
    year(s.data_criacao) "Ano de Composição"
    from orquestra o
    inner join sinfonia s on o.id_orquestra = s.id_orquestra
    order by o.nome, s.data_criacao;

-- Relatório de Músicos e Instrumentos
select m.nome "Nome do Músico",
	m.identidade "Documento",
    m.nacionalidade "Nacionalidade",
    timestampdiff(year, m.data_nascimento, curdate()) "Idade",
    group_concat(i.nome_instrumento order by i.nome_instrumento separator ", ") "Instrumentos",
    o.nome "Nome da Orquestra"
    from musico m
    inner join musico_instrumento mi on m.id_musico = mi.id_musico
    inner join instrumento i on mi.id_instrumento = i.id_instrumento
    inner join orquestra o on m.id_orquestra = o.id_orquestra
    group by m.id_musico
    order by o.nome, m.nome;
    
-- Relatório de 10 instrumentos tocados por mais músicos
select i.nome_instrumento "Instrumento",
	count(mi.id_musico) "Quantidade de Músicos",
    concat(i.nome_instrumento, " - ", count(mi.id_musico), " músicos") "Total"
    from instrumento i 
    left join musico_instrumento mi on i.id_instrumento = mi.id_instrumento
    group by i.id_instrumento
    order by count(mi.id_musico) desc
    limit 10;

-- 7 Relatório de Orquestra e a faixa etária dos seus músicos
select o.nome "Orquestra",
	m.nome "Nome do Músico",
	timestampdiff(year, m.data_nascimento, curdate()) "Idade",
	case
		when timestampdiff(year, m.data_nascimento, curdate()) < 25 then "Jovem"
        when timestampdiff(year, m.data_nascimento, curdate()) between 25 and 40 then "Adulto"
        when timestampdiff(year, m.data_nascimento, curdate()) between 41 and 60 then "Experiente"
        else "Sênior"
        end "Faixa Etária"
        from musico m
        inner join orquestra o on m.id_orquestra = o.id_orquestra
        group by o.nome, m.data_nascimento, m.nome
        order by o.nome;

-- Relatório de quantos músicos participam de cada sinfonia em cada orquestra
select o.nome "Nome da Orquestra",
	s.nome "Nome da Sinfonia",
    s.compositor "Nome do Compositor",
    count(mfs.id_musico) "Total de Músicos"
    from orquestra o
    inner join sinfonia s on o.id_orquestra = s.id_orquestra
    inner join musico_funcao_sinfonia mfs on s.id_sinfonia = mfs.id_sinfonia
    group by o.nome, s.nome, s.compositor
    order by o.nome;

-- Relatório de Distribuição de Funções por Sinfonia
select m.nome "Músico",
	f.nome_funcao "Função",
    count(mfs.id_sinfonia) "Total de Sinfonias"
    from musico m
    inner join musico_funcao_sinfonia mfs on m.id_musico = mfs.id_musico
    inner join funcao f on mfs.id_funcao = f.id_funcao
    group by m.nome, f.nome_funcao
    order by m.nome;

-- Relatório de instrumentos utilizados por Músicos nas Sinfonias
select m.nome "Músico",
	i.nome_instrumento "Instrumento Utilizado",
    count(mfs.id_sinfonia) "Sinfonias Participadas"
    from musico m
    inner join musico_funcao_sinfonia mfs on m.id_musico = mfs.id_musico
    inner join instrumento i on mfs.id_instrumento = i.id_instrumento
    group by
    m.nome, i.nome_instrumento
    order by
    m.nome, count(mfs.id_sinfonia) desc;
    
-- Relatório de quantos músicos tem determinada função em uma Sinfonia
select s.nome "Sinfonia",
	s.compositor "Compositor",
    f.nome_funcao "Função",
    count(mfs.id_musico) "Quantidade de Músicos"
    from sinfonia s
    inner join musico_funcao_sinfonia mfs on s.id_sinfonia = mfs.id_sinfonia
    inner join funcao f on mfs.id_funcao = f.id_funcao
    group by s.nome, s.compositor, f.nome_funcao
    order by s.nome, count(mfs.id_musico) desc;

-- Relatório de todas as participações de músicos em sinfonias
select o.nome "Orquestra",
	m.nome "Músico",
    s.nome "Sinfonia",
    s.compositor "Compositor",
    date_format(mfs.data_assumicao, "%d/%m/%Y") "Data de Entrada"
    from orquestra o 
    inner join musico m on o.id_orquestra = m.id_orquestra
    inner join musico_funcao_sinfonia mfs on m.id_musico = mfs.id_musico
    inner join sinfonia s on mfs.id_sinfonia = s.id_sinfonia
    order by o.nome, s.nome, m.nome;

-- 13 Relatório de músicos, funções, instrumentos e sinfonias
select m.nome "Músico",
	f.nome_funcao "Função",
    i.nome_instrumento "Instrumento",
    s.nome "Sinfonia",
    date_format(mfs.data_assumicao, "%d/%m/%Y") "Data de Entrada"
    from musico m
    inner join musico_funcao_sinfonia mfs on m.id_musico = mfs.id_musico
    inner join funcao f on mfs.id_funcao = f.id_funcao
    inner join instrumento i on mfs.id_instrumento = i.id_instrumento
    inner join sinfonia s on mfs.id_sinfonia = s.id_sinfonia
    order by m.nome, s.nome;

-- Relatório de distribuição de função por orquestra e sinfonia
select o.nome "Orquestra",
	s.nome "Sinfonia",
    f.nome_funcao "Função",
    count(mfs.id_musico) as "Total de Músicos"
    from orquestra o
    inner join sinfonia s on o.id_orquestra = s.id_orquestra
    inner join musico_funcao_sinfonia mfs on s.id_sinfonia = mfs.id_sinfonia
    inner join funcao f on mfs.id_funcao = f.id_funcao
    group by o.nome, s.nome, f.nome_funcao
    order by o.nome, s.nome, count(mfs.id_musico) desc;

-- Relatório de alocação por orquesta, músico, sinfonia e função 
select o.nome "Orquestra",
	m.nome "Músico",
    s.nome "Sinfonia",
    f.nome_funcao "Função",
    year(mfs.data_assumicao) "Ano de entrada"
    from orquestra o
    inner join musico m on o.id_orquestra = m.id_orquestra
    inner join musico_funcao_sinfonia mfs on m.id_musico = mfs.id_musico
    inner join sinfonia s on mfs.id_sinfonia = s.id_sinfonia
    inner join funcao f on mfs.id_funcao = f.id_funcao
    order by o.nome;

-- Relatório com métricas agregadas de cada orquestra
select o.nome "Orquestra",
	count(distinct m.id_musico) "Total de Músicos",
    count(distinct s.id_sinfonia) "Total de Sinfonias",
    count(distinct f.id_funcao) "Funções Distintas",
    count(distinct i.id_instrumento) "Instrumentos Utilizados"
    from orquestra o 
    left join musico m on o.id_orquestra = m.id_orquestra
    left join sinfonia s on o.id_orquestra = s.id_orquestra
    left join musico_funcao_sinfonia mfs on m.id_musico = mfs.id_musico
    left join funcao f on mfs.id_funcao = f.id_funcao
    left join instrumento i on mfs.id_instrumento = i.id_instrumento
    group by o.id_orquestra, o.nome
    order by count(distinct m.id_musico) desc;

-- Relatório de músicos que tocam diferentes instrumentos
select m.nome "Músico",
	o.nome "Orquestra",
    count(distinct mi.id_instrumento) "Instrumentos Distintos",
    group_concat(distinct i.nome_instrumento order by i.nome_instrumento separator ", ") "Instrumentos"
    from musico m
	inner join orquestra o on m.id_orquestra = o.id_orquestra
    inner join musico_instrumento mi on m.id_musico = mi.id_musico
    inner join instrumento i on mi.id_instrumento = i.id_instrumento
    group by m.id_musico, m.nome, o.nome
    having count(distinct mi.id_instrumento) > 1
    order by count(distinct mi.id_instrumento) desc;

-- Relatório mostrando qual maior frequência de uso(função) de casa instrumento
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

-- Relatório de mulheres brasileiras por orquestra
select o.nome "Orquestra",
	count(*) "Quantidade de Mulheres",
    group_concat(m.nome order by m.nome separator ", ") "Nomes"
    from musico m
    inner join orquestra o on m.id_orquestra = o.id_orquestra
    where m.nacionalidade = "Brasileira"
    group by o.id_orquestra, o.nome
    having count(*) > 0 
    order by count(*) desc;

-- Relatório de homens europeus por orquestra
select o.nome "Orquestra",
	count(*) "Quantidade de Homens Europeus",
    group_concat(m.nome order by m.nome separator ", ") "Nomes"
    from musico m
    inner join orquestra o on m.id_orquestra = o.id_orquestra
    where m.nacionalidade in ("Alemão", "Inglês", "Francês", "Italiano", "Português", "Austríaco", "Russo")
    group by o.id_orquestra, o.nome
    having count(*) > 0 
    order by count(*) desc;	




