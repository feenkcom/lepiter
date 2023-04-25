Class {
	#name : #LeResourcesDirectorySaver,
	#superclass : #Object,
	#instVars : [
		'resources',
		'rootDirectory'
	],
	#category : #'Lepiter-HTML-Support'
}

{ #category : #'api - saving' }
LeResourcesDirectorySaver >> copyContentOfFile: aSourceFile intoPath: aRelativePath [
	| aFile |
	aFile := self resolveRelativePath: aRelativePath.

	aSourceFile copyTo: aFile.
]

{ #category : #'private - support' }
LeResourcesDirectorySaver >> resolveRelativePath: aRelativePath [
	| aFile |
	self
		assert: [ rootDirectory exists ]
		description: [ 'Root directory must exist: {1}' format: {rootDirectory} ].

	aFile := rootDirectory resolve: aRelativePath.

	aFile parent = rootDirectory ifFalse: [ 
		aFile parent ensureCreateDirectory ].
		
	^ aFile
]

{ #category : #accessing }
LeResourcesDirectorySaver >> resources [
	^ resources
]

{ #category : #accessing }
LeResourcesDirectorySaver >> resources: anObject [
	resources := anObject
]

{ #category : #accessing }
LeResourcesDirectorySaver >> rootDirectory [
	^ rootDirectory
]

{ #category : #accessing }
LeResourcesDirectorySaver >> rootDirectory: anObject [
	rootDirectory := anObject
]

{ #category : #'api - saving' }
LeResourcesDirectorySaver >> save [
	self resources do: [ :aResource | self saveResource: aResource ]
]

{ #category : #'api - saving' }
LeResourcesDirectorySaver >> saveBytes: aByteArray intoPath: aRelativePath [
	| aFile |
	aFile := self resolveRelativePath: aRelativePath.

	aFile 
		binaryWriteStreamDo: [ :aStream | 
			aStream nextPutAll: aByteArray ].
]

{ #category : #'api - saving' }
LeResourcesDirectorySaver >> saveResource: aResource [
	aResource accept: self
]

{ #category : #'api - saving' }
LeResourcesDirectorySaver >> saveString: aString intoPath: aRelativePath [
	| aFile |
	aFile := self resolveRelativePath: aRelativePath.

	aFile 
		writeStreamEncoded: #utf8 
		do: [ :aStream | 
			aStream nextPutAll: aString ]
]

{ #category : #'as yet unclassified' }
LeResourcesDirectorySaver >> visitByteArrayAssetResource: aResource [
	self
		saveBytes: aResource bytes
		intoPath: aResource path
]

{ #category : #'as yet unclassified' }
LeResourcesDirectorySaver >> visitExportedAnnotationResource: aResource [ 
	self 
		copyContentOfFile: aResource reference 
		intoPath: aResource path
]

{ #category : #'as yet unclassified' }
LeResourcesDirectorySaver >> visitExportedHtmlResource: aResource [
	self
		saveString: aResource content
		intoPath: aResource path
]

{ #category : #'as yet unclassified' }
LeResourcesDirectorySaver >> visitExportedSnippetResource: aResource [
	self 
		copyContentOfFile: aResource reference 
		intoPath: aResource path
]

{ #category : #'as yet unclassified' }
LeResourcesDirectorySaver >> visitStringAssetResource: aResource [
	self
		saveString: aResource content
		intoPath: aResource path
]
