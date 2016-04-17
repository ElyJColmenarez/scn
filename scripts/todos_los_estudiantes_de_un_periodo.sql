
select distinct e.cor_personal--,ce.*,c.* 
  from sis.t_cur_estudiante as ce
           inner join 
       sis.t_curso as c on ce.cod_curso = c.codigo
           inner join
       sis.t_persona as e on ce.cod_estudiante = e.codigo
           inner join
       sis.t_periodo as per on c.cod_periodo = per.codigo
           inner join
       sis.t_pensum as pen on per.cod_pensum = pen.codigo
           inner join
       sis.t_uni_curricular as uc on c.cod_uni_curricular = uc.codigo
           inner join 
       sis.t_trayecto as t on uc.cod_trayecto = t.codigo
 where per.nombre = '2015-2016'
   and pen.nom_corto = 'PNFI'
   and t.num_trayecto = 1;




--select * from sis.t_periodo;
--select * from sis.t_pensum;
--select * from sis.t_uni_curricular;
--select * from sis.t_trayecto;
--select * from sis.v_pensum;

