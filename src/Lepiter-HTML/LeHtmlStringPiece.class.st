Class {
	#name : #LeHtmlStringPiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#instVars : [
		'string'
	],
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #printing }
LeHtmlStringPiece >> gtDisplayOn: stream [
	stream nextPutAll: string asString
]

{ #category : #accessing }
LeHtmlStringPiece >> string [
	^ string
]

{ #category : #accessing }
LeHtmlStringPiece >> string: anObject [
	string := anObject
]

{ #category : #'api - writing' }
LeHtmlStringPiece >> writeWithContext: aContext [
	aContext html escape: string
]
