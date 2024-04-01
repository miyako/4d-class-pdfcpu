$event:=FORM Event:C1606

Case of 
	: ($event.code=On Load:K2:1) && (OB Instance of:C1731(Form:C1466; cs:C1710._Form))
		
		Form:C1466.onLoad()
		
	: ($event.code=On Unload:K2:2) && (OB Instance of:C1731(Form:C1466; cs:C1710._Form))
		
		Form:C1466.onUnload()
		
	: ($event.code=On Clicked:K2:4) && (OB Instance of:C1731(Form:C1466; cs:C1710._Form))
		
		Form:C1466.onClicked()
		
End case 