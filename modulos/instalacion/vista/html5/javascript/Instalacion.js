
	
	


$(document).ready(function() {
	conDiaComponentes();
});


function conDiaComponentes(){
	titulo="<center>Componentes necesarios para la instalación de MVCRivero</center>";
	pie="<h5>NOTA: de faltar algún componente marcado con * no se procederá con la instalación del software</h5>";
	crearDialogo("componentes",titulo,'',1,"","",true);
	$(pie).appendTo("#componentes .modal-footer");
	$("#componentes .close").remove();
 	$("#componentes .btn-danger").remove();
 	$("#componentes").modal({backdrop:"static"});
	$("#componentes").modal("show");
	contDiaComponentes();
}

function contDiaComponentes(){
	ok = "<i class='icon-ok' style='color:#53FF00;'></i>";
	no = "<i class='icon-remove' style='color:red'></i>";
	ast= "<i style='color:red;font-weight:bold'>*</i>";
	cadena="<div class= 'container'> ";
	cadena+=" <div class='row'>";
	cadena+="<div class='col-md-6'>"+ok+" Postgresql"+ast+" </div>";
	cadena+="<div class='col-md-6'> IMG </div>";
	cadena+="</div> ";
	cadena+="<div class='row'>";
	cadena+="<div class='col-md-6'>"+no+" PDO"+ast+" </div>";
	cadena+="<div class='col-md-6'> IMG </div>";
	cadena+="</div> ";
	cadena+="<div class='row'>";
	cadena+="<div class='col-md-6'>"+ok+" Conector a Postgresql"+ast+" </div>";
	cadena+="<div class='col-md-6'> IMG </div>";
	cadena+="</div> ";
	cadena+="<div class='row'>";
	cadena+="<div class='col-md-6'>"+no+" Display_errors </div>";
	cadena+="<div class='col-md-6'> IMG </div>";
	cadena+="</div> ";
	cadena+="<div class='row'>";
	cadena+="<div class='col-md-6'>"+ok+" Version de PHP </div>";
	cadena+="<div class='col-md-6'> IMG </div>";
	cadena+="</div> ";
	cadena+="<div class='row'>";
	cadena+="<div class='col-md-6'>"+no+" Version de postgresql </div>";
	cadena+="<div class='col-md-6'> IMG </div>";
	cadena+="</div> ";

	$(cadena).appendTo("#componentes .modal-body");
}