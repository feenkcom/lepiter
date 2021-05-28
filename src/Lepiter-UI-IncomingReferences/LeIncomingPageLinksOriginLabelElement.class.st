Class {
	#name : #LeIncomingPageLinksOriginLabelElement,
	#superclass : #BrLabel,
	#traits : 'TLeWithIncomingPageLinksOriginLabelViewModel + TLeSnippetElement',
	#classTraits : 'TLeWithIncomingPageLinksOriginLabelViewModel classTrait + TLeSnippetElement classTrait',
	#category : #'Lepiter-UI-IncomingReferences-! Views'
}

{ #category : #initialization }
LeIncomingPageLinksOriginLabelElement >> initialize [
	super initialize.
	
	self aptitude: (BrGlamorousLabelAptitude new tightMeasurement foreground: Color gray)
]

{ #category : #'api - incoming page links origin label view model' }
LeIncomingPageLinksOriginLabelElement >> onIncomingPageLinksOriginLabelViewModelChanged [
	"Is sent when a new incomingPageLinksOriginLabel view model is assigned to the element"
	
	self text: self incomingPageLinksOriginLabelViewModel displayLabel
]

{ #category : #'api - snippet view model' }
LeIncomingPageLinksOriginLabelElement >> snippetViewModel [
	"Return a not-null Snippet view model assigned to the receiver element"

	^ self incomingPageLinksOriginLabelViewModel
]

{ #category : #'api - snippet view model' }
LeIncomingPageLinksOriginLabelElement >> snippetViewModel: aSnippetViewModel [
	"Set a not-null Snippet view model assigned to the receiver element"
	
	self incomingPageLinksOriginLabelViewModel: aSnippetViewModel
]
