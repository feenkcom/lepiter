Class {
	#name : #LeHtmlPageUrlAttributePiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#instVars : [
		'baseUrl'
	],
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #accessing }
LeHtmlPageUrlAttributePiece >> baseUrl [
	^ baseUrl
]

{ #category : #accessing }
LeHtmlPageUrlAttributePiece >> baseUrl: anObject [
	baseUrl := anObject
]

{ #category : #default }
LeHtmlPageUrlAttributePiece >> defaultBaseUrl [
	^ 'https://book.gtoolkit.com' asZnUrl
]

{ #category : #initalize }
LeHtmlPageUrlAttributePiece >> initialize [
	baseUrl := self defaultBaseUrl
]

{ #category : #'api - writing' }
LeHtmlPageUrlAttributePiece >> writeWithContext: aContext [
	| anUrl |
	anUrl := self baseUrl / aContext pageHref.

	aContext html escapeAttributeValue: anUrl asString
]
