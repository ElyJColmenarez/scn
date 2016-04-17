--22-abr-2015
-- Johan, Jhonny, Geraldine, Juan

CREATE DATABASE bd_scnfinal
  WITH OWNER = usuarioscn
       ENCODING = 'UTF8'
  CONNECTION LIMIT = -1;
  
  
--cambia el formato de la fecha a Dia/mes/año para consulta e insercion
alter database  bd_scnfinal SET DateStyle to 'sql,dmy';


