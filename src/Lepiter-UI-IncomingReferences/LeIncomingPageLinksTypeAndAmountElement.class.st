"
I display an amount of references to a page and their type:

{{gtExample:LeIncomingPageLinksTypeAndAmountElementExamples>>#linksTypeAndAmountElement|previewExpanded=true}}

"
Class {
	#name : #LeIncomingPageLinksTypeAndAmountElement,
	#superclass : #BrLabel,
	#traits : 'TLeWithIncomingPageLinksTypeAndAmountViewModel + TLeSnippetElement',
	#classTraits : 'TLeWithIncomingPageLinksTypeAndAmountViewModel classTrait + TLeSnippetElement classTrait',
	#category : #'Lepiter-UI-IncomingReferences-! Views'
}

{ #category : #initialization }
LeIncomingPageLinksTypeAndAmountElement >> initialize [
	super initialize.

	self margin: (BlInsets top: 6).
	self aptitude: (BrGlamorousLabelAptitude new tightMeasurement foreground: Color gray).
	self
		when: BlClickEvent
		do: [ :anEvent |
			anEvent consumed: true.
			anEvent currentTarget phlow spawnTool: self incomingPageLinksTypeAndAmountViewModel asPhlowTool ]
]

{ #category : #'api - incoming page links type and amount view model' }
LeIncomingPageLinksTypeAndAmountElement >> onIncomingPageLinksTypeAndAmountViewModelChanged [
	"Is sent when a new incomingPageLinksTypeAndAmount view model is assigned to the element"
	
	self text: self incomingPageLinksTypeAndAmountViewModel displayLabel
]

{ #category : #'api - snippet view model' }
LeIncomingPageLinksTypeAndAmountElement >> snippetViewModel [
	"Return a not-null Snippet view model assigned to the receiver element"

	^ self incomingPageLinksTypeAndAmountViewModel
]

{ #category : #'api - snippet view model' }
LeIncomingPageLinksTypeAndAmountElement >> snippetViewModel: aSnippetViewModel [
	"Set a not-null Snippet view model assigned to the receiver element"
	
	self incomingPageLinksTypeAndAmountViewModel: aSnippetViewModel
]
