Class extends _CLI

Class constructor($controller : 4D:C1709.Class)
	
	Super:C1705("pdfcpu"; $controller)
	
Function terminate()
	
	This:C1470.controller.terminate()
	
Function _path($item : Object) : Text
	
	return OB Class:C1730($item).new($item.platformPath; fk platform path:K87:2).path
	
Function get worker() : 4D:C1709.SystemWorker
	
	return This:C1470._controller.worker
	
Function extract($option : Variant)->$this : cs:C1710.pdfcpu
	
	$this:=This:C1470
	
	var $commands; $options : Collection
	$commands:=[]
	
	Case of 
		: (Value type:C1509($option)=Is object:K8:27)
			$options:=[$option]
		: (Value type:C1509($option)=Is collection:K8:32)
			$options:=$option
	End case 
	
	var $inFile : 4D:C1709.File
	var $outDir : 4D:C1709.Folder
	
	For each ($option; $options)
		
		If ($option.inFile#Null:C1517) && (OB Instance of:C1731($option.inFile; 4D:C1709.File)) && ($option.inFile.exists)\
			 && ($option.outDir#Null:C1517) && (OB Instance of:C1731($option.outDir; 4D:C1709.Folder))
			
			$command:=This:C1470.escape(This:C1470._executablePath)+" extract"
			
			If ($option.mode#Null:C1517) && (Value type:C1509($option.mode)=Is text:K8:3)
				Case of 
					: ($option.mode="image")
						$command+=" -m image"
					: ($option.mode="font")
						$command+=" -m font"
					: ($option.mode="content")
						$command+=" -m content"
					: ($option.mode="meta")
						$command+=" -m meta"
					: ($option.mode="page")
						$command+=" -m page"
						$page:=" "+String:C10($option.page)
					Else 
						$command+=" -m image"
				End case 
			End if 
			
			$option.outDir.create()
			
			$command+=" "+This:C1470.escape(This:C1470._path($option.inFile))
			$command+=" "+This:C1470.escape(This:C1470._path($option.outDir))
			
			$commands.push($command)
			
		End if 
		
	End for each 
	
	This:C1470.controller.execute($commands)
	
Function info($option : Object) : Object
	
	$this:=This:C1470
	
	If ($option#Null:C1517)
		
		var $inFile : 4D:C1709.File
		
		If ($option.inFile#Null:C1517) && (OB Instance of:C1731($option.inFile; 4D:C1709.File)) && ($option.inFile.exists)
			
			$command:=This:C1470.escape(This:C1470._executablePath)+" info -json"
			
			If ($option.unit#Null:C1517) && (Value type:C1509($option.unit)=Is text:K8:3)
				Case of 
					: ($option.unit="po@")
						$command+=" -u po"
					: ($option.unit="in@")
						$command+=" -u in"
					: ($option.unit="cm@")
						$command+=" -u cm"
					: ($option.unit="mm@")
						$command+=" -u mm"
				End case 
			End if 
			
			Case of 
				: (Value type:C1509($option.pages)=Is collection:K8:32)
					$command+=" -p "+$option.pages.join(","; ck ignore null or empty:K85:5)
				: ($option.pages#Null:C1517) && (Value type:C1509($option.pages)=Is real:K8:4)
					$command+=" -p "+String:C10($option.pages)
			End case 
			
			$command+=" "+This:C1470.escape(This:C1470._path($option.inFile))
			
			This:C1470.controller.execute($command)
			
			var $json : Text
			$json:=This:C1470.worker.wait().response
			
			If ($json#"")
				
				ARRAY TEXT:C222($pos; 0)
				ARRAY TEXT:C222($len; 0)
				
				If (Match regex:C1019("(?s)(\\{.+)"; $json; 1; $pos; $len))
					$json:=Substring:C12($json; $pos{1}; $len{1})
				End if 
				
				return JSON Parse:C1218($json; Is object:K8:27)
				
			End if 
			
		End if 
		
	End if 
	
	return Null:C1517
	
Function merge($option : Variant)->$this : cs:C1710.pdfcpu
	
	$this:=This:C1470
	
	var $commands; $options : Collection
	$commands:=[]
	
	Case of 
		: (Value type:C1509($option)=Is object:K8:27)
			$options:=[$option]
		: (Value type:C1509($option)=Is collection:K8:32)
			$options:=$option
	End case 
	
	var $outFile : 4D:C1709.File
	
	For each ($option; $options)
		
		If ($option.outFile#Null:C1517) && (OB Instance of:C1731($option.outFile; 4D:C1709.File))\
			 && ($option.inFiles#Null:C1517) && ($option.inFiles.length#0)
			
			$option.outFile.parent.create()
			
			$command:=This:C1470.escape(This:C1470._executablePath)+" merge"
			
			If ($option.mode#Null:C1517) && (Value type:C1509($option.mode)=Is text:K8:3)
				Case of 
					: ($option.mode="create")
						$command+=" -m create"
					: ($option.mode="append")
						$command+=" -m append"
					: ($option.mode="zip")
						$command+=" -m zip"
				End case 
			End if 
		End if 
		
		var $inFiles : Collection
		var $inFile : Variant
		$inFiles:=[]
		For each ($inFile; $option.inFiles)
			Case of 
				: (Value type:C1509($inFile)=Is text:K8:3)
					$inFiles.push($inFile)
				: (Value type:C1509($inFile)=Is object:K8:27) && (OB Instance of:C1731($inFile; 4D:C1709.File)) && ($inFile.exists)
					$inFiles.push(This:C1470._path($inFile))
			End case 
		End for each 
		
		If ($option.sort#Null:C1517) && (Bool:C1537($option.sort))
			$command+=" -s"
		End if 
		
		If ($option.bookmarks#Null:C1517) && (Bool:C1537($option.bookmarks))
			$command+=" -b"
		End if 
		
		If ($option.divider#Null:C1517) && (Bool:C1537($option.divider))
			$command+=" -d"
		End if 
		
		$command+=" "+This:C1470.escape(This:C1470._path($option.outFile))
		
		For each ($inFile; $inFiles)
			$command+=" "+This:C1470.quote($inFile)
		End for each 
		
		$commands.push($command)
		
	End for each 
	
	This:C1470.controller.execute($commands)
	
Function split($option : Variant)->$this : cs:C1710.pdfcpu
	
	$this:=This:C1470
	
	var $commands; $options : Collection
	$commands:=[]
	
	Case of 
		: (Value type:C1509($option)=Is object:K8:27)
			$options:=[$option]
		: (Value type:C1509($option)=Is collection:K8:32)
			$options:=$option
	End case 
	
	var $inFile : 4D:C1709.File
	var $outDir : 4D:C1709.Folder
	
	For each ($option; $options)
		
		If ($option.inFile#Null:C1517) && (OB Instance of:C1731($option.inFile; 4D:C1709.File)) && ($option.inFile.exists)\
			 && ($option.outDir#Null:C1517) && (OB Instance of:C1731($option.outDir; 4D:C1709.Folder))
			
			$command:=This:C1470.escape(This:C1470._executablePath)+" split"
			
			If ($option.mode#Null:C1517) && (Value type:C1509($option.mode)=Is text:K8:3)
				Case of 
					: ($option.mode="bookmark")
						$command+=" -m bookmark"
					: ($option.mode="page")
						$command+=" -m page"
						$page:=" "+String:C10($option.page)
					Else 
						$command+=" -m span"
				End case 
			End if 
			
			$option.outDir.create()
			
			$command+=" "+This:C1470.escape(This:C1470._path($option.inFile))
			$command+=" "+This:C1470.escape(This:C1470._path($option.outDir))
			
			Case of 
				: (Value type:C1509($option.span)=Is collection:K8:32)
					$command+=" "+$option.span.join(" "; ck ignore null or empty:K85:5)
				: ($option.span#Null:C1517)
					$command+=" "+String:C10($option.span)
			End case 
			
			$commands.push($command)
			
		End if 
		
	End for each 
	
	This:C1470.controller.execute($commands)