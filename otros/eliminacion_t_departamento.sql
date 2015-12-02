start transaction;


alter table sis.t_periodo rename cod_departamento to cod_instituto;

alter table sis.t_periodo drop constraint fk_periodo__departamento;

update sis.t_periodo set cod_instituto=11;

alter table sis.t_periodo
  add constraint fk_periodo__intituto FOREIGN KEY (cod_instituto)
      REFERENCES sis.t_instituto (codigo);




alter table sis.t_docente rename cod_departamento to cod_instituto;

 alter table sis.t_docente
  drop constraint fk_docente__departamento;
update sis.t_docente set cod_instituto=11;

 alter table sis.t_docente
  add constraint fk_docente__intituto FOREIGN KEY (cod_instituto)
      REFERENCES sis.t_instituto (codigo);




 alter table sis.t_estudiante rename cod_departamento to cod_instituto;   
 
  alter table sis.t_estudiante
  drop constraint fk_estudiante__departamento; 
  
   update sis.t_estudiante set cod_instituto=11;
   
   alter table sis.t_estudiante
  add constraint fk_estudiante__intituto FOREIGN KEY (cod_instituto)
      REFERENCES sis.t_instituto (codigo);



 alter table sis.t_usu_departamento rename to t_usu_enc_pensum;
 
 alter table sis.t_est_usu_departamento rename to t_est_usu_enc_pensum;
 
 alter table sis.t_usu_enc_pensum
 drop constraint cp_usu_departamento;
 
 alter table sis.t_usu_enc_pensum
 drop constraint cf_est_usu_departamento;
 
 alter table sis.t_est_usu_enc_pensum
 drop constraint cp_est_usu_departamento;

  alter table sis.t_est_usu_enc_pensum
 add constraint cp_est_usu_enc_pesum primary key (codigo);
 
alter table sis.t_usu_enc_pensum rename cod_departamento to cod_instituto;

alter table sis.t_usu_enc_pensum add column cod_pensum integer;

alter table sis.t_usu_enc_pensum
 drop constraint cf_usu_dep_departamento;

/* ******************************************************************************************* */

--agregado por JA y JD, 22-04-15
alter table sis.t_usu_enc_pensum
   drop constraint fk_jefe_departamento__departamento;

 
 update sis.t_usu_enc_pensum set cod_instituto=11;

 
alter table sis.t_usu_enc_pensum
  add constraint fk_usu_enc_pensum_instituto FOREIGN KEY (cod_instituto)
      REFERENCES sis.t_instituto (codigo);
alter table sis.t_usu_enc_pensum
  add constraint fk_usu_enc_pensum_pensum FOREIGN KEY (cod_pensum)
      REFERENCES sis.t_pensum (codigo);
alter table sis.t_usu_enc_pensum
  add constraint fk_usu_enc_pensum_est_usu_enc_pensum FOREIGN KEY (cod_estado)
      REFERENCES sis.t_est_usu_enc_pensum (codigo);


alter table sis.t_usu_enc_pensum
  add constraint cp_usu_enc_pensum primary KEY (codigo);

--agreado por JA y JD. 22-04-15
drop view sis.v_cur_estudiante;

drop table sis.t_departamento;
 
grant all privileges on table sis.t_usu_ministerio to usuarioscn;


 -------  FIN SCRIPT -------------------------------------------------
  

  select u.*, per.*,minis.codigo as ministerio,depar.codigo as departamento,
       							    depar.codigo as codigo_departamento_depa,doce.codigo as docente,
       								doce.cod_instituto as codigo_departamento_doce, estudi.codigo as estudiante,
       								estudi.cod_pensum,estudi.cod_instituto as codigo_departamento_estu,
       								conEstudio.codigo as conEstudios,conEstudio.cod_instituto as cod_instituto_con,
      								departamento.nombre as nombre_departamento_depa,departamento1.nombre as nombre_departamento_doce,
      								departamento2.nombre as nombre_departamento_estu,
       								instituto.nombre as instituto_nombre_depa, instituto.codigo as instituto_codigo_depa,instituto1.nombre as instituto_nombre_doce,
       								instituto1.codigo as instituto_codigo_doce,instituto2.nombre as instituto_nombre_estu,instituto2.codigo as instituto_codigo_estu,
      							 	instituto3.nombre as instituto_nombre_con
							 from per.t_usuario as u
									left join sis.t_persona as per on (per.codigo=u.codigo)
       								left join sis.t_usu_ministerio as minis on (per.codigo=minis.codigo)
									left join sis.t_usu_enc_pensum as depar on (per.codigo=depar.codigo)
									left join sis.t_usu_con_estudios as conEstudio on (per.codigo=conEstudio.codigo)
									left join sis.t_estudiante as estudi on (per.codigo=estudi.codigo)
									left join sis.t_docente as doce on (per.codigo=doce.codigo)
									left join sis.t_instituto as departamento on (depar.cod_instituto=departamento.codigo)
									left join sis.t_instituto as departamento1 on (doce.cod_instituto=departamento1.codigo)
									left join sis.t_instituto as departamento2 on (estudi.cod_instituto=departamento2.codigo)
									left join sis.t_instituto as instituto on (departamento.codigo=instituto.codigo)
									left join sis.t_instituto as instituto1 on (departamento1.codigo=instituto1.codigo)
									left join sis.t_instituto as instituto2 on (departamento2.codigo=instituto2.codigo)
									left join sis.t_instituto as instituto3 on (conEstudio.cod_instituto=instituto3.codigo)
							where u.nombre='alamoj'

alter user alamoj with password '123'

select p.*,p.codigo as codigo ,ins.codigo as ins_codigo,ins.nombre as nombre_instituto
						   from sis.t_periodo as p
								inner join sis.t_instituto as ins on (p.cod_instituto=ins.codigo)
								
							where ins.codigo=? and p.cod_pensum=?



      

