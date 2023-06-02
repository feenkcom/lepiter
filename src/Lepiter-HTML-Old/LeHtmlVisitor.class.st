Class {
	#name : #LeHtmlVisitor,
	#superclass : #Object,
	#traits : 'TLeModelVisitor',
	#classTraits : 'TLeModelVisitor classTrait',
	#instVars : [
		'context'
	],
	#category : #'Lepiter-HTML-Old-! New - Exporter'
}

{ #category : #accessing }
LeHtmlVisitor >> context [
	<return: #LeHtmlContextOld>
	^ context
]

{ #category : #'api - initialization' }
LeHtmlVisitor >> context: aLeHtmlContext [
	self
		assert: [ aLeHtmlContext isNotNil ]
		description: [ 'Context must be non-nil' ].
	self
		assert: [ context isNil ]
		description: [ 'Context must be initialized only once' ].
	
	context := aLeHtmlContext
]

{ #category : #'gt - extensions' }
LeHtmlVisitor >> gtFilesFor: aView [
	<gtView>
	context ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Files';
		priority: 20;
		object: [ context ];
		view: #gtFilesFor:
]

{ #category : #'gt - extensions' }
LeHtmlVisitor >> gtLogFor: aView [
	<gtView>
	context ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Log';
		priority: 20;
		object: [ context ];
		view: #gtLogFor:
]

{ #category : #'gt - extensions' }
LeHtmlVisitor >> gtResourcesFor: aView [
	<gtView>
	context ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Resources';
		priority: 15;
		object: [ context ];
		view: #gtResourcesFor:
]

{ #category : #'gt - extensions' }
LeHtmlVisitor >> gtStreamStateFor: aView [
	<gtView>
	context ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'HTML';
		priority: 10;
		object: [ context ];
		view: #gtStreamStateFor:
]

{ #category : #exporting }
LeHtmlVisitor >> html [
	<return: #ZnHtmlOutputStream>
	^ self context html
]

{ #category : #'private - logging' }
LeHtmlVisitor >> logUnsupportedSnippet: aLeSnippet [ 
	context logger unsupportedSnippet: aLeSnippet
]

{ #category : #exporting }
LeHtmlVisitor >> resourceFor: aLeSnippet [
	<return: #LeExportResourcerResult>
	^ self context resourcer resourceFor: aLeSnippet
]

{ #category : #visiting }
LeHtmlVisitor >> visitElementSnippet: aLeElementSnippet [

	| aResult aFileName |
	aResult := self resourceFor: aLeElementSnippet.
	aFileName := aResult resource pathName.
	
	self 
		writeFigureImgSrc: aFileName 
		caption: aLeElementSnippet caption.
		
	self visitContent: aLeElementSnippet
]

{ #category : #visiting }
LeHtmlVisitor >> visitPictureSnippet: aLePictureSnippet [

	| aResult anImgSrc |
	aResult := self resourceFor: aLePictureSnippet.
	anImgSrc := aResult resource imgSrc.
	
	self 
		writeFigureImgSrc: anImgSrc 
		caption: aLePictureSnippet caption.
		
	self visitContent: aLePictureSnippet
]

{ #category : #visiting }
LeHtmlVisitor >> visitSnippet: aLeSnippet [
	"The #visitSnippet: method should be called only when a snippet is not handled.
	To handle snippet children, call #visitContent:."
	
	self logUnsupportedSnippet: aLeSnippet.

	^ self visitContent: aLeSnippet
]

{ #category : #'private - writing' }
LeHtmlVisitor >> writeFigureImgSrc: anImgSrc caption: aCaption [ 

	self html
		tag: #figure
		attributes: #('class' 'snippet picture-snippet paragraphWidth')
		do: [

			self html
				inlineTag: 'img'
				attributes: {'class'. 'picture-snippet-image'. 'src'. anImgSrc }.

			(aCaption isNotNil
				and: [ aCaption trimBoth isNotEmpty ])
				ifTrue: [ 
					self html
						inlineTag: 'figcaption'
						attributes: #('class' 'picture-snippet-caption')
						with: aCaption asString ] ]
]
