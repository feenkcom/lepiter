Class {
	#name : #LeExportResourcesDirectorySaver,
	#superclass : #Object,
	#traits : 'TLeExportResourceVisitor',
	#classTraits : 'TLeExportResourceVisitor classTrait',
	#instVars : [
		'resources',
		'rootDirectory'
	],
	#category : #'Lepiter-Export-Resources - Support'
}

{ #category : #'api - saving' }
LeExportResourcesDirectorySaver >> copyContentOfFile: aSourceFile intoPath: aRelativePath [
	| aFile |
	aFile := self resolveRelativePath: aRelativePath.

	aFile ensureDelete.

	aSourceFile copyTo: aFile
]

{ #category : #'gt - extensions' }
LeExportResourcesDirectorySaver >> gtResourcesFor: aView [
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
LeExportResourcesDirectorySaver >> gtRootDirectoryFor: aView [
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
LeExportResourcesDirectorySaver >> resolveRelativePath: aRelativePath [
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
LeExportResourcesDirectorySaver >> resources [
	^ resources
]

{ #category : #accessing }
LeExportResourcesDirectorySaver >> resources: anObject [
	resources := anObject
]

{ #category : #accessing }
LeExportResourcesDirectorySaver >> rootDirectory [
	^ rootDirectory
]

{ #category : #accessing }
LeExportResourcesDirectorySaver >> rootDirectory: anObject [
	rootDirectory := anObject
]

{ #category : #'api - saving' }
LeExportResourcesDirectorySaver >> save [
	self resources do: [ :aResource | self saveResource: aResource ]
]

{ #category : #'api - saving' }
LeExportResourcesDirectorySaver >> saveBytes: aByteArray intoPath: aRelativePath [
	| aFile |
	aFile := self resolveRelativePath: aRelativePath.

	aFile ensureDelete.
	
	aFile 
		binaryWriteStreamDo: [ :aStream | 
			aStream nextPutAll: aByteArray ].
]

{ #category : #'api - saving' }
LeExportResourcesDirectorySaver >> saveResource: aResource [
	aResource state isReady ifFalse: [ ^ self ].

	aResource accept: self
]

{ #category : #'api - saving' }
LeExportResourcesDirectorySaver >> saveString: aString intoPath: aRelativePath [
	| aFile |
	aFile := self resolveRelativePath: aRelativePath.

	aFile ensureDelete.
	
	aFile 
		writeStreamEncoded: #utf8 
		do: [ :aStream | 
			aStream nextPutAll: aString ]
]

{ #category : #visiting }
LeExportResourcesDirectorySaver >> visitByteArrayAssetResource: aResource [
	self
		saveBytes: aResource bytes
		intoPath: aResource path
]

{ #category : #visiting }
LeExportResourcesDirectorySaver >> visitExportAnnotationResource: aResource [ 
	self 
		copyContentOfFile: aResource reference 
		intoPath: aResource path
]

{ #category : #visiting }
LeExportResourcesDirectorySaver >> visitExportExternalImageSnippetResource: aResource [
	"Do nothing, since the image has an external URL"

	
]

{ #category : #visiting }
LeExportResourcesDirectorySaver >> visitExportSnippetResource: aResource [
	self
		assert: [ aResource reference isNotNil ]
		description: [ 'Resource reference must be non-nil: {1}' format: {aResource} ].
		
	self
		assert: [ aResource reference exists ]
		description: [ 'Resource reference must exist: {1}' format: {aResource reference} ].

	self copyContentOfFile: aResource reference intoPath: aResource path
]

{ #category : #visiting }
LeExportResourcesDirectorySaver >> visitFileAssetResource: aLeFileAssetResource [ 

	| aDestination |
	aDestination := self resolveRelativePath: aLeFileAssetResource path.
	
	aDestination ensureDelete.

	aLeFileAssetResource sourceFile copyTo: aDestination.
]

{ #category : #visiting }
LeExportResourcesDirectorySaver >> visitLeExportPageOutputResource: aResource [
	self
		saveString: aResource content
		intoPath: aResource path
]

{ #category : #visiting }
LeExportResourcesDirectorySaver >> visitStringAssetResource: aResource [
	self
		saveString: aResource content
		intoPath: aResource path
]
