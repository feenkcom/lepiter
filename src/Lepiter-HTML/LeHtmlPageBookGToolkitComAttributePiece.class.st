Class {
	#name : #LeHtmlPageBookGToolkitComAttributePiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #'api - writing' }
LeHtmlPageBookGToolkitComAttributePiece >> writeWithContext: aContext [
	| anUrl |
	anUrl := 'https://book.gtoolkit.com' asZnUrl 
		/ aContext pageLink fileName.

	aContext html escapeAttributeValue: anUrl asString
]
