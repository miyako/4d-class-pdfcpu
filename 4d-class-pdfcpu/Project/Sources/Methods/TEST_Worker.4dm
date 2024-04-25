//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	$pdfcpu:=cs:C1710.pdfcpu.new(cs:C1710._pdfcpu_Controller)
	
	$inFile:=File:C1566("/PROJECT/4D Summit 2011 Pre-Class.pdf")
	$outDir:=Folder:C1567(fk desktop folder:K87:19)
	
	//before and after page 2
	$ex1:={inFile: $inFile; outDir: $outDir.folder("page").folder("2"); mode: "page"; span: 2}
	
	//3 pages each
	$ex2:={inFile: $inFile; outDir: $outDir.folder("span"); span: 3}
	
	//before pages 2,4,10
	$ex3:={inFile: $inFile; outDir: $outDir.folder("page").folder("2 4 10"); mode: "page"; span: [2; 4; 10]}
	
	$pdfcpu.split([$ex1; $ex2; $ex3])
	
End if 