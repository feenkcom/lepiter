Trait {
	#name : #TLeExportSpecification,
	#category : #'Lepiter-Export-Specification - Model'
}

{ #category : #'api - building' }
TLeExportSpecification >> objectSpecificationFor: objectContext [
	"Return specification that represents given object."

	<return: #TLeExportSpecification or: nil>
	^ self explicitRequirement
]
