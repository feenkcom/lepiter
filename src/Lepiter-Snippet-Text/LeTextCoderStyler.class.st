Class {
	#name : #LeTextCoderStyler,
	#superclass : #GtCoderAstStyler,
	#instVars : [
		'lepiterStyler'
	],
	#category : #'Lepiter-Snippet-Text-Snippet'
}

{ #category : #accessing }
LeTextCoderStyler >> lepiterStyler [
	^ lepiterStyler
]

{ #category : #accessing }
LeTextCoderStyler >> lepiterStyler: anObject [
	lepiterStyler := anObject
]

{ #category : #'api - styling' }
LeTextCoderStyler >> style: aText ast: theAst [
	lepiterStyler style: aText ast: theAst
]
