---*************************MANEJAR LA TABLA PERSONA, ESTUDIANTE, DOCENTE *************************
--select * from sis.v_estudiante where cedula = 12187525;
--select * from sis.v_docente where cedula = 17559834;
--select *  from  sis.t_persona where cedula = 12187525;

--insertar en la tabla persona
insert into sis.t_persona (  codigo,   cedula,    rif,
  nombre1,  nombre2,   apellido1,     apellido2,
  sexo,    fec_nacimiento,   tip_sangre,
  telefono1,   telefono2,
  cor_personal,   cor_institucional,
  direccion
 )
 values(
    (select max(codigo) + 1 from sis.t_persona),     18233663,   null,
    'ANDREA',  'ALEJANDRA'  ,    'CANINO',  NULL,
    'F',    '08/08/1988',    null,
    '04142240773',    null,
    'andreacalejandra@gmail.com',    null,
    'San Antonio'
); 
 

--insertar un estudiante en la tablas sis.t_estudiante.
iinsert into sis.t_estudiante(codigo,cod_instituto,cod_pensum ,num_carnet,num_expediente,cod_rusnies,cod_estado)
     values ((select codigo  from  sis.t_persona where cedula = ),11,1,null,null,null,'A');


--insertar un estudiante en la tablas sis.t_docente
iinsert into sis.t_docente( codigo,cod_instituto,num_empleado,cod_estado)
    values ((select codigo  from  sis.t_persona where cedula = 18233663),11,null,'A');
--ddelete from  sis.t_persona where cedula = 10000;

--ddelete from sis.t_docente where codigo = (select codigo from sis.t_persona where cedula = '10000');
--ddelete from sis.t_estudiante where codigo = (select codigo from sis.t_persona where cedula = '10000');
--*********************************************************************************************
