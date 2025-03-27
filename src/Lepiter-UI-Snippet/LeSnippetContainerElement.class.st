"
# Snippet container element
Wraps a {{gtClass:LeSnippetElement}} and adds support for max width to limit how much space a snippet occupies within a page.

"
Class {
	#name : #LeSnippetContainerElement,
	#superclass : #BlElement,
	#traits : 'TLeWithSnippetViewModel + TBrLayoutResizable',
	#classTraits : 'TLeWithSnippetViewModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'snippetElement'
	],
	#category : #'Lepiter-UI-Snippet-! Views'
}

{ #category : #initialization }
LeSnippetContainerElement >> initialize [
	super initialize.
	
	self hMatchParent.
	self vFitContentLimited.
	
	self layout: BlFrameLayout new.
	self clipChildren: false.

	self addAptitude: (BrLayoutResizerAptitude new inherit: [ self snippetElement ])
]

{ #category : #'api - snippet view model' }
LeSnippetContainerElement >> onSnippetViewModelChanged [
	"Is sent when a new snippet view model is assigned to the element.
	Note: #onSnippetViewModelChanged is sent before #subscribeToSnippetViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSnippetViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self snippetElement snippetViewModel: self snippetViewModel
]

{ #category : #accessing }
LeSnippetContainerElement >> snippetElement [
	^ snippetElement
]

{ #category : #accessing }
LeSnippetContainerElement >> snippetElement: anElement [
	snippetElement := anElement.
	self addChild: anElement
]

{ #category : #accessing }
LeSnippetContainerElement >> snippetMaxWidth: aNumber [
	self constraintsDo: [ :c | c maxWidth: aNumber ]
]
