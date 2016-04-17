<?php
	require_once "modulos/consulta/modelo/ConsultaServicio.php";

	class ConsultaControlador{
		public static function manejarRequerimiento(){
			$accion = PostGet::obtenerPostGet("m_accion");
			
			if($accion == NULL)
				$accion = "inicio";
			
			if($accion == "sql")
				self::sql();
			else if($accion == "inicio")
				self::inicio();
			else if($accion == "exportar")
				self::exportar();
		}
		
		public static function sql(){
			try{
				$sql = PostGet::obtenerPostGet("sql");
				
				$r = ConsultaServicio::ejecutarSQL($sql);
				
				Vista::asignarDato("resultado",$r);
				
				Vista::asignarDato("tiempo",ConsultaServicio::$tiempo);
				
				ConsultaServicio::$tiempo = 0;
				
				Vista::mostrar();
			}
			catch (Exception $e){
				throw $e;
			}
		}
		
		public static function exportar(){
			try{
				$sql = PostGet::obtenerPostGet("sql");
				
				$res = PostGet::obtenerPostGet("resultado");
				
				$tipo = PostGet::obtenerPostGet("tipo");

				$ext = ".sql";
				
				if($tipo == 1)
					Vista::asignarDato("sql",$sql);
				else
					Vista::asignarDato("sql",null);
					
				if($res == "true"){
					Vista::asignarDato("resultado",ConsultaServicio::ejecutarSQL($sql));
					$ext = ".cvs";
				}
				else{
					Vista::asignarDato("resultado",null);
				}
				
				if(PostGet::obtenerPostGet("m_formato") == "txt"){
					$time = getDate();
	
					$fecha = $time["mday"]."-".$time["mon"]."-".$time["year"];
					
					$hora = $time["hours"].":".$time["minutes"];
					
					$nbArchivo = $fecha."_".$hora.$ext;
					
					Vista::$nombreArchivoDestino = $nbArchivo;
				}	
				Vista::mostrar();
				
			}
			catch (Exception $e){
				throw $e;
			}
		}
		
		public static function inicio(){
					
			Vista::mostrar();
		}
	}

?>
