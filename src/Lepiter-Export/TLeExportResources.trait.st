Trait {
	#name : #TLeExportResources,
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #'add / remove' }
TLeExportResources >> addResource: aResource [
	self explicitRequirement
]

{ #category : #converting }
TLeExportResources >> asArray [
	<return: #Array>
	^ self explicitRequirement
]

{ #category : #enumerating }
TLeExportResources >> do: aBlock [
	"Iterate all resources and evaluate the block for every resource"

	self explicitRequirement
]
