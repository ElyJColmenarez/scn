<?php
class PeriodoServicio{


public static function cargarTrayectosPorPeriodo($codPeriodo){
			try{
				$conexion=Conexion::conectar();
				$consulta="select tr.* from sis.t_periodo as pe inner join sis.t_trayecto as tr 
											on pe.cod_pensum=tr.cod_pensum 
							where pe.codigo=?";
				$ejecutar=$conexion->prepare($consulta);
				$ejecutar->execute(array($codPeriodo));
				if($ejecutar->rowCount()!=0){
					return $ejecutar->fetchAll();
				
				}else 
					return null;
			}catch (Exception $e){
				throw $e;	
			}


		}
		
	public static function obtenerMax(){
		try{
			$conexion=Conexion::conectar();
			$consulta="select max(codigo) from sis.t_periodo";
			
			$ejecutar=$conexion->prepare($consulta);
			
			$ejecutar->execute(array());
			
			if($ejecutar->rowCount()!=0){
				$var = $ejecutar->fetchAll();
				return $var[0][0];
			}else 
				return 0;
		}
		catch(Exception $e){
			throw $e;
		}
	}

	public static function agregarPeriodo($per){
		try{
			$conexion=Conexion::conectar();
			$consulta="insert into sis.t_periodo(	codigo, 
													nombre,
													cod_pensum, 
													fec_inicio, 
													fec_final, 
													observaciones, 
													cod_estado,
													cod_instituto) 
						values (?,?,?,?,?,?,?,?)";
			
			$ejecutar=$conexion->prepare($consulta);
			
			$ejecutar->execute(array(	self::obtenerMax() + 1,
										$per->obtenerNombre(),
										$per->obtenerCodPensum(),
										$per->obtenerFecInicio(),
										$per->obtenerFecFinal(),
										$per->obtenerObservaciones(),
										$per->obtenerCodEstado(),
										$per->obtenerCodInstituto()
									));
		}
		catch(Exception $e){
			throw $e;
		}
	}
	
	public static function modificarPeriodo($per){
		try{
			$conexion=Conexion::conectar();
			$consulta="	update sis.t_periodo set nombre = ?, 
												cod_pensum = ?, 
												fec_inicio = ?, 
												fec_final = ?, 
												observaciones = ?, 
												cod_estado = ?,
												cod_instituto = ?
						where codigo = ?";
			
			$ejecutar=$conexion->prepare($consulta);
			
			$ejecutar->execute(array(	$per->obtenerNombre(),
										$per->obtenerCodPensum(),
										$per->obtenerFecInicio(),
										$per->obtenerFecFinal(),
										$per->obtenerObservaciones(),
										$per->obtenerCodEstado(),
										$per->obtenerCodInstituto(),
										$per->obtenerCodigo()
									));
		}
		catch(Exception $e){
			throw $e;
		}
	}
	
	/* Función inhabilitada por cambio en la base de datos
	
	public static function listarPorDepartamento($codDepartamento){
		try{
			$conexion=Conexion::conectar();
			$consulta="select * from sis.t_periodo where cod_departamento=?;";
			$ejecutar=$conexion->prepare($consulta);
			$ejecutar->execute(array($codDepartamento));
			if($ejecutar->rowCount()!=0){
				return $ejecutar->fetchAll();
			}else 
				return null;
		}catch (Exception $e){
			throw $e;	
		}
	}
	* 
	*/
	
	public static function obtenerEstado(){
		try{
			$conexion=Conexion::conectar();
			
			$consulta="select * from sis.t_est_periodo";
			
			$ejecutar=$conexion->prepare($consulta);
			
			$ejecutar->execute(array());
			
			if($ejecutar->rowCount()!=0){
				return $ejecutar->fetchAll();
			}else 
				return null;
		}
		catch(Exception $e){
			throw $e;
		}
	}
	
	public static function listar($inst, $estado, $pensum, $codigo){
		try{
			$arr = array();
			
			$conexion=Conexion::conectar();
			
			$consulta="select 	per.*, 
								est.nombre as nombreestado,
								pen.nombre as nombrepensum,
								inst.nombre as nombreinst,
								inst.codigo as codinst	
								from sis.t_periodo as per
								inner join sis.t_est_periodo as est
									on per.cod_estado = est.codigo
								inner join sis.t_pensum as pen
									on per.cod_pensum = pen.codigo
								inner join sis.t_instituto as inst
									on per.cod_instituto = inst.codigo
							";
			if($inst != ''){
				$consulta .= " where per.cod_instituto = ?";
				$arr[count($arr)] = $inst;
			}
			
			if($estado != ''){
				if($inst == '')
					$consulta .= " where per.cod_estado = ? ";
				else
					$consulta .= " and per.cod_estado = ? ";
				$arr[count($arr)] = $estado; 
			}
			
			
			if($pensum != '')	{
				$consulta .= " and per.cod_pensum = ?";
				$arr[count($arr)] = $pensum;
			}
			
			if($codigo != '')	{
				$consulta .= " and per.codigo = ?";
				$arr[count($arr)] = $codigo;
			}
				
			$consulta .= " order by per.nombre ";
			
			$ejecutar=$conexion->prepare($consulta);
			
			$ejecutar->execute($arr);
			
			if($ejecutar->rowCount()!=0){
				return $ejecutar->fetchAll();
			}else 
				return null;
		}catch (Exception $e){
			throw $e;	
		}
	}
	
	public static function listarPorInstitutoPensum($codPensum,$codInstituto){
		try{
				$conexion=Conexion::conectar();
				$consulta="select p.*,p.codigo as codigo ,ins.codigo as ins_codigo,ins.nombre as nombre_instituto
						   from sis.t_periodo as p
								inner join sis.t_instituto as ins on (p.cod_instituto=ins.codigo)
								
							where ins.codigo=? and p.cod_pensum=?";
				$ejecutar=$conexion->prepare($consulta);
				$ejecutar->execute(array($codInstituto,$codPensum));
				if($ejecutar->rowCount()!=0){
					return $ejecutar->fetchAll();
				
				}else 
					return null;
			}catch (Exception $e){
				throw $e;	
			}

	}
	public static function obtenerInformacionPeriodo($periodos){
		try{
			
			$conexion = Conexion::conectar();
			
			$consulta = "select 	per.codigo as cod_periodo,
									per.nombre as nom_periodo,
									per.fec_inicio,
									per.fec_final,
									per.observaciones,
									estp.nombre as est_periodo,
									pen.nombre as nom_pensum,
									pen.nom_corto as nom_cor_pensum,
									inst.nom_corto,
									inst.nombre
									from sis.t_periodo as per
									inner join sis.t_pensum as pen
										on pen.codigo = per.cod_pensum
									inner join sis.t_est_periodo as estp
										on per.cod_estado = estp.codigo
									inner join sis.t_instituto as inst
										on inst.codigo = per.cod_instituto
									where ";
									
			for($i = 0; $i < count($periodos); $i++)
				($i == 0)?$consulta .= " per.codigo = ? ":$consulta .= " or per.codigo = ? ";
									
			$ejecutar = $conexion->prepare($consulta);
			
			$ejecutar->execute($periodos);
			
			if($ejecutar->rowCount()!=0)
				return $ejecutar->fetchAll();
			else 
				return null;
			
		}
		catch(Exception $e){
			throw $e;
		}
	}
	
	public static function obtenerInformacionAlumnosReprobadosEnTodasUni($periodos){
		try{
			$conexion = Conexion::conectar();
			
			$consulta = "	select 		per.apellido1 || ', ' || per.nombre1 as nom_completo,
										per.cedula as cedula,
										count(*) as can_materias,
										(select count(*) 
										   from sis.t_cur_estudiante ce2
												inner join sis.t_curso as cur2
													on ce2.cod_curso = cur2.codigo
										   where ce2.cod_estudiante = ce.cod_estudiante
											 and cur2.cod_periodo = cur.cod_periodo
											 and ce2.cod_estado = 'R'
										) as can_reprobado,
										(select count(*) 
										   from sis.t_cur_estudiante ce2
												inner join sis.t_curso as cur2
													on ce2.cod_curso = cur2.codigo
										   where ce2.cod_estudiante = ce.cod_estudiante
											 and cur2.cod_periodo = cur.cod_periodo
											 and ce2.cod_estado = 'N'
										) as can_rep_inasistencia
									  from sis.t_cur_estudiante as ce
										  inner join sis.t_persona as per
											  on ce.cod_estudiante = per.codigo
										  inner join sis.t_curso as cur
											  on cur.codigo = ce.cod_curso
									where";
			
			for($i = 0; $i < count($periodos); $i++)
				($i == 0)?$consulta.= " cur.cod_periodo = ? ":$consulta.=" or cur.cod_periodo = ?";
									
			$consulta .= " group by nom_completo,
											 ce.cod_estudiante,
											 cur.cod_periodo,
											 cedula
									having count(*) = (select count(*) 
										   from sis.t_cur_estudiante ce2
												inner join sis.t_curso as cur2
													on ce2.cod_curso = cur2.codigo
										   where ce2.cod_estudiante = ce.cod_estudiante
											 and cur2.cod_periodo = cur.cod_periodo
											 and ce2.cod_estado in ('N','R'))
									order by can_materias desc;";				
			
			$ejecutar = $conexion->prepare($consulta);
			
			$ejecutar->execute($periodos);
			
			if($ejecutar->rowCount()!=0)
				return $ejecutar->fetchAll();
			else 
				return null;
		}
		catch (Exception $e){
			throw $e;
		}
	}
	
	/* PREGUNTAR A ALAMO SI PARAMETRIZO LA CANTIDAD */
	
	public static function obtenerMejoresPromedios($curEstudiante , $cantidad = 10){
		try{
			$conexion = Conexion::conectar();
			
			$consulta = "select 	per.cedula,
							per.apellido1 || ', ' || per.nombre1 as nombre,
							coalesce(sum(cast(curest.nota as float)* uni.uni_credito)/sum(uni.uni_credito),0) as prom,
							count(*) as materias
							from sis.t_cur_estudiante as curest
							inner join sis.t_persona as per
								on per.codigo = curest.cod_estudiante
							inner join sis.t_curso as cur
								on cur.codigo = curest.cod_curso
							inner join sis.t_uni_curricular as uni
								on uni.codigo = cur.cod_uni_curricular
							where  curest.cod_estado in ('A','N','R')";
			$consulta .= " and curest.codigo in (" . implode(",", $curEstudiante) . ")";
		
			$consulta .= 		"group by 	per.codigo,
										per.cedula,
										per.apellido1 || ', ' || per.nombre1
								order by prom desc, materias desc
								limit ?";
			
			$ejecutar = $conexion->prepare($consulta);
			
			$ejecutar->execute(array($cantidad));
			
			if($ejecutar->rowCount()!=0)
				return $ejecutar->fetchAll();
			else 
				return null;
		}
		catch (Exception $e){
			throw $e;
		}
	}
}

?>
