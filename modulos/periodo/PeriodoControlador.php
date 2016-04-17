<?php
require_once "modelo/PeriodoServicio.php";

require_once "modulos/curso/modelo/CursoServicio.php";
require_once "modulos/docente/modelo/serviciodocente.php";


require_once "negocio/Periodo.php";

class  PeriodoControlador{
	public static function manejarRequerimiento(){
		try {

			//permite obtener la acción a realizar en este módulo
			$accion = PostGet::obtenerPostGet('m_accion');

		
			//Acciones de curso
		
			if ($accion == 'listarTrayectos') 	self::listarTrayectos();
			else if ($accion == 'listar')		self::listar();
			else if ($accion == 'listarPD')		self::listarPorDepartamento();
			else if ($accion == 'obtenerEstado')self::obtenerEstado();
			else if ($accion == 'agregar')		self::agregar();
			else if ($accion == 'modificar')	self::modificar();
			else if ($accion == 'listarPIP')	self::listarPorInstitutoPensum();
			else if ($accion == 'obtenerIP')	self::obtenerInformacionPorPeriodo();
			
			else
			throw new Exception ("acción inválida en el controlador del Periodo: ".$accion);
		}catch (Exception $e){
			throw $e;
		}
	}
	
	public static function listar(){
		try{
			$inst = PostGet::obtenerPostGet('instituto');
			$estado = PostGet::obtenerPostGet('estado');
			//$departamento = PostGet::obtenerPostGet('departamento');
			$pensum = PostGet::obtenerPostGet('pensum');
			$codigo = PostGet::obtenerPostGet('codigo');
			
			$periodos = PeriodoServicio::listar($inst, $estado, $pensum, $codigo);
			
			if($periodos != NULL){
				Vista::asignarDato('periodos',$periodos);
				Vista::asignarDato('estatus', 1);
			}
			else{
				$mensaje = "No hay periodos.";
				Vista::asignarDato('mensaje',$mensaje);
			}
			Vista::mostrar();
		}
		catch(Exception $e){
			throw $e;
		}
	}
	
	public static function listarTrayectos(){
		try{
			$codPeriodo=PostGet::obtenerPostGet('codPeriodo');
			$trayectos=PeriodoServicio::cargarTrayectosPorPeriodo($codPeriodo);

			if ($trayectos!= null){
				Vista::asignarDato('trayectos',$trayectos);
				Vista::asignarDato('estatus',1);
			}else {
				$mensaje="no hay trayectos en este periodo";
				Vista::asignarDato('mensaje',$mensaje);
			}
			
			Vista::mostrar();
		}catch(Exception $e){
			throw $e;
		}
	}
	
	/* Función inhabilitada por cambio en la base de datos */
	
/*
	public static function listarPorDepartamento(){
		try{
			$codDepartamento=PostGet::obtenerPostGet('codDepartamento');
			$periodos=PeriodoServicio::listarPorDepartamento($codDepartamento);

			if ($periodos!= null){
				Vista::asignarDato('periodos',$periodos);
				Vista::asignarDato('estatus',1);
			}else {
				$mensaje="no hay periodos en este departamento";
				Vista::asignarDato('mensaje',$mensaje);
			}
			Vista::mostrar();
		}catch(Exception $e){
			throw $e;
		}
	}
*/
	
	public static function obtenerEstado(){
		try{
			$estados = PeriodoServicio::obtenerEstado();
			
			if($estados != NULL){
				Vista::asignarDato('estados',$estados);
				Vista::asignarDato('estatus',1);
			}
			else{
				Vista::asignarDato('mensaje',"No hay estados");
			}
			Vista::mostrar();
		}
		catch(Exception $e){
			throw $e;
		}
	}
	
	public static function agregar(){
		try{
			$per = new Periodo();
			
			$per->asignarNombre(PostGet::obtenerPostGet('nombre'));
			$per->asignarFecInicio(PostGet::obtenerPostGet('fecinicio'));
			$per->asignarFecFinal(PostGet::obtenerPostGet('fecfinal'));
			$per->asignarObservaciones(PostGet::obtenerPostGet('observaciones'));
			$per->asignarCodEstado(PostGet::obtenerPostGet('codEstado'));
			$per->asignarCodPensum(PostGet::obtenerPostGet('codPensum'));
			$per->asignarCodInstituto(PostGet::obtenerPostGet('codInstituto'));
			//$per->asignarCodDepartamento(PostGet::obtenerPostGet('codDepartamento'));
			
			$r = PeriodoServicio::agregarPeriodo($per);
			
			Vista::asignarDato('estatus',1);
			Vista::asignarDato('nombre',$per->obtenerNombre());
			Vista::mostrar();		
		}
		catch(Exception $e){
			throw $e;
		}
	}
	
