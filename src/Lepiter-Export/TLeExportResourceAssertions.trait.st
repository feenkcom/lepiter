Trait {
	#name : #TLeExportResourceAssertions,
	#category : #'Lepiter-Export-Examples'
}

{ #category : #asserting }
TLeExportResourceAssertions >> assertFailedResources: resources [
	| array |
	array := resources asArray.

	self assert: array isNotEmpty description: [ 'Resources must be non-empty' ].

	self
		assert: (array allSatisfy: [ :each | each state isFailure ])
		description: [ 'All resources must have a failure state' ]
]

{ #category : #asserting }
TLeExportResourceAssertions >> assertNotReadyResources: resources [
	| array |
	array := resources asArray.

	self assert: array isNotEmpty description: [ 'Resources must be non-empty' ].

	self
		assert: (array allSatisfy: [ :each | each state isReady not ])
		description: [ 'All resources must be NOT ready' ]
]

{ #category : #asserting }
TLeExportResourceAssertions >> assertReadyResources: resources [
	| array |
	array := resources asArray.

	self assert: array isNotEmpty description: [ 'Resources must be non-empty' ].

	self
		assert: (array allSatisfy: [ :each | each state isReady ])
		description: [ 'All resources must be ready' ]
]

{ #category : #asserting }
TLeExportResourceAssertions >> assertResources: resources size: aSize [
	| array |
	array := resources asArray.

	self
		assert: array size = aSize
		description: [ 'Resources have {1} items but must have {2}'
				format: {array size.
						aSize} ]
]
