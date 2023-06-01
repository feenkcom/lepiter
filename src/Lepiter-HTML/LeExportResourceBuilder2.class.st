Class {
	#name : #LeExportResourceBuilder2,
	#superclass : #Object,
	#traits : 'TLeModelVisitor',
	#classTraits : 'TLeModelVisitor classTrait',
	#instVars : [
		'context',
		'localResources'
	],
	#category : #'Lepiter-HTML-! New - Support'
}

{ #category : #'private - building' }
LeExportResourceBuilder2 >> addLocalResource: aResource [
	localResources add: aResource
]

{ #category : #'private - building' }
LeExportResourceBuilder2 >> addResource: aResource [
	context resources addResource: aResource.
	self addLocalResource: aResource
]

{ #category : #'api - initialization' }
LeExportResourceBuilder2 >> context: aLeHtmlContext [
	self
		assert: [ aLeHtmlContext isNotNil ]
		description: [ 'Context must be non-nil' ].
	self
		assert: [ context isNil ]
		description: [ 'Context must be initialized only once' ].
	
	context := aLeHtmlContext
]

{ #category : #'gt - extensions' }
LeExportResourceBuilder2 >> gtResourcesFor: aView [
	<gtView>
	localResources ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Local resources';
		priority: 1;
		items: [ localResources ifNil: [ #() ] ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 60;
		column: 'Source' text: [ :aResource | aResource source ];
		column: 'Path' text: [ :aResource | aResource pathName ];
		column: 'State' text: [ :aResource | aResource state label ]
]

{ #category : #accessing }
LeExportResourceBuilder2 >> initialize [
	super initialize.

	localResources := OrderedCollection new
]

{ #category : #'private - building' }
LeExportResourceBuilder2 >> nextFileReferenceTo: aRelativePath [
	<return: #FileReference>
	^ context nextFileReferenceTo: aRelativePath
]

{ #category : #'private - building' }
LeExportResourceBuilder2 >> nextPath [
	<return: #RelativePath>
	^ self nextPathWithExtension: LepiterConstants exportedResultsExtension
]

{ #category : #'private - building' }
LeExportResourceBuilder2 >> nextPathWithExtension: anExtension [
	<return: #RelativePath>
	^ LepiterConstants exportedResultsDirectoryPath
		/ self nextSequenceId asString
		withExtension: anExtension.
]

{ #category : #'private - building' }
LeExportResourceBuilder2 >> nextSequenceId [
	<return: #String>
	^ context nextSequenceId
]

{ #category : #'api - building' }
LeExportResourceBuilder2 >> resourceFor: aLeSnippet [
	<return: #LeExportResourcerResult>
	aLeSnippet acceptVisitor: self.
	^ LeExportResourcerResult new 
		createdResources: localResources asArray
]

{ #category : #visiting }
LeExportResourceBuilder2 >> visitElementSnippet: aLeElementSnippet [

	| aResource aHeight aPath aFileReference |
	
	"Compute height"
	aHeight := aLeElementSnippet elementHeight.
	aLeElementSnippet codeVisible ifTrue: [
		aHeight := aHeight + aLeElementSnippet codeHeight
	].
	
	"Prepare file"
	aPath := self nextPath.
	aFileReference := self nextFileReferenceTo: aPath.
	
	aResource := LeExportElementSnippetResource new
		snippet: aLeElementSnippet;
		path: aPath;
		height: aHeight;
		reference: aFileReference.
		
	self addResource: aResource
]

{ #category : #visiting }
LeExportResourceBuilder2 >> visitPictureSnippet: aLePictureSnippet [

	| anUrlUtility anAttachmentFile aPath aResourceState |
	anUrlUtility := aLePictureSnippet urlStringUtility.
	anUrlUtility isFile ifFalse: [ 
		self addLocalResource: (LeExportExternalImageSnippetResource new
			snippet: aLePictureSnippet;
			imgSrc: aLePictureSnippet urlString).
		^ self ].
		
	"Prepare file"
	anAttachmentFile := anUrlUtility asFileReference.
	aPath := self nextPathWithExtension: anAttachmentFile extension.
	
	aResourceState := anAttachmentFile exists
		ifTrue: [ LeExportResourceState ready ]
		ifFalse: [ LeExportResourceState problemMessage: 'File does not exist' ].
	
	"Store the resource"
	self addResource: (LeExportFileImageSnippetResource new 
		snippet: aLePictureSnippet;
		path: aPath;
		state: aResourceState;
		reference: anAttachmentFile).
]
