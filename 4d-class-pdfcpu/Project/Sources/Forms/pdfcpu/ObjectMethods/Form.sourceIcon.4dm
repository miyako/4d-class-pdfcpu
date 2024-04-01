$event:=FORM Event:C1606

Case of 
	: ($event.code=On Drag Over:K2:13)
		
		$0:=Form:C1466.onSourceDragOver()
		
	: ($event.code=On Drop:K2:12)
		
		Form:C1466.onSourceDrop().toggleButtons()
		
End case 