Class {
	#name : #LeHtmlPageTitlePiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #'api - writing' }
LeHtmlPageTitlePiece >> writeWithContext: aContext [
	aContext page ifNotNil: [ :aPage | 
		aContext html escape: aPage title ]
]
