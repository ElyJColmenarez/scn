$(document).ready(function(){construirSelects()});

function construirSelects(){
	if($('#hiddInst').val() != ''){
		construirInstituto();
		montarPensums(null);
		//$('#pensum').attr('disabled',true);
	}
	else{
		construirPensum($('#hiddInst').val());
	}	
	construirEstado();	
}

function construirInstituto(){
	var arr = Array("m_modulo"	,	"instituto",
					"m_accion"	,	"listar");
					
	ajaxMVC(arr,succInst,error);
}

function succInst(data){
	if(data.estatus > 0)
		montarInstitutos(data.institutos);
	else{
		$('#instituto').selectpicker('destroy');
		mostrarMensaje(data.mensaje,4);
	}
}

function montarInstitutos(institutos){
	if(institutos != null){
			
		 cadena = "<div class='input-group'><span class='input-group-addon'>Instituto</span><select class='selectpicker' id='instituto' data-live-search='true' data-width='400px' multiple data-max-options='1' title='Institutos' onchange='construirPensum()'>";
		 
		 for(var i = 0; i < institutos.length; i++){
			 cadena += "<option value='"+institutos[i]['codigo']+"'>"+institutos[i]['nombre']+"</option>";
		 }
		 
		 cadena += "</select>";
		
		$(cadena).appendTo("#inst");
		activarSelect();
	}
	else
		mostrarMensaje("No hay institutos en el sistema",4);
}

/*
 * Función inhabilitada por cambio en la base de datos.
 */
//~ 
//~ function construirDepartamento(){
	//~ $('#departamento').selectpicker('destroy');
	//~ $('#pensum').selectpicker('destroy');
	//~ 
	//~ var arr = Array("m_modulo"	,	"departamento",
					//~ "m_accion"	,	"listarPI",
					//~ "codInstituto"	,	$("#instituto").val()[0]);
	//~ 
	//~ ajaxMVC(arr, succDep, error);
//~ }

//~ function succDep(data){
	//~ if(data.estatus > 0)
		//~ montarDepartamentos(data.departamentos);
	//~ else{
		//~ $('#departamento').selectpicker('destroy');
		//~ mostrarMensaje(data.mensaje,4);
	//~ }
//~ }
//~ 
//~ function montarDepartamentos(departamentos){
	//~ $('#departamento').remove();
	//~ if(departamentos != null){
		//~ cadena = "<select class='selectpicker' id='departamento' data-live-search='true' data-size='auto' multiple data-max-options='1' title='Departamentos' onchange='construirPensum()'>";
		//~ 
		//~ for(var i = 0; i < departamentos.length; i++){
		 //~ cadena += "<option value='"+departamentos[i]['codigo']+"'>"+departamentos[i]['nombre']+"</option>";
		//~ }
		 //~ 
		//~ cadena += "</select>";	 
		//~ $(cadena).appendTo("#dep");
		//~ activarSelect();
	//~ }
	//~ else
		//~ mostrarMensaje("No hay departamentos asociados a este instituto",4);
//~ }

function construirPensum(){
	
	console.log($("#instituto").val()[0]);
	
	if($("#instituto").val()[0] != null){
		$('#pensum').selectpicker('destroy');
		
		var arr = Array("m_modulo"			,	"pensum",
						"m_accion"			,	"listarPorInstituto",
						"codInstituto"		,	$("#instituto").val()[0]);
		ajaxMVC(arr, succPen, error);
	}
	else
		montarPensums(null);
}

function listarPensums(){
	var arr = Array("m_modulo"			,	"pensum",
					"m_accion"			,	"listar");
	
	ajaxMVC(arr, succPen, error);
}

function succPen(data){
	if(data.estatus > 0){
		if(data.pensums != null)
			montarPensums(data.pensums);
		else
			montarPensums(data.pensum);
	}
	else{
		if(confirm("No hay pensums asociados a este instituto, ¿Desea agregar un periodo a este instituto?")){
			dialogoAgregar($("#instituto").val()[0],'',true);
		}
	}
}

