Class {
	#name : #LeHtmlVisitor,
	#superclass : #LeExportVisitor,
	#category : #'Lepiter-HTML-! Core'
}

{ #category : #convenience }
LeHtmlVisitor >> contentsFor: snippet [
	^ String
		streamContents: [ :stream | 
			self context stream: stream.
			snippet acceptVisitor: self ]
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
LeHtmlVisitor >> writeElementSnippet: aLeElementSnippet [
	| snippetResources |
	snippetResources := super writeElementSnippet: aLeElementSnippet.

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
				
	^ snippetResources
]

{ #category : #'private - writing' }
LeHtmlVisitor >> writePictureSnippet: aLePictureSnippet [ 
	| snippetResources |
	snippetResources := super writePictureSnippet: aLePictureSnippet.
	
	snippetResources 
		ifEmpty: [ "ignore" ]
		ifOne: [ :aResource |
			LeHtmlFigureImageWriter new
				html: context html;
				imageSrc: aResource imgSrc;
				caption: aLePictureSnippet caption;
				write ]
		ifMore: [ :aCollection | "ignore" ].
				
	^ snippetResources
]
