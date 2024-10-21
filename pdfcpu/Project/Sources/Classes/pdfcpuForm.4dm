Class extends _Form

property targetFolder : 4D:C1709.Folder

Class constructor
	
	Super:C1705()
	
	This:C1470.targetFolder:=Folder:C1567(fk desktop folder:K87:19)
	
	$window:=Open form window:C675("pdfcpu")
	DIALOG:C40("pdfcpu"; This:C1470; *)
	
Function onLoad()
	
	Form:C1466.pdfcpu:=cs:C1710.pdfcpu.new(cs:C1710._pdfcpuUI_Controller)
	
	Form:C1466.init().toggleInput().toggleButtons()
	
Function onClicked()
	
	Form:C1466.toggleInput()
	
Function onUnload()
	
	Form:C1466.pdfcpu.terminate()
	
Function init()
	
	Form:C1466.span:=True:C214
	Form:C1466.bookmark:=False:C215
	Form:C1466.page:=False:C215
	Form:C1466.arg:={span: 1; page: 1}
	
	return Form:C1466
	
Function split($src : Object)
	
	OBJECT SET ENABLED:C1123(*; "Split"; False:C215)
	
	$PROJECT:=File:C1566(Structure file:C489; fk platform path:K87:2).name
	
	$outDir:=Folder:C1567(fk desktop folder:K87:19)
	Case of 
		: (Form:C1466.span)
			$outDir:=$outDir.folder("span")
		: (Form:C1466.page)
			$outDir:=$outDir.folder("page")
		: (Form:C1466.bookmark)
			$outDir:=$outDir.folder("bookmark")
	End case 
	
	$options:=[]
	
	Case of 
		: (OB Instance of:C1731(Form:C1466.source; 4D:C1709.File))
			$option:={inFile: Form:C1466.source; outDir: $outDir}
			Case of 
				: (Form:C1466.span)
					$option.span:=Form:C1466.arg.span
				: (Form:C1466.page)
					$option.span:=Form:C1466.arg.page
					$option.mode:="page"
				: (Form:C1466.bookmark)
					$option.mode:="bookmark"
			End case 
			$options.push($option)
		: (OB Instance of:C1731(Form:C1466.source; 4D:C1709.Folder))
			For each ($inFile; Form:C1466.source.files().query("extension == :1"; ".pdf"))
				$option:={inFile: $inFile; outDir: $outDir}
				Case of 
					: (Form:C1466.span)
						$option.span:=Form:C1466.arg.span
					: (Form:C1466.page)
						$option.span:=Form:C1466.arg.page
						$option.mode:="page"
					: (Form:C1466.bookmark)
						$option.mode:="bookmark"
				End case 
				$options.push($option)
			End for each 
	End case 
	
	Form:C1466.pdfcpu.split($options)
	
	return Form:C1466
	
Function toggleButtons()
	
	Case of 
		: (OB Instance of:C1731(Form:C1466.source; 4D:C1709.Folder) || OB Instance of:C1731(Form:C1466.source; 4D:C1709.File)) && (Form:C1466.source.exists)
			
			OBJECT SET ENABLED:C1123(*; "Split"; True:C214)
			
		Else 
			
			OBJECT SET ENABLED:C1123(*; "Split"; False:C215)
			
	End case 
	
	return Form:C1466
	
Function toggleInput()
	
	OBJECT SET ENTERABLE:C238(*; "arg.@"; False:C215)
	
	Case of 
		: (Form:C1466.span)
			OBJECT SET ENTERABLE:C238(*; "arg.span"; True:C214)
			GOTO OBJECT:C206(*; "arg.span")
		: (Form:C1466.page)
			OBJECT SET ENTERABLE:C238(*; "arg.page"; True:C214)
			GOTO OBJECT:C206(*; "arg.page")
	End case 
	
	return Form:C1466
	
Function onSourceDragOver()
	
	$path:=Get file from pasteboard:C976(1)
	
	If ($path#"") && ((Test path name:C476($path)=Is a folder:K24:2)\
		 || ((Test path name:C476($path)=Is a document:K24:1) && (Path to object:C1547($path).extension=".pdf")))
		$0:=0
	Else 
		$0:=-1
	End if 
	
Function onSourceDrop()
	
	$path:=Get file from pasteboard:C976(1)
	
	var $class : 4D:C1709.Class
	
	Case of 
		: (Test path name:C476($path)=Is a folder:K24:2)
			$class:=4D:C1709.Folder
		: (Test path name:C476($path)=Is a document:K24:1)
			$class:=4D:C1709.File
	End case 
	
	If ($class#Null:C1517)
		
		Form:C1466.source:=$class.new($path; fk platform path:K87:2)
		
		If (Is macOS:C1572)
			Form:C1466.sourceIcon:=Form:C1466.source.getIcon()
		Else 
			$icon:=Form:C1466.source.getIcon(256)
			Form:C1466.sourceIcon:=$icon
		End if 
		
	End if 
	
	return Form:C1466