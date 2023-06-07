Class {
	#name : #LeExportResourceState,
	#superclass : #Object,
	#category : #'Lepiter-Export-Resources - State'
}

{ #category : #'instance creation' }
LeExportResourceState class >> assembledDuration: aDuration [
	^ LeExportAssembledResourceState new duration: aDuration
]

{ #category : #'instance creation' }
LeExportResourceState class >> assembledException: anException duration: aDuration [
	^ LeExportAssembledExceptionResourceState new 
		exception: anException;
		duration: aDuration
]

{ #category : #'instance creation' }
LeExportResourceState class >> assembledInadequateOutput: anException duration: aDuration [
	^ LeExportAssembledInadequateOutputResourceState new 
		exception: anException;
		duration: aDuration
]

{ #category : #'instance creation' }
LeExportResourceState class >> assembledProblemMessage: aMessage duration: aDuration [
	^ LeExportAssembledProblemResourceState new 
		message: aMessage;
		duration: aDuration
]

{ #category : #'instance creation' }
LeExportResourceState class >> assembling [
	^ LeExportAssemblingResourceState new
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
