Class {
	#name : #LeExportResourceReadyCondition,
	#superclass : #Object,
	#traits : 'TLeExportAssembleResourceCondition',
	#classTraits : 'TLeExportAssembleResourceCondition classTrait',
	#category : #'Lepiter-Export-Resources - Support'
}

{ #category : #testing }
LeExportResourceReadyCondition >> canAssemble: aResource [
	^ aResource isOptionalResource not and: [ aResource state isReady not ]
]
