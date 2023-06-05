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
TLeExportObjectSpecification >> pickedObject [
	"Return object that was used to determine picked specification"

	^ self object
]

{ #category : #accessing }
TLeExportObjectSpecification >> priority [
	"Return a priority value. Lower value, higher priority."

	<return: #Number>
	^ self explicitRequirement
]

{ #category : #'api - building' }
TLeExportObjectSpecification >> resourcer [
	"Return a resource builder that builds resources for given object specifications"

	<return: #TLeExportResourceBuilder>
	^ self explicitRequirement
]

{ #category : #accessing }
TLeExportObjectSpecification >> specification [
	"Return a specification aplicable for a given object"

	<return: #TLeExportSpecification>
	^ self explicitRequirement
]
