//%attributes = {}
$pdfcpu:=cs:C1710.pdfcpu.new(cs:C1710._pdfcpu_Controller)

$inFile:=File:C1566("/PROJECT/4D Summit 2011 Pre-Class.pdf")

$ex1:={inFile: $inFile; unit: "cm"; pages: [1; 3; 5]}
$ex2:={inFile: $inFile; unit: "cm"}

$info1:=$pdfcpu.info($ex1)

$info2:=$pdfcpu.info($ex2)
