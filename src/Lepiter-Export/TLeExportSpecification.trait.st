Trait {
	#name : #TLeExportSpecification,
	#category : #'Lepiter-Export-Specification - Model'
}

{ #category : #accessing }
TLeExportSpecification >> label [
	<return: #BlRope or: #String>
	^ self gtDisplayString
]

{ #category : #'api - building' }
TLeExportSpecification >> objectSpecificationFor: objectContext [
	"Return specification that represents given object."

	<return: #TLeExportSpecification or: nil>
	^ self explicitRequirement
]

{ #category : #'api - building' }
TLeExportSpecification >> resourcerClass [
	"Return a resource builder class that is used to build export resources."

	<return: #'TLeExportResourceBuilder class'>
	^ self explicitRequirement
]
