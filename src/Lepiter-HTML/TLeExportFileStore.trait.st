Trait {
	#name : #TLeExportFileStore,
	#category : #'Lepiter-HTML-! New - Support'
}

{ #category : #'api - storing' }
TLeExportFileStore >> nextFileReferenceTo: aRelativePath [
	<return: #FileReference>
	^ self explicitRequirement
]
