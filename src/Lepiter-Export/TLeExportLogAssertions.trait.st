Trait {
	#name : #TLeExportLogAssertions,
	#category : #'Lepiter-Export-Examples'
}

{ #category : #asserting }
TLeExportLogAssertions >> assertLog: log size: size [
	| array |
	self assertLogIsInitialized: log.

	array := log asArray.
	
	self
		assert: array size = size
		description: [ 'Log must have {1} items but have {2} '
			format: { array size. size } ]
]

{ #category : #asserting }
TLeExportLogAssertions >> assertLogIsEmpty: log [
	| array |
	self assertLogIsInitialized: log.

	array := log asArray.
	
	self
		assert: array size isZero
		description: [ 'Log must be empty' ]
]

{ #category : #asserting }
TLeExportLogAssertions >> assertLogIsInitialized: log [
	self assert: log isNotNil description: [ 'Log must be non-nil' ]
]
