Class {
	#name : #LeHtmlVisitor,
	#superclass : #Object,
	#traits : 'TLeModelVisitor',
	#classTraits : 'TLeModelVisitor classTrait',
	#instVars : [
		'context'
	],
	#category : #'Lepiter-HTML-! New - Exporter'
}

{ #category : #accessing }
LeHtmlVisitor >> context [
	<return: #LeHtmlContext>
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
]

{ #category : #visiting }
LeHtmlVisitor >> visitPictureSnippet: aLePictureSnippet [

	| aResult anImgSrc |
	aResult := self resourceFor: aLePictureSnippet.
	anImgSrc := aResult resource imgSrc.
	
	self 
		writeFigureImgSrc: anImgSrc 
		caption: aLePictureSnippet caption.
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
