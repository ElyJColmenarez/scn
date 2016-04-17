<?php
	class ConsultaServicio{
		static $inicio = 0;
		static $tiempo;
		
		public static function ejecutarSQL($sql){
			try{
				$conexion = Conexion::conectar();
				
				$sql = explode(";",$sql);
				
				self::tiempoQuery();
				
				for($i = 0; $i < count($sql); $i++){
					
					
					//$ejecutar = $conexion->prepare($sql[$i]);
					
					if($sql[$i] == "")
						break;
					else
						$ejecutar[$i] = $conexion->query($sql[$i]);
					//$ejecutar->execute(array());
					
					
				}
				
				self::tiempoQuery();
				
				return $ejecutar[$i-1]->fetchAll();
			}
			catch (Exception $e){
				throw $e;
			}
		}
		
		public static function tiempoQuery(){
			try{				
				static $inicio;
			   
				list($usec, $sec) = explode(' ',microtime());
				
				if(self::$inicio == 0){   
					 self::$inicio = ((float)$usec + (float)$sec);
				}
				else{
					self::$tiempo = (((float)$usec + (float)$sec)) - self::$inicio; 
					self::$inicio = 0;
				}
			}
			catch(Exception $e){
				throw $e;
			}
		}
	}
?>
