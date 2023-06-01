Trait {
	#name : #TLeExportObjectSpecification,
	#category : #'Lepiter-Export-Specification - Model'
}

{ #category : #accessing }
TLeExportObjectSpecification >> object [
	"Return an object for which I hold a specification"

	<return: #Object>
	^ self explicitRequirement
]

{ #category : #enumerating }
TLeExportObjectSpecification >> objectSpecificationsDo: aBlock [
	aBlock cull: self
]

{ #category : #accessing }
TLeExportObjectSpecification >> priority [
	"Return a priority value. Lower value, higher priority."

	<return: #Number>
	^ self explicitRequirement
]

{ #category : #accessing }
TLeExportObjectSpecification >> specification [
	"Return a specification aplicable for a given object"

	<return: #TLeExportSpecification>
	^ self explicitRequirement
]
