Trait {
	#name : #TLeExportFileStoreAssertions,
	#category : #'Lepiter-Export-Examples'
}

{ #category : #asserting }
TLeExportFileStoreAssertions >> assertFileStoreIsEmpty: fileStore [
	self assertFileStoreIsInitializer: fileStore.

	self
		assert: fileStore hasChildren not
		description: [ 'File store must be empty' ]
]

{ #category : #asserting }
TLeExportFileStoreAssertions >> assertFileStoreIsInitializer: fileStore [
	self assert: fileStore isNotNil description: [ 'File store must be non-nil' ]
]

{ #category : #asserting }
TLeExportFileStoreAssertions >> assertFileStoreIsNotEmpty: fileStore [
	self assertFileStoreIsInitializer: fileStore.

	self
		assert: fileStore hasChildren
		description: [ 'File store must have children (files and directories)' ]
]
