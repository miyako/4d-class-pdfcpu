![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-class-pdfcpu)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/4d-class-pdfcpu/total)

Classes to use the golang utility [pdfcpu](https://pdfcpu.io).

## dependencies.json

```json
{
	"dependencies": {
		"pdfcpu": {
			"github": "miyako/pdfcpu",
			"version": "^0.0.1"
		}
	}
}
```

## Examples

```4d
$PROJECT:=File(Structure file; fk platform path).name

$src:=Folder(Folder("/PROJECT/").platformPath; fk platform path).parent.folder("Samples/windows")
$dst:=Folder(fk desktop folder)

var $pdfcpu : cs.pdfcpu.pdfcpu
$pdfcpu:=cs.pdfcpu.pdfcpu.new(cs.pdfcpu._pdfcpu_Controller)

$inFile:=File("/PROJECT/4D Summit 2011 Pre-Class.pdf")
$outDir:=Folder(fk desktop folder)

//before and after page 2
$ex1:={inFile: $inFile; outDir: $outDir.folder("page"); mode: "page"; span: 2}

//3 pages each
$ex2:={inFile: $inFile; outDir: $outDir.folder("span"); span: 3}

//before pages 2,4,10
$ex3:={inFile: $inFile; outDir: $outDir.folder("pages"); mode: "page"; span: [2; 4; 10]}

$pdfcpu.split([$ex1; $ex2; $ex3])
```
