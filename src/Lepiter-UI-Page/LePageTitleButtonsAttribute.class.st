Class {
	#name : #LePageTitleButtonsAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventDispatcher',
		'pageViewModel'
	],
	#category : #'Lepiter-UI-Page'
}

{ #category : #initialization }
LePageTitleButtonsAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	^ self makeButtonsFor: anEditorElement
]

{ #category : #'event management accessing' }
LePageTitleButtonsAttribute >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #initialization }
LePageTitleButtonsAttribute >> initialize [
	super initialize.
	
	self placeholderAlignment: #alignMiddle.
	
	eventDispatcher := BlDirectEventDispatcher on: self.
	
	self beAppend
]

{ #category : #initialization }
LePageTitleButtonsAttribute >> makeButtonsFor: anEditorElement [
	| acceptButton frame cancelButton text |
	text := anEditorElement text asString.
	frame := BrHorizontalPane new fitContent.
	(text = self pageViewModel pageTitle
		or: [ self pageViewModel pageModel hasTitle not and: [ text = '' ] ])
		ifTrue: [ ^ frame ].
	acceptButton := BrButton new
			label: 'Accept Title';
			beTinySize;
			margin: (BlInsets left: 2 right: 4);
			aptitude: BrGlamorousButtonWithIconAptitude;
			enabled: (self pageViewModel database hasPageNamed: text) not;
			icon: BrGlamorousVectorIcons accept;
			action: [ :anEvent | self pageViewModel pageTitle: anEditorElement text ].
	cancelButton := BrButton new
			label: 'Cancel';
			beTinySize;
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousVectorIcons cancel;
			action: [ :anEvent | anEditorElement text: self textFromTitle ].

	frame
		addChild: acceptButton;
		addChild: cancelButton.
	^ frame
]

{ #category : #accessing }
LePageTitleButtonsAttribute >> pageViewModel [
	^ pageViewModel
]

{ #category : #accessing }
LePageTitleButtonsAttribute >> pageViewModel: aPageViewModel [
	pageViewModel := aPageViewModel
]

{ #category : #initialization }
LePageTitleButtonsAttribute >> textFromTitle [
	| page |
	"I must be called from a UI process."
	page := self pageViewModel pageModel.
	^ page isUnnamedPage
		ifTrue: [ '' asRopedText
				attribute: (BrGhostTextAttribute
						for: (page type defaultTitle asRopedText glamorousRegularFontAndSize
								foreground: Color lightGray)) ]
		ifFalse: [ self pageViewModel pageTitle ]
]
