Trait {
	#name : #TLeExportResourceHelpers,
	#category : #'Lepiter-Export-! Core'
}

{ #category : #'private - exporting' }
TLeExportResourceHelpers >> addResource: aResource [
	self context resources addResource: aResource
]

{ #category : #'private - exporting' }
TLeExportResourceHelpers >> nextFileReferenceTo: aRelativePath [
	<return: #FileReference>
	^ self context fileStore nextFileReferenceTo: aRelativePath
]

{ #category : #'private - exporting' }
TLeExportResourceHelpers >> nextPath [
	<return: #RelativePath>
	^ self nextPathWithExtension: LepiterConstants exportedResultsExtension
]

{ #category : #'private - exporting' }
TLeExportResourceHelpers >> nextPathWithExtension: anExtension [
	<return: #RelativePath>
	^ LepiterConstants exportedResultsDirectoryPath / self nextSequence asString
		withExtension: anExtension
]

{ #category : #'private - exporting' }
TLeExportResourceHelpers >> nextSequence [
	<return: #String>
	^ self context sequencer nextId
]

{ #category : #'private - exporting' }
TLeExportResourceHelpers >> resourcesFor: aSource [
	| sourceResources |
	sourceResources := self context resources select: [ :eachResource | 
		eachResource source == aSource ].
	
	^ LeExportSnippetResources new
		resources: sourceResources
]
