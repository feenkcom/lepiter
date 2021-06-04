"
1. Page reference element
Is a very simple snippet whose only purpose it to display a clickable reference to a page that looks like a button and has page's title as a label


"
Class {
	#name : #LePageReferenceButtonElement,
	#superclass : #BrButton,
	#traits : 'TLeWithSnippetViewModel',
	#classTraits : 'TLeWithSnippetViewModel classTrait',
	#category : #'Lepiter-UI-IncomingReferences-! Views'
}

{ #category : #initialization }
LePageReferenceButtonElement >> initialize [
	super initialize.
	
	self hFitContent.

	self aptitude: BrGlamorousLinkSquaredButtonWithLabelAptitude.
	self padding: (BlInsets top: 3 left: 5 bottom: 3 right: 5).
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	self action: [ :aButton | aButton phlow spawnTool: self snippetViewModel page asLepiterPagePhlowTool ]
]

{ #category : #'api - snippet view model' }
LePageReferenceButtonElement >> onSnippetViewModelChanged [
	"Is sent when a new Snippet view model is assigned to the element"

	self label: self snippetViewModel snippetModel page title
]
