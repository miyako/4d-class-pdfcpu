//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	$pdfcpu:=cs:C1710.pdfcpu.new(cs:C1710._pdfcpu_Controller)
	
	$inFile:=File:C1566("/PROJECT/4D Summit 2011 Pre-Class.pdf")
	$outDir:=Folder:C1567(fk desktop folder:K87:19)
	
	//3 pages each
	$ex1:={inFile: $inFile; outDir: $outDir.folder("span"); span: 3}
	
	$pdfcpu.split([$ex1])
	
	$outFile:=Folder:C1567(fk desktop folder:K87:19).folder("merged").file("merged.pdf")
	
	$ex2:={outFile: $outFile; inFiles: $outDir.folder("span").files().query("extension == :1"; ".pdf")}
	
	$pdfcpu.merge([$ex2])
	
End if 