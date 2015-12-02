<?php

if($modulo == 'consulta'){
	require_once 'modulos/consulta/ConsultaControlador.php';
	ConsultaControlador::manejarRequerimiento();
}
else if($modulo == 'curso'){
	require_once 'modulos/curso/CursoControlador.php';
	CursoControlador::manejarRequerimiento();
}
else if($modulo == 'departamento'){
	require_once 'modulos/departamento/DepartamentoControlador.php';
	DepartamentoControlador::manejarRequerimiento();
}
else if($modulo == 'docente'){
	require_once 'modulos/docente/DocenteControlador.php';
	DocenteControlador::manejarRequerimiento();
}
else if($modulo == 'error'){
	require_once 'modulos/error/ErrorControlador.php';
	ErrorControlador::manejarRequerimiento();
}
else if($modulo == 'estudiante'){
	require_once 'modulos/estudiante/EstudianteControlador.php';
	EstudianteControlador::manejarRequerimiento();
}
else if($modulo == 'fotografia'){
	require_once 'modulos/fotografia/FotografiaControlador.php';
	FotografiaControlador::manejarRequerimiento();
}
else if($modulo == 'instalacion'){
	require_once 'modulos/instalacion/InstalacionControlador.php';
	InstalacionControlador::manejarRequerimiento();
}
else if($modulo == 'instituto'){
	require_once 'modulos/instituto/InstitutoControlador.php';
	InstitutoControlador::manejarRequerimiento();
}
else if($modulo == 'login'){
	require_once 'modulos/login/LoginControlador.php';
	LoginControlador::manejarRequerimiento();
}
else if($modulo == 'pensum'){
	require_once 'modulos/pensum/PensumControlador.php';
	PensumControlador::manejarRequerimiento();
}
else if($modulo == 'periodo'){
	require_once 'modulos/periodo/PeriodoControlador.php';
	PeriodoControlador::manejarRequerimiento();
}
else if($modulo == 'persona'){
	require_once 'modulos/persona/PersonaControlador.php';
	PersonaControlador::manejarRequerimiento();
}
else if($modulo == 'principal'){
	if(PostGet::obtenerPostGet("m_accion") == "error"){
		throw new Exception("404");
	}
	else
		self::inicio();
}
else if($modulo == 'trayecto'){
	require_once 'modulos/trayecto/TrayectoControlador.php';
	TrayectoControlador::manejarRequerimiento();
}
else if($modulo == 'unidad'){
	require_once 'modulos/unidad/UnidadControlador.php';
	UnidadControlador::manejarRequerimiento();
}
else if($modulo == 'usuario_NO_FUNCIONAL_AUN_JOHAN_ALAMO'){
	require_once 'modulos/usuario_NO_FUNCIONAL_AUN_JOHAN_ALAMO/Usuario_NO_FUNCIONAL_AUN_JOHAN_ALAMOControlador.php';
	Usuario_NO_FUNCIONAL_AUN_JOHAN_ALAMOControlador::manejarRequerimiento();
}
else if($modulo == 'errorP')
	self::error();
else 
	throw new Exception ('(PrincipalControlador) Módulo inválido:'.$modulo);
?>
