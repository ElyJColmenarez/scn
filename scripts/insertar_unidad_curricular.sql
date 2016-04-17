select * from sis.v_pensum;

select * from sis.t_uni_curricular where codigo = 52;

--    eliminar restricción
--alter table sis.t_uni_curricular 
--	alter column cod_uni_ministerio 
--	   drop not null;


insert into sis.t_uni_curricular (
	codigo,
	cod_uni_ministerio,
	cod_trayecto,
	nombre,
	cod_tipo,
	hta,
	hti,
	uni_credito,
	dur_semanas,
	not_min_aprobatoria,
	not_maxima
) values (
--	(select max(codigo) + 1 from sis.t_uni_curricular),
	null,
	2, -- es el código,
	'Lógica y Depuración',
	'E',
	5,
	1.5,
	3,
	12,
	12,
	20
);