function montarPensums(pensums){
	$("#ad").remove();
	if(pensums != null){
		if($(".modal-body").length != 0)
			cadena = "<select class='selectpicker' id='pensuma' data-live-search='true' data-size='auto' multiple data-max-options='1' title='Pensums'>";
		else{
			cadena = "<div class='input-group'><span class='input-group-addon' id='ad'>Carrera</span><select class='selectpicker' id='pensum' data-live-search='true' data-width='400px' multiple data-max-options='1' title='Pensums' onchange='listar()'></div>";
		}
		for(var i = 0; i < pensums.length; i++)
		 cadena += "<option value='"+pensums[i]['codigo']+"'>"+pensums[i]['nombre']+"</option>";
		 
		cadena += "</select>";	 
		
		if($(".modal-body").length != 0)
			$(cadena).appendTo(".modal-body #pen");
		else
			$(cadena).appendTo("#pen");
		activarSelect();
	}
	else{
		cadena = "<div class='input-group' id='ad'><span class='input-group-addon' id='ad'>Carrera</span><select class='selectpicker' id='pensum' data-live-search='true' data-width='400px' multiple data-max-options='1' title='Pensums' disabled></div>";
		$(cadena).appendTo("#pen");
	}
}

function construirEstado(){
	var arr = Array("m_modulo"	,	"periodo",
					"m_accion"	,	"obtenerEstado");
	
	ajaxMVC(arr, succEstado, error);
}

function succEstado(data){
	if(data.estatus > 0){
		montarEstado(data.estados);
	}
	else
		mostrarMensaje(data.mensaje,4);
}

function montarEstado(estados){
	if(estados != null){
		if($(".modal-body").length != 0)
			cadena = "<select class='selectpicker' id='estadoa' data-live-search='true' data-size='auto' multiple data-max-options='1' title='Estado del Periodo'>";
		else
			cadena = "<div class='input-group'><span class='input-group-addon'>Estado</span><select class='selectpicker' id='estado' data-live-search='true' multiple data-max-options='1' title='Estado del Periodo'>";
		for(var i = 0; i < estados.length; i++)
		 cadena += "<option value='"+estados[i]['codigo']+"'>"+estados[i]['nombre']+"</option>";
		 
		cadena += "</select>";
		if($(".modal-body").length != 0) 
			$(cadena).appendTo(".modal-body #est");
		else
			$(cadena).appendTo("#est");
		activarSelect();
	}
	else
		mostrarMensaje("No hay estados.",4);
}


function listar(){
	
	var inst = '';
	var est = '';
	var dep = '';
	var pen = '';
	
	if($('#instituto').val() != null)
		inst = $('#instituto').val()[0];
	
	if($('#estado').val() != null)
		est = $('#estado').val()[0];
		
	//~ if($('#departamento').val() != null)
		//~ dep = $('#departamento').val()[0];
		
	if($('#pensum').val() != null)
		pen = $('#pensum').val()[0];
	
	var arr = Array("m_modulo"		,		"periodo",
					"m_accion"		,		"listar",
					"m_vista"		,		"Listar",
					"instituto"		,		inst,
					"estado"		,		est,
					"pensum"		,		pen);

	
	ajaxMVC(arr,succListar,error);
}

function succListar(data){
	if(data.estatus > 0){
		montarListar(data.periodos);
	}
	else{
		$('#tablaPeriodos').remove();
		mostrarMensaje(data.mensaje,4);
	}
}

