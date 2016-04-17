
function validarSoloTexto(id, min, max, req = false, pos = "top"){
	$(".popover").hide();
	var cad = $(id).val();
	var val=/^[A-Za-z ÁÉÍÓÚáéíóúñÑ]{0,5000}$/;
	if(req){
		if(cad.length == 0){
			detonarAdvertencia(id,"Este campo es requerido.",pos);
			return false;
		}
		else{
			if(!(validarMatch(cad,val))){				
				detonarAdvertencia(id, "El campo no es correcto. Sólo letras.",pos);
				return false;
			}
			if(validarRango(cad,min,max)){
				detonarAdvertencia(id,"El campo debe tener entre "+min+"-"+max+" caracteres.1");
				return false;
			}
		}
	}
	else{
		if(cad.length > 0){
			if(!(validarMatch(cad,val))){
				detonarAdvertencia(id, "El campo no es correcto. Sólo letras.",pos);
				return false;
			}
			if(validarRango(cad,min,max)){
				detonarAdvertencia(id,"El campo debe tener entre "+min+"-"+max+" caracteres.",pos);
				return false;
			}
		}
	}
	return true;
}


function validarSoloTextoYCaracteres(id, min, max, req = false, pos = "top"){
	$(".popover").hide();
	var cad = $(id).val();
	var val=/^[A-Za-z ÁÉÍÓÚáéí".óúñÑ]{0,500}$/;
	if(req){
		if(cad.length == 0){
			detonarAdvertencia(id,"Este campo es requerido.",pos);
			return false;
		}
		else{
			if(!(validarMatch(cad,val))){
				alert("entro");
				detonarAdvertencia(id, "El campo no es correcto. Sólo letras.",pos);
				return false;
			}
			if(validarRango(cad,min,max)){
				detonarAdvertencia(id,"El campo debe tener entre "+min+"-"+max+" caracteres.",pos);
				return false;
			}
		}
	}
	else{
		if(cad.length > 0){
			if(!(validarMatch(cad,val))){
				detonarAdvertencia(id, "El campo no es correcto. Sólo letras.",pos);
				return false;
			}
			if(validarRango(cad,min,max)){
				detonarAdvertencia(id,"El campo debe tener entre "+min+"-"+max+" caracteres.",pos);
				return false;
			}
		}
	}
	return true;
}


function validarSoloNumeros(id,min,max,req, pos = "top"){
	$(".popover").hide();
	var cad = $(id).val();
	var val = /^([0-9])*$/;

	if(req){
		if(cad.length == 0){
			detonarAdvertencia(id,"Este campo es requerido.",pos);
			return false;
		}
		else{
			if(!(validarMatch(cad,val))){
				detonarAdvertencia(id, "El campo no es correcto. Sólo caracteres numéricos.",pos);
				return false;
			}
			if(validarRango(cad,min,max)){
				detonarAdvertencia(id,"El campo debe tener entre "+min+"-"+max+" caracteres.",pos);
				return false;
			}
		}
	}
	else{
		if(cad.length > 0){
			if(!(validarMatch(cad,val))){
				detonarAdvertencia(id, "El campo no es correcto. Sólo caracteres numéricos.",pos);
				return false;
			}
			if(validarRango(cad,min,max)){
				detonarAdvertencia(id,"El campo debe tener entre "+min+"-"+max+" caracteres.",pos);
				return false;
			}
		}
	}
	return true;
}

function validarFecha(id,req,pos = "top"){
	$(".popover").hide();
	var cad = $(id).val();
	
	console.log("12/04/2015" == $(id).val());
	
	
	var val = /^\d{1,2}\/\d{1,2}\/\d{4}$/;
	
	console.log(cad.match(val));
	
	if(req){
		if(cad.length == 0){
			detonarAdvertencia(id,"Este campo es requerido.",pos);
			return false;	
		}
		else{
			if(!(validarMatch(cad,val))){
				detonarAdvertencia(id, "El campo no es correcto. Introduzca una fecha válida (XX/XX/XXXX).",pos);
				return false;
			}
		}
	}
	else{
		if(cad.length > 0){
			if(!(validarMatch(cad,val))){
				detonarAdvertencia(id, "El campo no es correcto. Introduzca una fecha válida (XX/XX/XXXX).",pos);
				return false;
			}
		}
	}
	$(id).popover();
	return true;
}

function validarEmail(id,min = 5 ,max = 30, req = false, pos = "top"){
	$(".popover").hide();
	var cad = $(id).val();
	var val = /[\w-\.]{3,}@([\w-]{2,}\.)*([\w-]{2,}\.)[\w-]{2,4}/;

	if(req){
		if(cad.length == 0){
			detonarAdvertencia(id,"Este campo es requerido.",pos);
			return false;
		}
		else{
			if(!(validarMatch(cad,val))){
				detonarAdvertencia(id, "El campo no es correcto. Introduzca un correo válido (ejemplo@ejemplo.ej).",pos);
				return false;
			}
			if(validarRango(cad,min,max)){
				detonarAdvertencia(id,"El campo debe tener entre "+min+"-"+max+" caracteres.",pos);
				return false;
			}
		}
	}
	else{
		if(cad.length > 0){
			if(!(validarMatch(cad,val))){
				detonarAdvertencia(id, "El campo no es correcto. Introduzca un correo válido (ejemplo@ejemplo.ej)",pos);
				return false;
			}
			if(validarRango(cad,min,max)){
				detonarAdvertencia(id,"El campo debe tener entre "+min+"-"+max+" caracteres.",pos);
				return false;
			}
		}
	}
	return true;
}

function validarTelefono(id, min, max, req, pos = "top"){
	$(".popover").hide();
	var cad = $(id).val();
	var val =  	/^[0-9]{3,4}-? ?[0-9]{7}$/;

	if(req){
		if(cad.length == 0){
			detonarAdvertencia(id,"Este campo es requerido.", pos);
			return false;
		}
		else{
			if(!(validarMatch(cad,val))){
				detonarAdvertencia(id, "El campo no es correcto. Introduzca un teléfono válido (XXXX-XXXXXXX)).", pos);
				return false;
			}
			if(validarRango(cad,min,max)){
				detonarAdvertencia(id,"El campo debe tener entre "+min+"-"+max+" caracteres.", pos);
				return false;
			}
		}
	}
	else{
		if(cad.length > 0){
			if(!(validarMatch(cad,val))){
				detonarAdvertencia(id, "El campo no es correcto. Introduzca un teléfono válido (XXXX-XXXXXXX)).", pos);
				return false;
			}
			if(validarRango(cad,min,max)){
				detonarAdvertencia(id,"El campo debe tener entre "+min+"-"+max+" caracteres.", pos);
				return false;
			}
		}
	}
	return true;
}

function validarRangos(id, min, max, req, pos = "top"){
	$(".popover").hide();
	var cad = $(id).val();
	if(req){
		if(cad.length == 0){
			detonarAdvertencia(id,"Este campo es requerido.", pos);
			return false;
		}
		else{
			if(validarRango(cad,min,max)){
				detonarAdvertencia(id,"El campo debe tener entre "+min+"-"+max+" caracteres.", pos);
				return false;
			}
		}
	}
	else{
		if(cad.length > 0){
			if(validarRango(cad,min,max)){
				detonarAdvertencia(id,"El campo debe tener entre "+min+"-"+max+" caracteres.", pos);
				return false;
			}
		}
	}
	return true;
}

function validarRango(cad, min, max){
	return ((cad.length > max)||(cad.length < min));
}

function validarMatch(cad, patron){
	var p = patron;
	return (cad.match(p));
}

function detonarAdvertencia(id,mensaje, pos){
	$(id).popover('destroy');
	$(id).popover({title: 'Validación:', content: mensaje , placement : pos, template : '<div id="pop'+id+'" class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>'});
	$(id).trigger("click");
}
