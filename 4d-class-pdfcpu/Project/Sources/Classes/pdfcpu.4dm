Class extends _CLI

Class constructor($controller : 4D:C1709.Class)
	
	Super:C1705("pdfcpu"; $controller)
	
Function onResponse($files : Collection; $parameters : Collection)
	
Function terminate()
	
	This:C1470.controller.terminate()
	
Function _path($item : Object) : Text
	
	return OB Class:C1730($item).new($item.platformPath; fk platform path:K87:2).path
	
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