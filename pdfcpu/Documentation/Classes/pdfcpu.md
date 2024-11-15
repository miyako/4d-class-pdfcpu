# pdfcpu : _CLI

`pdfcpu` is a subclass of `_CLI` to execute the `pdfcpu` program. 

## .extract() 

**.extract**($options : Variant) : cs.pdfcpu

Extract images, fonts, raw page content in PDF syntax, actual pages as single side PDFs, embedded XML metadata from `inFile` to `outDir`.

c.f. [extract](https://pdfcpu.io/extract/extract)

## .info() 

**.info**($option : Object) : Object

Print information about `inFile` and its attachments.

c.f. [info](https://pdfcpu.io/info)

## .merge() 

**.merge**($options : Variant) : cs.pdfcpu

Merge `inFiles` into `outFile`.

c.f. [merge](https://pdfcpu.io/core/merge)

## .split() 

**.split**($options : Variant) : cs.pdfcpu

Generate a set of PDF files from `inFile` in `outDir` according to given span value. 

c.f. [split](https://pdfcpu.io/core/split)