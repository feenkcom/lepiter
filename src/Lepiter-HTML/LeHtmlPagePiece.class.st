Class {
	#name : #LeHtmlPagePiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #'api - writing' }
LeHtmlPagePiece >> writeWithContext: aContext [
	aContext page ifNotNil: [ :aPage | 
		| visitor |
		visitor := LeHtmlVisitor new.
		visitor context: aContext.
		aPage acceptVisitor: visitor ]
]