function montarListar(periodos){
	if(periodos != null){
		$('#tablaPeriodos').remove();
		
		cadena = "<table id='tablaPeriodos' class='table'>";
		
		var inst = '';
		var dep = '';
		var codigoinst;
		var codigodep;
		
		for(var i = 0; i < periodos.length; i++){
			if(inst != periodos[i]['nombreinst']){
				inst = periodos[i]['nombreinst'];
				codigoinst = periodos[i]['codinst'];
				cadena += "<tr class='titulo'>";
				cadena += "<td colspan='6'>"+periodos[i]['nombreinst']+"</td>";
				cadena += "<td > <button class='btn btn-success' style='height:33px' onclick='dialogoAgregar(\""+codigoinst+"\",\""+inst+"\",true)'>Agregar Periodo </button> </td>";
				cadena += "</tr>";
				
			}
			
			cadena += "<tr class='titulo'>";
			//~ cadena += "</tr>";
			//~ 
			//~ cadena += "<tr class='active'>";
			//~ 
			//~ cadena += "<td>Nombre del Periodo</td>";
			//~ 
			//~ cadena += "<td>Fecha de Inicio</td>";
			//~ 
			//~ cadena += "<td>Fecha Final</td>";
			//~ 
			//~ cadena += "<td>Estado</td>";
			//~ 
			//~ cadena += "<td>Observaciones</td>";
			//~ 
			//~ cadena += "<td>Pensum</td>";
			//~ 
			//~ cadena += "<td></td>";
			//~ 
			//~ cadena += "</tr>";
			
			cadena += "<tr>";
			
			cadena += "<td> "+periodos[i]['nombre']+" </td>";
			
			cadena += "<td> "+periodos[i]['fec_inicio']+" </td>";
			
			cadena += "<td> "+periodos[i]['fec_final']+" </td>";
			
			cadena += "<td> "+periodos[i]['nombreestado']+" </td>";
			
			cadena += "<td> "+periodos[i]['observaciones']+" </td>";
			
			cadena += "<td> "+periodos[i]['nombrepensum']+" </td>";
			
			cadena += "<td> <button class='btn btn-primary' title='Modificar Periodo' onclick='obtener(\""+periodos[i]['codigo']+"\")'><i class='icon-pencil'></i></button>";
			
			cadena += " <button class='btn btn-danger' title='Reporte de Periodo' onclick='window.location.assign(\"index.php?m_modulo=periodo&m_accion=obtenerIP&m_formato=pdf&m_vista=reportePeriodo&periodos="+periodos[i]['codigo']+"\")'><i class='icon-book'></i></button> </td>";
			
			cadena += "</tr>";
			
		}
		
		cadena += "</table>";
		
		$(cadena).appendTo("#listaPeriodos");
	}
	else{
		$('#tablaPeriodos').remove();
		if(confirm("No hay pensums asociados a este pensum, ¿Desea agregar un periodo a este pensum?")){
			dialogoAgregar($("#instituto").val()[0],'',true);
		}
	}
}



function dialogoAgregar(codInst, inst, open){	
	if(open)
		crearDialogo("agregarPeriodo","Administrar Periodo",inst,1,"agregarPeriodo()");
		
	cadena = "<div class='row'>";
	
	cadena += "<div class='col-md-12'><div class='input-group'><span class='input-group-addon'>Nombre del Periodo</span><input type='text' class='form-control' onkeyup='validarRangos(\"#nombre\",4,10,true)' id='nombre' placeholder='Nombre del Periodo'></div></div><br>";
	cadena += "<div class='col-md-12'><div class='input-group'><span class='input-group-addon'>Fecha de Inicio</span><input type='text' class='form-control fecha hasDatePicker' onkeyup='validarRangos(\"#fecinicio\",4,10,true)' onfocus='activarFecha(\"#fecinicio\")' id='fecinicio' placeholder='Fecha de Inicio'></div></div><br>";
	cadena += "<div class='col-md-12'><div class='input-group'><span class='input-group-addon'>Fecha de Fin</span><input type='text' class='form-control fecha hasDatePicker' onkeyup='validarFecha(\"#fecfinal\",4,10,true)' onfocus='activarFecha(\"#fecfinal\")' id='fecfinal' placeholder='Fecha de Fin '></div></div><br>";
	cadena += "<div class='col-md-12'><div class='input-group'><span class='input-group-addon'>Observaciones</span><input type='text' class='form-control' onkeyup='validarRangos(\"#observaciones\",4,30,false)' id='observaciones' placeholder='Observaciones'></div></div><br>";
	cadena += "<div class='col-md-6'><div id='est'></div></div>";
	cadena += "<div class='col-md-6'><div id='pen'></div></div>";
	cadena += "<input type='hidden' id='codInst' value='"+codInst+"'>";
	cadena += "</div>";
	
	$(".modal-body").append(cadena);
	
	construirEstado();
	
	listarPensums();
	
	activarSelect();
	
	if(open)
		$("#agregarPeriodo").modal("show");
}