	public static function modificar(){
		try{
			$per = new Periodo();
			
			$per->asignarCodigo(PostGet::obtenerPostGet('codigo'));
			$per->asignarNombre(PostGet::obtenerPostGet('nombre'));
			$per->asignarFecInicio(PostGet::obtenerPostGet('fecinicio'));
			$per->asignarFecFinal(PostGet::obtenerPostGet('fecfinal'));
			$per->asignarObservaciones(PostGet::obtenerPostGet('observaciones'));
			$per->asignarCodEstado(PostGet::obtenerPostGet('codEstado'));
			$per->asignarCodPensum(PostGet::obtenerPostGet('codPensum'));
			$per->asignarCodInstituto(PostGet::obtenerPostGet('codInstituto'));
			//$per->asignarCodDepartamento(PostGet::obtenerPostGet('codDepartamento'));
			
			$r = PeriodoServicio::modificarPeriodo($per);
			
			Vista::asignarDato('estatus',1);
			Vista::asignarDato('nombre',$per->obtenerNombre());
			Vista::mostrar();		
		}
		catch(Exception $e){
			throw $e;
		}
	}
	
	static function listarPorInstitutoPensum(){
			try{
				$codInstituto=PostGet::obtenerPostGet('codInstituto');
				$codPensum=PostGet::obtenerPostGet('codPensum');
				$periodos=PeriodoServicio::listarPorInstitutoPensum($codPensum,$codInstituto);

				if ($periodos!= null){
					Vista::asignarDato('periodos',$periodos);
					Vista::asignarDato('estatus',1);
				}else {
					$mensaje="no hay periodos";
					Vista::asignarDato('mensaje',$mensaje);
				}
				Vista::mostrar();
			}catch(Exception $e){
				throw $e;
			}
		}
	
	public static function obtenerInformacionPorPeriodo(){
		try{
			
			$periodos = PostGet::obtenerPostGet('periodos');
			
			$periodos = array($periodos);
			
/*
			$periodos = explode(",",$periodos);
			
*/
			//obtener informacion del periodo
			$infPeriodos = PeriodoServicio::obtenerInformacionPeriodo($periodos);
			
			//var_dump($infPeriodos);
			
			//información por unidad curicular por docente
			$infUniPeriodos = CursoServicio::obtenerInformacionUnidadCurricularPorPeriodo(CursoServicio::obtenerCursosPorPeriodo($periodos));
			
			//información por docente
			$infDocentes = CursoServicio::agruparPor($infUniPeriodos,'cod_docente');

			//información por unidad curricular
			$infUnidades = CursoServicio::agruparPor($infUniPeriodos,'cod_uni_curricular');


			

			//estudiantes inscritos por materias
			$estPorMaterias = CursoServicio::obtenerEstudiantesPorMaterias($periodos);

			//mejores promedios del periodo
			$infPromedios = PeriodoServicio::obtenerMejoresPromedios(CursoServicio::obtenerCurEstudiantePorPeriodo($periodos), 10);

			
			//reprobados en todas las materias que inscribieron
			$infReprobados = PeriodoServicio::obtenerInformacionAlumnosReprobadosEnTodasUni($periodos);
			
						
			Vista::asignarDato('periodos',$periodos);
			
			Vista::asignarDato('infPeriodos',$infPeriodos);
			
			Vista::asignarDato('infUniPeriodos',$infUniPeriodos);
			
			Vista::asignarDato('estPorMaterias',$estPorMaterias);
			
			Vista::asignarDato('infReprobados',$infReprobados);
			
			Vista::asignarDato('infPromedios',$infPromedios);
			
			Vista::asignarDato('infDocentes',$infDocentes);
			
			Vista::asignarDato('infUnidades',$infUnidades);
			
			Vista::mostrar();
			
		}
		catch (Exception $e){
			throw $e;
		}
	}
}

		
?>
