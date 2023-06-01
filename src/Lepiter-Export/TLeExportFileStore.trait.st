Trait {
	#name : #TLeExportFileStore,
	#category : #'Lepiter-Export-File Store'
}

{ #category : #'api - storing' }
TLeExportFileStore >> nextFileReferenceTo: aRelativePath [
	<return: #FileReference>
	^ self explicitRequirement
]
