Trait {
	#name : #TLeExportAssembleResourceCondition,
	#category : #'Lepiter-Export-Resources - Support'
}

{ #category : #testing }
TLeExportAssembleResourceCondition >> canAssemble: aResource [
	"Return true if a resource can be assembled, false otherwise."

	<return: #Boolean>
	^ self explicitRequirement
]
