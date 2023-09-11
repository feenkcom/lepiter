Class {
	#name : #LeHtmlDatePiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #accessing }
LeHtmlDatePiece >> writeWithContext: aContext [
	
	aContext html escape: aContext date asString
]
