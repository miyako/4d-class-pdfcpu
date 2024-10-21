//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	$pdfcpu:=cs:C1710.pdfcpu.new(cs:C1710._pdfcpu_Controller)
	
	$inFile:=File:C1566("/PROJECT/4Dv20_LTS_brochure_Japanese.pdf")
	$outDir:=Folder:C1567(fk desktop folder:K87:19)
	
	$ex1:={inFile: $inFile; outDir: $outDir.folder("images"); mode: "image"}
	
	$pdfcpu.extract([$ex1])
	
End if 