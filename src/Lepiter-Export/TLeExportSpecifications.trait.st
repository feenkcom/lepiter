Trait {
	#name : #TLeExportSpecifications,
	#category : #'Lepiter-Export-Specification - Model'
}

{ #category : #'add / remove' }
TLeExportSpecifications >> addSpecification: aSpecification [
	"Add new specification"

	self explicitRequirement
]

{ #category : #converting }
TLeExportSpecifications >> asArray [
	"Return Array instance, representing this collection"

	<return: #Array>
	^ self explicitRequirement
]
