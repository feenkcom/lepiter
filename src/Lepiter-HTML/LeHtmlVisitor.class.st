Class {
	#name : #LeHtmlVisitor,
	#superclass : #Object,
	#traits : 'TLeModelVisitor',
	#classTraits : 'TLeModelVisitor classTrait',
	#instVars : [
		'context',
		'elementIds'
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
	<return: #LeHtmlContext>
	^ context
]

{ #category : #accessing }
LeHtmlVisitor >> context: aContext [
	context := aContext
]

{ #category : #visiting }
LeHtmlVisitor >> elementIds [
	^ elementIds ifNil: [ elementIds := OrderedCollection new ]
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
		ifEmpty: [  "ignore" ]
		ifOne: [ :aResource | 
			| aFileName |
			aFileName := aResource pathName.
			LeHtmlFigureImageWriter new
				html: context html;
				imageSrc: aFileName;
				caption: aLeElementSnippet caption;
				width: aLeElementSnippet asSnippetViewModel snippetView desiredSnippetWidth;
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
LeHtmlVisitor >> visitJavaScriptSnippet: aLeJavaScriptSnippet [
	context html
		tag: #div
		attributes: (self
				classesFor: aLeJavaScriptSnippet
				withClasses: 'snippet textual-snippet code-snippet javascript-snippet')
		do: [ context html
				tag: #pre
				attributes: #('class' 'no_bottom_margin')
				with: aLeJavaScriptSnippet code ].
	^ self visitContent: aLeJavaScriptSnippet
]

{ #category : #visiting }
LeHtmlVisitor >> visitPharoSnippet: aLePharoSnippet [
	context html
		tag: #div
		attributes: (self
				classesFor: aLePharoSnippet
				withClasses: 'snippet textual-snippet code-snippet pharo-snippet')
		do: [ context html
				tag: #pre
				attributes: #('class' 'no_bottom_margin')
				with: aLePharoSnippet code ].
	^ self visitContent: aLePharoSnippet
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
				width: aLePictureSnippet asSnippetViewModel snippetView desiredSnippetWidth;
				write ]
		ifMore: [ :aCollection | "ignore" ].

	^ self visitContent: aLePictureSnippet 
]

{ #category : #visiting }
LeHtmlVisitor >> visitPythonSnippet: aLePythonSnippet [
	context html
		tag: #div
		attributes: (self
				classesFor: aLePythonSnippet
				withClasses: 'snippet textual-snippet code-snippet python-snippet')
		do: [ context html
				tag: #pre
				attributes: #('class' 'no_bottom_margin')
				with: aLePythonSnippet code ].
	^ self visitContent: aLePythonSnippet
]

{ #category : #visiting }
LeHtmlVisitor >> visitSnippet: aLeSnippet [
	"The #visitSnippet: method should be called only when a snippet is not handled.
	To handle snippet children, call #visitContent:."
	
	self logUnsupportedSnippet: aLeSnippet.

	^ self visitContent: aLeSnippet
]

{ #category : #visiting }
LeHtmlVisitor >> visitTextSnippet: aLeTextSnippet [
	context html
		tag: #div
		attributes: (self
				classesFor: aLeTextSnippet
				withClasses: 'snippet textual-snippet text-snippet')
		do: [ | visitor |
			visitor := LeHtmlTextSnippetVisitor new
					elementIds: self elementIds;
					context: context;
					snippet: aLeTextSnippet.

			aLeTextSnippet ast acceptVisitor: visitor ].

	self visitContent: aLeTextSnippet
]
