<?php
class InstalacionControlador{
	
	
	
	public static function manejarRequerimiento(){
			try {
				$accion = PostGet::obtenerPostGet('m_accion');
				if (!$accion) 
					$accion = 'instalar';
				if ($accion == 'instalar') 			self::instalar();
				else
					throw new Exception ("acción inválida en el controlador del curso: ".$accion);
			}catch (Exception $e){
					throw $e;
			}
	}
	public static function instalar(){
		Vista::mostrar();
		
	}	
}

?>
