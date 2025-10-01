Class {
	#name : #LeSlideshowPageSlideElement,
	#superclass : #BrFrame,
	#instVars : [
		'snippet'
	],
	#category : #'Lepiter-UI-Slideshow Page Type'
}

{ #category : #initialization }
LeSlideshowPageSlideElement class >> forSnippet: aLeElementSnippet [
	^ self basicNew
		snippet: aLeElementSnippet;
		initialize
]

{ #category : #initialization }
LeSlideshowPageSlideElement >> initialize [
	super initialize.
	self addChild: self snippetAsElement.
	self snippet weak
		when: LeUIPageChildEvaluationAnnouncement
		do: [ :anEvent | 
			anEvent evaluatedBlockElement = self
				ifFalse: [ (self query // LeElementSnippetElement) result first generateDisplayElement ] ].
	self
		when: LeElementSnippetEvaluated
		do: [ :anEvent | 
			anEvent consumed: true.
			self snippet notifier local
				announce: (LeUIPageChildEvaluationAnnouncement new
						evaluatedBlock: anEvent snippet;
						evaluatedBlockElement: anEvent element;
						topParentElement: self) ]
]

{ #category : #accessing }
LeSlideshowPageSlideElement >> parentTool [
	^ self phlow firstParentWithViewContent
]

{ #category : #accessing }
LeSlideshowPageSlideElement >> snippet [
	^ snippet
]

{ #category : #accessing }
LeSlideshowPageSlideElement >> snippet: aLeElementSnippet [
	snippet := aLeElementSnippet
]

{ #category : #initialization }
LeSlideshowPageSlideElement >> snippetAsElement [
	^ self snippet
		elementHeight: 200;
		codeHeight: 200;
		asSlideshowPageElement
]
