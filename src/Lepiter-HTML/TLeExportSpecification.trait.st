Trait {
	#name : #TLeExportSpecification,
	#category : #'Lepiter-HTML-! New - Specifications'
}

{ #category : #'api - testing' }
TLeExportSpecification >> isForObject: anObject [
	"Return true if the specification covers given object"

	<return: #Boolean>
	^ self explicitRequirement
]
