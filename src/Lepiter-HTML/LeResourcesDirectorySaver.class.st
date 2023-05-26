Class {
	#name : #LeResourcesDirectorySaver,
	#superclass : #Object,
	#traits : 'TExportResourceVisitor',
	#classTraits : 'TExportResourceVisitor classTrait',
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

{ #category : #'gt - extensions' }
LeResourcesDirectorySaver >> gtResourcesFor: aView [
	<gtView>
	resources ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Resources';
		priority: 5;
		items: [ resources ifNil: [ #() ] ifNotNil: #asArray ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 60;
		column: 'Source' text: [ :aResource | aResource source ];
		column: 'Path' text: [ :aResource | aResource path fullName ];
		send: [ :aResource | self resolveRelativePath: aResource path ]
]

{ #category : #'gt - extensions' }
LeResourcesDirectorySaver >> gtRootDirectoryFor: aView [
	<gtView>
	rootDirectory ifNil: [ ^ aView empty ].
	rootDirectory exists ifFalse: [ ^ aView empty ].

	^ aView forward
		title: 'Directory';
		priority: 1;
		object: [ rootDirectory ];
		view: #gtTreeFor:;
		actionButtonIcon: BrGlamorousIcons browse
			label: 'In Web Browser'
			tooltip: 'Open HTML index file in a web browser'
			action: [ :aButton | 
				| aFile |
				aFile := rootDirectory / 'index.html'.
				aFile ifExists: [ WebBrowser openOn: aFile fullName ] ]
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

	aFile ensureDelete.
	
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

	aFile ensureDelete.
	
	aFile 
		writeStreamEncoded: #utf8 
		do: [ :aStream | 
			aStream nextPutAll: aString ]
]

{ #category : #visiting }
LeResourcesDirectorySaver >> visitByteArrayAssetResource: aResource [
	self
		saveBytes: aResource bytes
		intoPath: aResource path
]

{ #category : #visiting }
LeResourcesDirectorySaver >> visitExportedAnnotationResource: aResource [ 
	self 
		copyContentOfFile: aResource reference 
		intoPath: aResource path
]

{ #category : #visiting }
LeResourcesDirectorySaver >> visitExportedHtmlResource: aResource [
	self
		saveString: aResource content
		intoPath: aResource path
]

{ #category : #visiting }
LeResourcesDirectorySaver >> visitExportedSnippetResource: aResource [
	self 
		copyContentOfFile: aResource reference 
		intoPath: aResource path
]

{ #category : #visiting }
LeResourcesDirectorySaver >> visitFileAssetResource: aLeFileAssetResource [ 

	| aDestination |
	aDestination := self resolveRelativePath: aLeFileAssetResource path.
	
	aDestination ensureDelete.

	aLeFileAssetResource sourceFile copyTo: aDestination.
]

{ #category : #visiting }
LeResourcesDirectorySaver >> visitStringAssetResource: aResource [
	self
		saveString: aResource content
		intoPath: aResource path
]
