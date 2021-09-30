"
An element that represents a snippet. Often a snippet element may be wrapped in other embellishment or decorator elements.

"
Class {
	#name : #LeSnippetElementId,
	#superclass : #BlElementUniqueId,
	#category : 'Lepiter-UI-Snippet-! Views'
}

{ #category : #converting }
LeSnippetElementId >> asSymbol [
	^ #'lepiter--snippet-element'
]
