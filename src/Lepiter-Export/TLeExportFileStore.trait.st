Trait {
	#name : #TLeExportFileStore,
	#category : #'Lepiter-Export-File Store'
}

{ #category : #'api - storing' }
TLeExportFileStore >> hasChildren [
	"Return true if the file store has children (files or directories)"

	<return: #Boolean>
	^ self explicitRequirement
]

{ #category : #'api - storing' }
TLeExportFileStore >> nextFileReferenceTo: aRelativePath [
	<return: #FileReference>
	^ self explicitRequirement
]
