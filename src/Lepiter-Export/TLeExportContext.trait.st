Trait {
	#name : #TLeExportContext,
	#category : #'Lepiter-Export-! Core'
}

{ #category : #'api - builders' }
TLeExportContext >> specificationFor: anObject [
	"Return object specification for a given object"

	<return: #TLeObjectExportSpecification>
	^ self explicitRequirement
]
