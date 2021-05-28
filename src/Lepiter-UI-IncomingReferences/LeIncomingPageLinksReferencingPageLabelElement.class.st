Class {
	#name : #LeIncomingPageLinksReferencingPageLabelElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TLeWithIncomingPageLinksReferencingPageLabelViewModel + TLeSnippetElement',
	#classTraits : 'TLeWithIncomingPageLinksReferencingPageLabelViewModel classTrait + TLeSnippetElement classTrait',
	#instVars : [
		'pageSpawnButton'
	],
	#category : #'Lepiter-UI-IncomingReferences-! Views'
}

{ #category : #initialization }
LeIncomingPageLinksReferencingPageLabelElement >> createPageSpawnButton [
	^ BrButton new
		beSmallSize;
		aptitude: BrGlamorousLinkSquaredButtonWithLabelAptitude new glamorousRegularFont;
		padding: (BlInsets top: 3 left: 5 bottom: 3 right: 5);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4)
]

{ #category : #initialization }
LeIncomingPageLinksReferencingPageLabelElement >> initialize [
	super initialize.
	
	self fitContent.
	self alignCenterLeft.
	
	pageSpawnButton := self createPageSpawnButton.
	pageSpawnButton margin: (BlInsets left: 2 right: 2).
	pageSpawnButton action: [ self phlow spawnTool: self incomingPageLinksReferencingPageLabelViewModel asLepiterPagePhlowTool ].
	
	self addChild: (BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: 'Links from').
	self addChild: pageSpawnButton.
	self addChild: (BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: 'page:').
]

{ #category : #'api - incoming page links referencing page label view model' }
LeIncomingPageLinksReferencingPageLabelElement >> onIncomingPageLinksReferencingPageLabelViewModelChanged [
	"Is sent when a new incomingPageLinksReferencingPageLabel view model is assigned to the element"
	
	self margin: (BlInsets top: self incomingPageLinksReferencingPageLabelViewModel marginTop bottom: 5).
	pageSpawnButton label: self incomingPageLinksReferencingPageLabelViewModel displayLabel
]

{ #category : #'api - snippet view model' }
LeIncomingPageLinksReferencingPageLabelElement >> snippetViewModel [
	"Return a not-null Snippet view model assigned to the receiver element"

	^ self incomingPageLinksReferencingPageLabelViewModel
]

{ #category : #'api - snippet view model' }
LeIncomingPageLinksReferencingPageLabelElement >> snippetViewModel: aSnippetViewModel [
	"Set a not-null Snippet view model assigned to the receiver element"
	
	self incomingPageLinksReferencingPageLabelViewModel: aSnippetViewModel
]
