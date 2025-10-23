-- Drop Database

use escolamusica;
drop table if exists musico_funcao_sinfonia;
drop table if exists musico_instrumento;
drop table if exists musico;
drop table if exists sinfonia;
drop table if exists funcao;
drop table if exists instrumento;
drop table if exists orquestra;
drop view if exists musicos_info_orquestra_info;
drop view if exists sinfonia_detalhada;
drop view if exists instrumento_musico;
drop view if exists participacao_sinfonia;
drop view if exists estatisticas_orquestra;
drop view if exists musicos_faixa_etaria;
drop view if exists funcao_instrumento;
drop view if exists composicoes_autor;
drop view if exists musicos_multinstrumentalistas;
drop view if exists instrumentos_populares;

drop database escolamusica;
