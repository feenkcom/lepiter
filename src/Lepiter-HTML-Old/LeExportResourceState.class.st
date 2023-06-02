Class {
	#name : #LeExportResourceState,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Old-! New - Model - Resource State'
}

{ #category : #'instance creation' }
LeExportResourceState class >> assembling [
	^ LeExportAssemblingResourceState new
]

{ #category : #'instance creation' }
LeExportResourceState class >> assemblingException: anException [
	^ LeExportAssemblingExceptionResourceState new exception: anException
]

{ #category : #'instance creation' }
LeExportResourceState class >> assemblingInadequateOutput: anException [
	^ LeExportAssemblingInadequateOutputResourceState new exception: anException
]

{ #category : #'instance creation' }
LeExportResourceState class >> problemMessage: aMessage [
	^ LeExportProblemResourceState new message: aMessage
]

{ #category : #'instance creation' }
LeExportResourceState class >> ready [
	^ LeExportReadyResourceState uniqueInstance
]

{ #category : #'instance creation' }
LeExportResourceState class >> uninitialized [
	^ LeExportUninitializedResourceState uniqueInstance
]
