Class {
	#name : #LeHtmlVisitor,
	#superclass : #Object,
	#traits : 'TLeModelVisitor',
	#classTraits : 'TLeModelVisitor classTrait',
	#instVars : [
		'context'
	],
	#category : #'Lepiter-HTML-! Core'
}

{ #category : #convenience }
LeHtmlVisitor >> contentsFor: snippet [
	^ String
		streamContents: [ :stream | 
			self context stream: stream.
			snippet acceptVisitor: self ]
]

{ #category : #accessing }
LeHtmlVisitor >> context [
	<return: #TLeHtmlContext>
	^ context
]

{ #category : #accessing }
LeHtmlVisitor >> context: aContext [
	context := aContext
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

{ #category : #'private - writing' }
LeHtmlVisitor >> html [
	^ context html
]

{ #category : #'private - logging' }
LeHtmlVisitor >> logUnsupportedSnippet: aLeSnippet [ 
	context logger unsupportedSnippet: aLeSnippet
]

{ #category : #convenience }
LeHtmlVisitor >> resourcesFor: aLeSnippet [
	<return: #Collection of: #TLeExportResource>
	| snippetResources |
	snippetResources := context resources select: [ :eachResource | 
		eachResource source == aLeSnippet ].
		
	^ LeExportSnippetResources new
		resources: snippetResources
]

{ #category : #visiting }
LeHtmlVisitor >> visitElementSnippet: aLeElementSnippet [
	| snippetResources |
	
	snippetResources := self resourcesFor: aLeElementSnippet.
	
	snippetResources 
		ifEmpty: [ "ignore" ]
		ifOne: [ :aResource |
			| aFileName |
			aFileName := aResource pathName.
			LeHtmlFigureImageWriter new
				html: context html;
				imageSrc: aFileName;
				caption: aLeElementSnippet caption;
				write ]
		ifMore: [ :aCollection |
			LeHtmlCarouselWriter new
				html: context html;
				sequencer: context sequencer;
				resources: aCollection;
				write ].

	^ self visitContent: aLeElementSnippet
]

{ #category : #visiting }
LeHtmlVisitor >> visitPictureSnippet: aLePictureSnippet [

	| snippetResources |
	snippetResources := self resourcesFor: aLePictureSnippet.
	
	snippetResources 
		ifEmpty: [ "ignore" ]
		ifOne: [ :aResource |
			LeHtmlFigureImageWriter new
				html: context html;
				imageSrc: aResource imgSrc;
				caption: aLePictureSnippet caption;
				write ]
		ifMore: [ :aCollection | "ignore" ].

	^ self visitContent: aLePictureSnippet 
]

{ #category : #visiting }
LeHtmlVisitor >> visitSnippet: aLeSnippet [
	"The #visitSnippet: method should be called only when a snippet is not handled.
	To handle snippet children, call #visitContent:."
	
	self logUnsupportedSnippet: aLeSnippet.

	^ self visitContent: aLeSnippet
]
