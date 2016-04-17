<?php

$estudiante=Vista::obtenerDato('estudiante');
$curso = Vista::obtenerDato("datocurso");
$nombreArchivoDestino = "curso_" . $curso[0]["codigo"] . "_correos.txt";

//Vista::asignarNombreArchivoDestino($nombreArchivoDestino);


if ($estudiante){
//	echo"entro";
	$arc=fopen($nombreArchivoDestino,"w"); //asignado en el controlador: ( listarEstudiantes());
	
	fwrite ($arc,"Docente: " .$estudiante[0]['nom_docente'] . "\r\n");
//aquí se determinó que hay una caimanada, porque en la primera posición
//guarda los datos del docente y del primer estudiante,
//y en las siguientes sólo guarda la información del estudiante:
//Revisado Por Johan Alamo el martes 10 de noviembre de 2015
//  para examinar todos los campos del arreglo $estudiante:
//	foreach($estudiante[0] as $c => $v){
//		fwrite ($arc,"$c: $v" .",\r\n");
//	}
	fwrite ($arc,"Correo del docente: " .$estudiante[0]['cor_docente'] . "\r\n");

	fwrite ($arc,"Unidad Curricular: " .$estudiante[0]['uni_nombre'] . "\r\n");
	fwrite ($arc,"Sección: " .$estudiante[0]['seccion'] . "\r\n");
	fwrite ($arc,"-----------------------------------------------------------\r\n");


	
	foreach ($estudiante as $es ){
		fwrite ($arc,$es['cor_personal'] .",\r\n");
	}
	
	fclose($arc);
}
//	readfile("balsjldfjslf.txt");
	
/*
else 
*/
/*
	echo "no hay estudiantes ";
*/
//$arc=fopen(

//echo"jajaja";
//$arc=fopen('archivo.txt',"w");
//fwrite($arc,"hola");
//fclose($arc);	



?>
