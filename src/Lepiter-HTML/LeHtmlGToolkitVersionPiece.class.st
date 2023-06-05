Class {
	#name : #LeHtmlGToolkitVersionPiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #'api - writing' }
LeHtmlGToolkitVersionPiece >> writeWithContext: aContext [
	| aVersion |
	aVersion := GtImage version versionString.
	
	aContext html escape: aVersion
]
