<?php
	$sql = Vista::obtenerDato("sql");
	$resultado = Vista::obtenerDato("resultado");
	
	$arch = fopen("temp/".Vista::$nombreArchivoDestino,"w");
	
	if($sql == NULL){
		fwrite($arch, "Resultado:\n");
		
		for($i = 0; $i < count($resultado); $i++){
				for($j = 0; $j < count($resultado[$i])/2; $j++)
					fwrite($arch, $resultado[$i][$j].";");
				fwrite($arch,"\n");
			}
	}
	else{
		if($resultado == NULL){
			fwrite($arch,"Consulta:\n");
			
			fwrite($arch,$sql);
		}
		else{
			fwrite($arch, "Consulta:\n");
			fwrite($arch, $sql);			
			fwrite($arch, "\n\n");		
			fwrite($arch, "Resultado:\n");
			
			for($i = 0; $i < count($resultado); $i++){
				for($j = 0; $j < count($resultado[$i])/2; $j++)
					fwrite($arch, $resultado[$i][$j].";");
				fwrite($arch,"\n");
			}
		}
	}
	
	fclose($arch);
	
?>
