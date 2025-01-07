Class {
	#name : #LeHtmlAuthorPiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #'api - writing' }
LeHtmlAuthorPiece >> writeWithContext: aContext [
	aContext author ifNotNil: [ :anAuthor |
		anAuthor writeWithContext: aContext ]
]
