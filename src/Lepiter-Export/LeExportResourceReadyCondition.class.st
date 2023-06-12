Class {
	#name : #LeExportResourceReadyCondition,
	#superclass : #Object,
	#traits : 'TLeExportAssembleResourceCondition',
	#classTraits : 'TLeExportAssembleResourceCondition classTrait',
	#category : #'Lepiter-Export-Resources - Support'
}

{ #category : #testing }
LeExportResourceReadyCondition >> canAssemble: aResource [
	"Return true if a resource can be assembled, false otherwise."

	<return: #Boolean>
	^ aResource state isReady not
]
