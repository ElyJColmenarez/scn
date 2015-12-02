<?php

	//echo "<pre>";
	//var_dump(Vista::obtenerDatos());
	
	$periodos = Vista::obtenerDato('periodos');

	$infPeriodos = Vista::obtenerDato('infPeriodos');
			
	$infUniPeriodos = Vista::obtenerDato('infUniPeriodos');
	
	$estPorMaterias = Vista::obtenerDato('estPorMaterias');
	
	$infReprobados = Vista::obtenerDato('infReprobados');
	
	$infPromedios = Vista::obtenerDato('infPromedios');
	
	$infDocentes = Vista::obtenerDato('infDocentes');
	
	$infUnidades = Vista::obtenerDato('infUnidades');
	
	$pdf = new FPDF('p','mm','A4');

	$pdf->AddPage();
	$pdf->SetFont('Arial','B',11);
	$pdf->SetTextColor(0);
	$pdf->SetFillColor(255,255,255);
	$pdf->SetLeftMargin(10);
	$pdf->SetTopMargin(10);
	
	$pdf->Image('recursos/imgPropias/fotos/iut.png');
	//$pdf->Image('recursos/imgPropias/fotos/head.png',70,10,200);
	
	$pdf->SetFont('Arial','B',14);
	$pdf->Cell(0,10,"REPORTE ACADÉMICO",0,0,'C',true);
	$pdf->Ln();
	
	/*
	 * 
	 * INFORMACIÓN DE PERIODO
	 * 
	 */
	 
	if($infPeriodos != NULL){
		$pdf->SetFont('Arial','B',12);
		$pdf->Cell(0,10,"INFORMACIÓN DE PERÍODO",0,0,'C',true);
		$pdf->Ln();
		
		$pdf->SetFont('Arial','B',10);
		
		$celda = 0;
		$altura = 7;

		for($i = 0; $i < count($infPeriodos); $i++){
			$pdf->Cell(45,$altura,"PER/INST/CARR",$celda,0,'C',true);
			$pdf->Cell(25,$altura,"Período",$celda,0,'C',true);
			$pdf->Cell(35,$altura,"Fecha de Inicio",$celda,0,'C',true);
			$pdf->Cell(35,$altura,"Fecha de Fin",$celda,0,'C',true);
			$pdf->Cell(45,$altura,"Estado del Período",$celda,0,'C',true);
			$pdf->Ln();
			$pdf->SetFont('Arial','',10);
			$pdf->Cell(45,$altura,$infPeriodos[$i]['cod_periodo']." / ".$infPeriodos[$i]['nom_corto']." / ".$infPeriodos[$i]['nom_cor_pensum'],$celda,0,'C',true);
			$pdf->Cell(25,$altura,$infPeriodos[$i]['nom_periodo'],$celda,0,'C',true);
			$pdf->Cell(35,$altura,$infPeriodos[$i]['fec_inicio'],$celda,0,'C',true);
			$pdf->Cell(35,$altura,$infPeriodos[$i]['fec_final'],$celda,0,'C',true);
			$pdf->Cell(45,$altura,$infPeriodos[$i]['est_periodo'],$celda,0,'C',true);
			
			$pdf->Ln();
/*
			$pdf->SetFont('Arial','B',10);
			$pdf->Cell(45,7,"Observaciones",1,0,'C',true);
			$pdf->SetFont('Arial','',10);
			$pdf->Cell(0,7,$infPeriodos[$i]['observaciones'],1,0,'C',true);
			
			$pdf->Ln();
			$pdf->SetFont('Arial','B',10);
			$pdf->Cell(45,7,"Instituto",1,0,'C',true);
			$pdf->SetFont('Arial','',10);

			
			$pdf->Cell(0,7,$infPeriodos[$i]['nombre'],1,0,'C',true);
			
			$pdf->Ln();
			$pdf->SetFont('Arial','B',10);
			$pdf->Cell(45,7,"Carrera",1,0,'C',true);
			$pdf->SetFont('Arial','',10);
			$pdf->Cell(0,7,$infPeriodos[$i]['nom_pensum'],1,0,'C',true);
			
			$pdf->Ln();
*/
		}
	}
	
	$pdf->Ln();
	/*
	 * 
	 * INFORMACION DE UNI CURRICULAR
	 * 
	 */
	
	if($infUniPeriodos != NULL){
		$pdf->SetFont('Arial','B',12);
		$pdf->Cell(0,10,"REPORTE POR CURSOS",0,0,'C',true);
		$pdf->Ln();
		
		$altura = 6;

		$pdf->SetFont('Arial','B',8);
		$celda = 0;
		$pdf->Cell(5,7,"#",$celda,0,'C',true);
		$pdf->Cell(10,$altura,"Per.",$celda,0,'C',true);
		$pdf->Cell(7,$altura,"Tray.",$celda,0,'C',true);
		$pdf->Cell(75,$altura,"Unidad Curricular(Cod.Curso)",$celda,0,'',true);
		$pdf->Cell(45,$altura,"Docente",$celda,0,'',true);
		$pdf->Cell(10,$altura,"Sem.",$celda,0,'C',true);
		$pdf->Cell(8,$altura,"HTA",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"I",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"C",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"A",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"R",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"N",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"E",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"T",$celda,0,'C',true);
		$pdf->Ln();
		
		$pdf->SetFont('Arial','',7);

		$conta = $contrep = $contins = $contcur = $contret = $contprei = $contrepi = $conttotal = 0;
		
		for($i = 0; $i < count($infUniPeriodos); $i++){
			$pdf->Cell(5,7,$i+1,$celda,0,'C',true);
			$pdf->Cell(10,$altura,$infUniPeriodos[$i]['cod_periodo'],$celda,0,'C',true);
			$pdf->Cell(7,$altura,$infUniPeriodos[$i]['num_trayecto'],$celda,0,'C',true);
			$pdf->Cell(75,$altura,$infUniPeriodos[$i]['nombre']."(".$infUniPeriodos[$i]['codigo'].")",$celda,0,'',true);
			
			($infUniPeriodos[$i]['nombredoc'] != '')?$pdf->Cell(45,$altura,$infUniPeriodos[$i]['nombredoc'],$celda,0,'',true):$pdf->Cell(45,$altura,'SIN ASIGNAR',$celda,0,'',true);
			
			//$pdf->Cell(45,$altura,$infUniPeriodos[$i]['nombredoc'],$celda,0,'',true);
			$pdf->Cell(10,$altura,$infUniPeriodos[$i]['dur_semanas'],$celda,0,'C',true);
			$pdf->Cell(8,$altura,$infUniPeriodos[$i]['hta'],$celda,0,'C',true);
			$pdf->Cell(5,$altura,$infUniPeriodos[$i]['can_inscritos'],$celda,0,'C',true);
			$pdf->Cell(5,$altura,$infUniPeriodos[$i]['can_cursando'],$celda,0,'C',true);
			$pdf->Cell(5,$altura,$infUniPeriodos[$i]['can_aprobados'],$celda,0,'C',true);
			$pdf->Cell(5,$altura,$infUniPeriodos[$i]['can_reprobados'],$celda,0,'C',true);
			$pdf->Cell(5,$altura,$infUniPeriodos[$i]['can_rep_inasistencia'],$celda,0,'C',true);
			$pdf->Cell(5,$altura,$infUniPeriodos[$i]['can_retirados'],$celda,0,'C',true);
			$pdf->Cell(5,$altura,$infUniPeriodos[$i]['can_total'],$celda,0,'C',true);
			
			$contins += $infUniPeriodos[$i]['can_inscritos'];
			$contcur += $infUniPeriodos[$i]['can_cursando'];
			$conta += $infUniPeriodos[$i]['can_aprobados'];
			$contrep += $infUniPeriodos[$i]['can_reprobados'];
			$contrepi += $infUniPeriodos[$i]['can_rep_inasistencia'];
			$contret += $infUniPeriodos[$i]['can_retirados'];
			$conttotal += $infUniPeriodos[$i]['can_total'];

			$pdf->Ln();
		}

		$pdf->SetFont('Arial','B',8);

		$pdf->Cell(155,$altura,'TOTAL',$celda,0,'C',true);
		$pdf->Cell(5,7,"",$celda,0,'C',true);
		$pdf->Cell(5,$altura,$contins,$celda,0,'C',true);
		$pdf->Cell(5,$altura,$contcur,$celda,0,'C',true);
		$pdf->Cell(5,$altura,$conta,$celda,0,'C',true);
		$pdf->Cell(5,$altura,$contrep,$celda,0,'C',true);
		$pdf->Cell(5,$altura,$contrepi,$celda,0,'C',true);
		$pdf->Cell(5,$altura,$contret,$celda,0,'C',true);
		$pdf->Cell(5,$altura,$conttotal,$celda,0,'C',true);
		
	
	}
	$pdf->Ln();
	$pdf->Ln();
	
	
	/*
	 * 
	 * 
	 * 
	 * 
	 */
	 
	 if($infDocentes != NULL){
		 $pdf->SetFont('Arial','B',12);
		 $pdf->Cell(80,10,"REPORTE POR DOCENTE",0,0,'C',true);
		 $pdf->Cell(20,10,"",0,0,'C',true);
		 if($infUnidades != NULL){
			 $pdf->Cell(80,10,"REPORTE POR UNIDAD CURRICULAR",0,0,'C',true);
		 }
		$conta = $contrep = $contins = $contcur = $contret = $contprei = $contrepi = $conttotal = 0;
		$conta2 = $contrep2 = $contins2 = $contcur2 = $contret2 = $contprei2 = $contrepi2 = $conttotal2 = 0;
		
		$bool = true;
		
		$pdf->Ln();
		
		$pdf->SetFont('Arial','B',8);
		
		$pdf->Cell(5,7,"#",$celda,0,'C',true);
		$pdf->Cell(35,$altura,"Docente",$celda,0,'',true);
		$pdf->Cell(7,$altura,"HTA",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"I",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"C",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"A",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"R",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"N",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"E",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"T",$celda,0,'C',true);
		
		$pdf->Cell(5,$altura,"",$celda,0,'C',true);
		
		$pdf->Cell(5,7,"#",$celda,0,'C',true);
		$pdf->Cell(70,$altura,'Unidad Curricular',$celda,0,'',true);
		$pdf->Cell(5,$altura,"I",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"C",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"A",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"R",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"N",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"E",$celda,0,'C',true);
		$pdf->Cell(5,$altura,"T",$celda,0,'C',true);
		
		$pdf->Ln();
		
		$pdf->SetFont('Arial','',8);
		
		 for($i = 0; $i < count($infDocentes); $i++){
			$altura = 6;
			$celda = 0;
			$pdf->Cell(5,7,$i+1,$celda,0,'C',true);
			($infDocentes[$i]['nombredoc'] != '')?$pdf->Cell(35,$altura,$infDocentes[$i]['nombredoc'],$celda,0,'',true):$pdf->Cell(35,$altura,'SIN ASIGNAR',$celda,0,'',true);
			$pdf->Cell(7,$altura,number_format($infDocentes[$i]['pro_hta'],2,".",","),$celda,0,'C',true);
			$pdf->Cell(5,$altura,$infDocentes[$i]['can_inscritos'],$celda,0,'C',true);
			$pdf->Cell(5,$altura,$infDocentes[$i]['can_cursando'],$celda,0,'C',true);
			$pdf->Cell(5,$altura,$infDocentes[$i]['can_aprobados'],$celda,0,'C',true);
			$pdf->Cell(5,$altura,$infDocentes[$i]['can_reprobados'],$celda,0,'C',true);
			$pdf->Cell(5,$altura,$infDocentes[$i]['can_rep_inasistencia'],$celda,0,'C',true);
			$pdf->Cell(5,$altura,$infDocentes[$i]['can_retirados'],$celda,0,'C',true);
			$pdf->Cell(5,$altura,$infDocentes[$i]['can_total'],$celda,0,'C',true);
			
			$contins += $infDocentes[$i]['can_inscritos'];
			$contcur += $infDocentes[$i]['can_cursando'];
			$conta += $infDocentes[$i]['can_aprobados'];
			$contrep += $infDocentes[$i]['can_reprobados'];
			$contrepi += $infDocentes[$i]['can_rep_inasistencia'];
			$contret += $infDocentes[$i]['can_retirados'];
			$conttotal += $infDocentes[$i]['can_total'];
			
			if($i < count($infUnidades)){
				$pdf->Cell(5,7,"",$celda,0,'C',true);
				$pdf->Cell(5,7,$i+1,$celda,0,'C',true);
				$pdf->Cell(70,$altura,$infUnidades[$i]['nombre'],$celda,0,'',true);
				$pdf->Cell(5,$altura,$infUnidades[$i]['can_inscritos'],$celda,0,'C',true);
				$pdf->Cell(5,$altura,$infUnidades[$i]['can_cursando'],$celda,0,'C',true);
				$pdf->Cell(5,$altura,$infUnidades[$i]['can_aprobados'],$celda,0,'C',true);
				$pdf->Cell(5,$altura,$infUnidades[$i]['can_reprobados'],$celda,0,'C',true);
				$pdf->Cell(5,$altura,$infUnidades[$i]['can_rep_inasistencia'],$celda,0,'C',true);
				$pdf->Cell(5,$altura,$infUnidades[$i]['can_retirados'],$celda,0,'C',true);
				$pdf->Cell(5,$altura,$infUnidades[$i]['can_total'],$celda,0,'C',true);

				$contins2 += $infUnidades[$i]['can_inscritos'];
				$contcur2 += $infUnidades[$i]['can_cursando'];
				$conta2 += $infUnidades[$i]['can_aprobados'];
				$contrep2 += $infUnidades[$i]['can_reprobados'];
				$contrepi2 += $infUnidades[$i]['can_rep_inasistencia'];
				$contret2 += $infUnidades[$i]['can_retirados'];
				$conttotal2 += $infUnidades[$i]['can_total'];
			}
			else if($bool){
				$pdf->SetFont('Arial','B',8);
				$pdf->Cell(5,$altura,'',$celda,0,'C',true);
				$pdf->Cell(70,$altura,'TOTAL',$celda,0,'C',true);
				$pdf->Cell(5,7,"",$celda,0,'C',true);
				$pdf->Cell(5,$altura,$contins2,$celda,0,'C',true);
				$pdf->Cell(5,$altura,$contcur2,$celda,0,'C',true);
				$pdf->Cell(5,$altura,$conta2,$celda,0,'C',true);
				$pdf->Cell(5,$altura,$contrep2,$celda,0,'C',true);
				$pdf->Cell(5,$altura,$contrepi2,$celda,0,'C',true);
				$pdf->Cell(5,$altura,$contret2,$celda,0,'C',true);
				$pdf->Cell(5,$altura,$conttotal2,$celda,0,'C',true);
				$bool = false;
				$pdf->SetFont('Arial','',8);
			}
			
			$pdf->Ln();
		}
		
		$pdf->SetFont('Arial','B',8);
		$pdf->Cell(35,$altura,'TOTAL',$celda,0,'C',true);
		$pdf->Cell(7,7,"",$celda,0,'C',true);
		$pdf->Cell(5,7,"",$celda,0,'C',true);
		$pdf->Cell(5,$altura,$contins,$celda,0,'C',true);
		$pdf->Cell(5,$altura,$contcur,$celda,0,'C',true);
		$pdf->Cell(5,$altura,$conta,$celda,0,'C',true);
		$pdf->Cell(5,$altura,$contrep,$celda,0,'C',true);
		$pdf->Cell(5,$altura,$contrepi,$celda,0,'C',true);
		$pdf->Cell(5,$altura,$contret,$celda,0,'C',true);
		$pdf->Cell(5,$altura,$conttotal,$celda,0,'C',true);
			
	}
	$pdf->Ln();
	
	$pdf->Ln();
	$pdf->Ln();
	
	if($infPromedios != NULL){
		$pdf->SetFont('Arial','B',12);
		$pdf->Cell(130,10,"MEJORES PROMEDIOS",0,0,'C',true);
		
		if($estPorMaterias != NULL){
			$pdf->Cell(40,10,"ESTUDIANTES POR MATERIAS",0,0,'C',true);
		}
		
		$pdf->Ln();
		
		$altura = 7;
		
		$pdf->SetFont('Arial','B',8);
		
		$pdf->Cell(5,7,"#",$celda,0,'C',true);
		$pdf->Cell(20,$altura,"Cédula",$celda,0,'',true);
		$pdf->Cell(45,$altura,"Nombre del Estudiante",$celda,0,'',true);
		$pdf->Cell(15,$altura,"Prom.",$celda,0,'C',true);
		$pdf->Cell(25,$altura,"Cant. Materias",$celda,0,'C',true);
		
		if($estPorMaterias != NULL){
			$pdf->Cell(20,$altura,"",$celda,0,'C',true);
			$pdf->Cell(25,$altura,"Estudiantes",$celda,0,'C',true);
			$pdf->Cell(25,$altura,"Materias",$celda,0,'C',true);
		}
		
		$pdf->Ln();
		
		$pdf->SetFont('Arial','',7);
		
		for($i = 0; $i < count($infPromedios); $i++){
			$pdf->Cell(5,7,$i+1,$celda,0,'C',true);
			$pdf->Cell(20,$altura,$infPromedios[$i]['cedula'],$celda,0,'',true);
			$pdf->Cell(45,$altura,$infPromedios[$i]['nombre'],$celda,0,'',true);
			$pdf->Cell(15,$altura,number_format($infPromedios[$i]['prom'],2,".",","),$celda,0,'C',true);
			$pdf->Cell(25,$altura,$infPromedios[$i]['materias'],$celda,0,'C',true);
			
			if($i < count($estPorMaterias)){
				$pdf->Cell(30,7,"",$celda,0,'C',true);
				$pdf->Cell(25,$altura,$estPorMaterias[$i]['can_estudiantes'],$celda,0,'',true);
				$pdf->Cell(25,$altura,$estPorMaterias[$i]['can_materias'],$celda,0,'',true);
			}
			
			$pdf->Ln();
		}
		$pdf->Ln();
	}

	$pdf->Ln();
	/*
	 * 
	 * CANTIDAD DE ESTUDIANTES QUE CURSARON CANTIDAD DE MATERIAS
	 *
	 */
	
	if($infReprobados != NULL){
		
		$pdf->SetFont('Arial','B',12);
		$pdf->Cell(0,10,"ESTUDIANTES QUE REPROBARON TODAS LAS MATERIAS QUE INSCRIBIERON",0,0,'C',true);
		$pdf->Ln();
		
		$celda = 0;

		$pdf->SetFont('Arial','B',8);
		
		$pdf->SetX(50);
		
		$pdf->Cell(5,7,"#",$celda,0,'C',true);
		$pdf->Cell(20,7,"Cédula",$celda,0,'C',true);
		$pdf->Cell(45,7,"Nombre del Estudiante",$celda,0,'',true);
		$pdf->Cell(10,7,"R",$celda,0,'C',true);
		$pdf->Cell(10,7,"N",$celda,0,'C',true);
		$pdf->Cell(20,7,"Total",$celda,0,'C',true);
		$pdf->Ln();
		
		$pdf->SetFont('Arial','',8);
		
		for($i = 0; $i < count($infReprobados); $i++){
			$pdf->SetX(50);
			
			$pdf->Cell(5,7,$i+1,$celda,0,'C',true);
			$pdf->Cell(20,7,$infReprobados[$i]['cedula'],$celda,0,'C',true);
			$pdf->Cell(45,7,$infReprobados[$i]['nom_completo'],$celda,0,'',true);
			$pdf->Cell(10,7,$infReprobados[$i]['can_reprobado'],$celda,0,'C',true);
			$pdf->Cell(10,7,$infReprobados[$i]['can_rep_inasistencia'],$celda,0,'C',true);
			$pdf->Cell(20,7,$infReprobados[$i]['can_materias'],$celda,0,'C',true);
			$pdf->Ln();
		}
		
		$pdf->Ln();
	}

	$pdf->Output("REPORTE ACADÉMICO. PERIODOS ".implode(",",$periodos).".pdf", 'D');
?>
