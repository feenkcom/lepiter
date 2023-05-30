Trait {
	#name : #TExportResourceVisitor,
	#category : #'Lepiter-HTML-! New - Model'
}

{ #category : #visiting }
TExportResourceVisitor >> visitExportElementSnippetResource: aResource [
	^ self visitExportedSnippetResource: aResource
]

{ #category : #visiting }
TExportResourceVisitor >> visitExportedSnippetResource: aResource [
]
