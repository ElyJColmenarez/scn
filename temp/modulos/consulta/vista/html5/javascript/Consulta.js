
function ejecutar(){
	
	var sql = obtenerSeleccion();
	
	if(sql == "")
		sql = $("#sql").val();
	
	var arr = Array("m_modulo"	,	"consulta",
					"m_accion"	,	"sql",
					"sql"		,	sql);
	
	ajaxMVC(arr, montarResultados, errorT);
}

function errorT(data){
	
	var error = data.responseText;
	
	error = error.split('mensaje":');
	
	mostrarMensaje(error[1],2);
}

function montarResultados(data){
	console.log(data);

	var resultado = data.resultado;
	
	$("#tiempoR").html(data.tiempo);
	
	cadena = "<table id='resultadoT' class='table table-striped table-bordered'>";
	
	console.log(resultado);
	
	var indices = Object.keys(resultado[0]);
	
	var top = indices.length/2;
	
	cadena += "<thead>";
	
	cadena += "<td>#</td>";
	
	for(var k = 0; k < top; k++){
		cadena += "<th>"+indices[top + k]+"</th>";
	}
	
	cadena += "</thead>";
	
	for(var i = 0; i < resultado.length; i++){
		cadena += "<tr>";
		
		cadena += "<td>"+(i+1)+"</td>";
		
		bool = true;
		for(var j = 0; bool; j++){
			if(resultado[i][j] === undefined)
				bool = false;
			else
				cadena += "<td>"+resultado[i][j]+"</td>";
		}
		cadena += "</tr>";
	}
	
	cadena += "</table>";
	
	$("#resultadoT").remove();
	
	$("#res").append(cadena);
}

function exportar(tipo){
		var sql = obtenerSeleccion();
		
		var resultado = "false";
		
		if(sql == "")
			sql = $("#sql").val();
		
		if(tipo == 1)
			if($('#checkConsulta').prop("checked"))
				resultado = "true";
		
		sql = escape(sql);
		
		if(tipo == 1){
			window.location.assign("index.php?m_modulo=consulta&m_accion=exportar&m_vista=exportar&m_formato=txt&sql="+sql+"&resultado="+resultado+"&tipo=1");
		}
		else{
			resultado = "true";
			window.location.assign("index.php?m_modulo=consulta&m_accion=exportar&m_vista=exportar&m_formato=txt&sql="+sql+"&resultado="+resultado+"&tipo=2");
		}

}

function funcSucc(data){
	console.log(data);
}

document.onkeydown = function(e){
						if((e.keyCode == 116)){
							ejecutar();
							return false;
						}	
					}


function obtenerSeleccion(){
	campo = document.getElementById("sql");
	
	if(document.selection){
		campo.focus();
		var sel = document.selection.createRange();
		return sel.text;
	}
	else if(campo.selectionStart || campo.selectionStart == "0"){
		var startPos = campo.selectionStart;
		var endPos = campo.selectionEnd;
		
		return campo.value.substr(startPos,endPos - startPos);
	}
	else
		return "";
}				
					
$(document).delegate('#sql', 'keydown', function(e) {
	var keyCode = e.keyCode || e.which;

	if (keyCode == 9) {
		e.preventDefault();
		var start = $(this).get(0).selectionStart;
		var end = $(this).get(0).selectionEnd;
		
		$(this).val($(this).val().substring(0, start)
					+ "\t"
					+ $(this).val().substring(end));

		$(this).get(0).selectionStart = $(this).get(0).selectionEnd = start + 1;
  }
});

