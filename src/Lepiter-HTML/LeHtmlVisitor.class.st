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

{ #category : #visiting }
LeHtmlVisitor >> visitElementSnippet: aLeElementSnippet [
	| snippetResources |
	super visitElementSnippet: aLeElementSnippet.

	snippetResources := self resourcesFor: aLeElementSnippet.

	snippetResources 
		ifEmpty: [ ^ self ]
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
				write ]
]
