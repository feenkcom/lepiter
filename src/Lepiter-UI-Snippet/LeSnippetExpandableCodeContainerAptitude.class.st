Class {
	#name : #LeSnippetExpandableCodeContainerAptitude,
	#superclass : #LeSnippetExpandableWithBarAptitude,
	#instVars : [
		'language'
	],
	#category : 'Lepiter-UI-Snippet-Looks'
}

{ #category : #initialization }
LeSnippetExpandableCodeContainerAptitude >> initialize [
	super initialize.

	language := BlTextElement new text: 'The Language' asRopedText.
	language constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal fitContent. ].
	self addChangeAddChildAs: #(snippetContainer languageLabel) with: [ language ].
]
