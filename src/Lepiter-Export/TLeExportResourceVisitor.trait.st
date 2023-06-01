Trait {
	#name : #TLeExportResourceVisitor,
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #visiting }
TLeExportResourceVisitor >> visitExportElementSnippetResource: aResource [
	^ self visitExportSnippetResource: aResource
]

{ #category : #visiting }
TLeExportResourceVisitor >> visitExportSlideResource: aResource [
	^ self visitExportSnippetResource: aResource
]

{ #category : #visiting }
TLeExportResourceVisitor >> visitExportSnippetResource: aResource [
]