function agregarPeriodo(){
	var arr = Array("m_modulo"		,	"periodo",
					"m_accion"		,	"agregar",
					"codPensum"		,	$("#pensuma").val()[0],
					"nombre"		,	$("#nombre").val(),
					"fecinicio"		,	$("#fecinicio").val(),
					"fecfinal"		,	$("#fecfinal").val(),
					"observaciones"	,	$("#observaciones").val(),
					"codEstado"		,	$("#estadoa").val()[0],
					"codInstituto"	,	$("#codInst").val());
					
	console.log(arr);
	
	ajaxMVC(arr, succAgregar, error);
}

function succAgregar(data){
	if(data.estatus > 0){
		mostrarMensaje("Periodo: "+data.nombre+" agregado con éxito",1);
		$('#agregarPeriodo').modal('hide');
		$('.modal-body').remove();
		listar();
	}
	else{
		mostrarMensaje(data.mensaje,4);
	}
}

function obtener(codigo){
	var arr = Array("m_modulo"	,	"periodo",
					"m_accion"	,	"listar",
					"codigo"	,	codigo);
					
	ajaxMVC(arr, succObtener, error);
}

function succObtener(data){
	if(data.estatus > 0){
		montarInfo(data.periodos);
	}
	else{
		mostrarMensaje(data.menasje,4);
	}
}

function montarInfo(periodos){
	if(periodos != null){
		crearDialogo("agregarPeriodo","Administrar Periodo",periodos[0]['nombreinst'],1,"modificarPeriodo()");
		
		dialogoAgregar("","","","",false);
		
		console.log(periodos[0]['cod_instituto']);
		
		$("<input type='hidden' id='codigohidd' value='"+periodos[0]['codigo']+"' >").appendTo(".modal-body");
		$("<input type='hidden' id='instihidd' value='"+periodos[0]['cod_instituto']+"' >").appendTo(".modal-body");
		
		$("#nombre").val(periodos[0]['nombre']);
		$("#fecinicio").val(periodos[0]['fec_inicio']);
		$("#fecfinal").val(periodos[0]['fec_final']);
		$("#observaciones").val(periodos[0]['observaciones']);
		$("#nombre").val(periodos[0]['nombre']);
		
		$("#agregarPeriodo").modal("show");
		
		alert();
		
		$("#pensuma").selectpicker('val',periodos[0]['cod_pensum']);
		$("#estadoa").selectpicker('val',periodos[0]['cod_estado']);
		
	}
}

function modificarPeriodo(){
	var arr = Array("m_modulo"		,	"periodo",
					"m_accion"		,	"modificar",
					"codigo"		,	$('#codigohidd').val(),
					"nombre"		,	$('#nombre').val(),
					"fecinicio"		,	$('#fecinicio').val(),
					"fecfinal"		,	$('#fecfinal').val(),
					"observaciones"	,	$('#observaciones').val(),
					"codPensum"		,	$('#pensuma').val()[0],
					"codInstituto"	,	$('#instihidd').val(),
					"codEstado"		,	$('#estadoa').val()[0]);
	
	console.log(arr);
	
	ajaxMVC(arr, succModificar, error);
					
}

function succModificar(data){
	if(data.estatus > 0){
		mostrarMensaje("Periodo: "+data.nombre+" modificado con éxito",1);
		//~ $('#agregarPeriodo').modal('hide');
		//~ $('.modal-body').remove();
		listar();
	}
	else{
		mostrarMensaje(data.mensaje,4);
	}
}

function error(data){
	console.log(data.responseText);
	mostrarMensaje("Error de comunicación con el servidor",2);
}

function reportePDF(){
	$('#reportePDF').remove();
	crearDialogo('reportePDF','Reporte PDF', 'Seleccione un periodo',400,'generarReporte()','Generar Reporte',true);
	montarDialogoPDF();
}

function montarDialogoPDF(){
	cadena = "<select class='selectpicker' id='periodos' data-live-search='true' data-size='auto' multiple data-max-options='1' title='Seleccione Periodos'>";
	$('.modal-body').append(cadena);
	activarSelect();
	$('#reportePDF').modal('show');
}

