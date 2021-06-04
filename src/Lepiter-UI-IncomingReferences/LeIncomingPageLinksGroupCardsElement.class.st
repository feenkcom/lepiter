"
1. Page references card element

Displays a list of snippets in a #page that reference #referencedPage


"
Class {
	#name : #LeIncomingPageLinksGroupCardsElement,
	#superclass : #BlElement,
	#traits : 'TLeWithIncomingPageLinksGroupCardsViewModel + TLeSnippetElement + TBrLayoutResizable',
	#classTraits : 'TLeWithIncomingPageLinksGroupCardsViewModel classTrait + TLeSnippetElement classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'previewElement'
	],
	#category : #'Lepiter-UI-IncomingReferences-! Views'
}

{ #category : #private }
LeIncomingPageLinksGroupCardsElement >> createSnippetPreviewCardFor: aLeIncomingPageLinkCardViewModel [
	^ (LeIncomingPageLinkCardElement new incomingPageLinkCardViewModel: aLeIncomingPageLinkCardViewModel)
		constraintsDo: [ :c | c grid horizontal span: 1 ];
		action: [ self onShowPage ]
]

{ #category : #initialization }
LeIncomingPageLinksGroupCardsElement >> initialize [
	super initialize.

	self layout: BlLinearLayout vertical.
	self clipChildren: false.
	self hMatchParent.
	self vFitContent.

	self initializePreviewElement.

	self addChild: self previewElement.

	self addAptitude: (BrLayoutResizerAptitude new
		inherit: self previewElement).

	self previewElement addAptitude: (BrLayoutResizerAptitude new
		hInherit: [ :aBlock | self previewElement childrenDo: [ :eachChild | aBlock value: eachChild ] ];
		vAnyToFitContent: [ :aBlock | self previewElement childrenDo: [ :eachChild | aBlock value: eachChild ] ])
]

{ #category : #initialization }
LeIncomingPageLinksGroupCardsElement >> initializePreviewElement [
	previewElement := BrHorizontalGrid new
		columnCount: 3;
		cellSpacing: 15;
		"negative padding to compensate for the cell spacing"
		padding: (BlInsets all: -15);
		clipChildren: false
]

{ #category : #'api - incoming page links group cards view model' }
LeIncomingPageLinksGroupCardsElement >> onIncomingPageLinksGroupCardsViewModelChanged [
	"Is sent when a new incomingPageLinksGroupCards view model is assigned to the element"
	
	self updateCard
]

{ #category : #'private - event handling' }
LeIncomingPageLinksGroupCardsElement >> onShowPage [
	self phlow spawnTool: self incomingPageLinksGroupCardsViewModel asLepiterReferencedPagePhlowTool
]

{ #category : #accessing }
LeIncomingPageLinksGroupCardsElement >> previewElement [
	^ previewElement
]

{ #category : #'api - snippet view model' }
LeIncomingPageLinksGroupCardsElement >> snippetViewModel [
	"Return a not-null Snippet view model assigned to the receiver element"

	^ self incomingPageLinksGroupCardsViewModel
]

{ #category : #'api - snippet view model' }
LeIncomingPageLinksGroupCardsElement >> snippetViewModel: aSnippetViewModel [
	"Set a not-null Snippet view model assigned to the receiver element"
	
	self incomingPageLinksGroupCardsViewModel: aSnippetViewModel
]

{ #category : #'private - accessing' }
LeIncomingPageLinksGroupCardsElement >> spaceGap [
	^ 10
]

{ #category : #'private - hooks' }
LeIncomingPageLinksGroupCardsElement >> updateCard [
	self previewElement removeChildren.
	
	self incomingPageLinksGroupCardsViewModel incomingPageLinkViewModels
		do: [ :eachIncomingPageLinkViewModel |
			self previewElement addChild: (self createSnippetPreviewCardFor: eachIncomingPageLinkViewModel) ].
	
	"two fake zero-size elements to fill the space in the grid, otherwise if there is just one element in a row it will try to occupy it"
	self previewElement
		addChild: (BlElement new size: 0@0);
		addChild: (BlElement new size: 0@0).
	
	self previewElement requestStyle
]
