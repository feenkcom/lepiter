Trait {
	#name : #TLeExportSpecification2,
	#category : #'Lepiter-HTML-! New - Specifications'
}

{ #category : #'api - testing' }
TLeExportSpecification2 >> isForObject: anObject [
	"Return true if the specification covers given object"

	<return: #Boolean>
	^ self explicitRequirement
]
