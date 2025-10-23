-- Drop Database

use escolamusica;
start transaction;
drop table if exists musico_funcao_sinfonia;
drop table if exists musico_instrumento;
drop table if exists musico;
drop table if exists sinfonia;
drop table if exists funcao;
drop table if exists instrumento;
drop table if exists orquestra;
rollback;

drop database escolamusica;
