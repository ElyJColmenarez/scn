select cedula,nombre1,apellido1 from sis.t_persona where apellido1 like '%ALBAR%';

create user albarrani password '14';
insert into per.t_usuario (nombre,codigo,tipo) 
       values('albarrani',
               (select codigo from sis.t_persona where cedula = 8812054), --aqui
               'U');
select * from per.t_usuario;



grant all privileges on schema sis,per,err,public to albarrani; --aqui

grant all privileges on table
	sis.t_cur_estudiante,		sis.t_curso,				sis.t_docente,
	sis.t_est_cur_estudiante,	sis.t_est_docente,			sis.t_est_estudiante,
	sis.t_est_periodo,			sis.t_est_usu_con_estudios,	sis.t_est_usu_enc_pensum,
	sis.t_est_usu_ministerio,	sis.t_estudiante,			sis.t_estudiante_temp,
	sis.t_fotografia,			sis.t_instituto,			sis.t_pensum,	
	sis.t_periodo,				sis.t_persona,				sis.t_persona_temp_2,
	sis.t_prelacion, 			sis.t_tip_uni_curricular,	sis.t_trayecto,
	sis.t_uni_curricular,		sis.t_usu_con_estudios, 	sis.t_usu_enc_pensum,
	sis.t_usu_ministerio,
	sis.v_estudiante,			sis.v_docente,				sis.v_cur_estudiante_temp,
	sis.v_pensum,				sis.v_prelacion,
	sis.t_curso_codigo_seq,
	per.t_menu,					per.t_mod_usuario,			per.t_modulo,
	per.t_tabla,				per.t_usuario,
	err.t_error,				err.t_est_error
	to albarrani;  --aqui

--grant a las tablas de err.
--grant a las tablas de aud
--grant a las tablas de per
