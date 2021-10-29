Class {
	#name : #LeLinkReferencePreviewElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TLeWithSnippetViewModel',
	#classTraits : 'TBrLayoutResizable classTrait + TLeWithSnippetViewModel classTrait',
	#instVars : [
		'treeElement',
		'snippetsViewModel',
		'updateRequester'
	],
	#category : 'Lepiter-UI-! Link Reference'
}

{ #category : #initialization }
LeLinkReferencePreviewElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
LeLinkReferencePreviewElement >> initialize [
	super initialize.
	self hMatchParent.
	self vFitContent.
]

{ #category : #'api - snippet view model' }
LeLinkReferencePreviewElement >> onSnippetViewModelChanged [
	"Is sent when a new Snippet view model is assigned to the element"
	
	| anElement |
	anElement := self snippetViewModel linkReferenceElement.
	self removeChildren.
	self addChild: anElement.
]
