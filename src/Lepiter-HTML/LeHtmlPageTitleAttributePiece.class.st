Class {
	#name : #LeHtmlPageTitleAttributePiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #'api - writing' }
LeHtmlPageTitleAttributePiece >> writeWithContext: aContext [
	aContext page ifNotNil: [ :aPage | 
		aContext html escapeAttributeValue: aPage title ]
]
