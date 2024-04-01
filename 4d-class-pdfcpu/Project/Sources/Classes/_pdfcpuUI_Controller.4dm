Class extends _pdfcpu_Controller

Class constructor($CLI : cs:C1710._CLI)
	
	Super:C1705($CLI)
	
Function onDataError($worker : 4D:C1709.SystemWorker; $params : Object)
	
	Super:C1706.onDataError($worker; $params)
	
Function onData($worker : 4D:C1709.SystemWorker; $params : Object)
	
	Super:C1706.onData($worker; $params)
	
Function onResponse($worker : 4D:C1709.SystemWorker; $params : Object)
	
	Super:C1706.onResponse($worker; $params)
	
Function onTerminate($worker : 4D:C1709.SystemWorker; $params : Object)
	
	If (Form:C1466#Null:C1517)
		
		If (This:C1470.complete)
			
			Form:C1466.toggleButtons()
			
		End if 
		
	End if 