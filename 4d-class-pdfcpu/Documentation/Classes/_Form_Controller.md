# _Form_Controller : _CLI_Controller

`_Form_Controller` is a subclass of `_CLI_Controller` to execute a console program in a form. 

The class defines the following properties:

|Property|Type|Description|
|:-|:-|:-|
|stdOut|Text|read-only|
|stdErr|Text|read-only|
|onDataCount|Integer|read-only|
|onDataErrorCount|Integer|read-only|
|onResponseCount|Integer|read-only|
|onTerminateCount|Integer|read-only|

## .bind() 

**.bind**($options : Object)

Binds the supplied form object names to a specific functionality. 

The following object names are supported:

|Property|Type|Description|
|:-|:-|:-|
|startButton|Text||
|stopButton|Text||

The enabled/disabled status of each button object is toggled automatically.

**.start**()

## .start()

**.start**()

## .stop() 

**.stop**()