Class {
	#name : #LeHtmlHelloWorldPiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #'api - writing' }
LeHtmlHelloWorldPiece >> writeWithContext: aContext [
	aContext html inlineTag: #h1 with: 'Hello World'
]
