Class {
	#name : #LePlainTextSnippetElementStencil,
	#superclass : #BrStencil,
	#instVars : [
		'snippetElementClass'
	],
	#category : #'Lepiter-Snippet-Text-Support'
}

{ #category : #'api - instantiation' }
LePlainTextSnippetElementStencil >> basicElement [
	^ self snippetElementClass ifNotNil: #new ifNil: [ GtTextualCoderElement new ]
]

{ #category : #accessing }
LePlainTextSnippetElementStencil >> snippetElementClass [
	^ snippetElementClass
]

{ #category : #accessing }
LePlainTextSnippetElementStencil >> snippetElementClass: anObject [
	snippetElementClass := anObject
]
