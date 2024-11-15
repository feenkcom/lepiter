Trait {
	#name : #TLeExportResourceVisitor,
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #visiting }
TLeExportResourceVisitor >> visitExportAnnotationResource: aResource [
	^ self visitResource: aResource
]

{ #category : #visiting }
TLeExportResourceVisitor >> visitExportElementSnippetResource: aResource [
	^ self visitExportSnippetResource: aResource
]

{ #category : #visiting }
TLeExportResourceVisitor >> visitExportExampleSnippetResource: aResource [
	^ self visitExportSnippetResource: aResource
]

{ #category : #visiting }
TLeExportResourceVisitor >> visitExportExternalImageSnippetResource: aResource [
	^ self visitExportSnippetResource: aResource
]

{ #category : #visiting }
TLeExportResourceVisitor >> visitExportSlideResource: aResource [
	^ self visitExportSnippetResource: aResource
]

{ #category : #visiting }
TLeExportResourceVisitor >> visitExportSnippetElementResource: aResource [
	^ self visitExportSnippetResource: aResource
]

{ #category : #visiting }
TLeExportResourceVisitor >> visitExportSnippetResource: aResource [
	^ self visitResource: aResource
]

{ #category : #visiting }
TLeExportResourceVisitor >> visitExportTextSnippetExampleAnnotationResource: aResource [
	^ self visitExportSnippetResource: aResource
]

{ #category : #visiting }
TLeExportResourceVisitor >> visitLeExportPageOutputResource: aResource [
	^ self visitResource: aResource
]

{ #category : #visiting }
TLeExportResourceVisitor >> visitResource: aResource [
	
]
