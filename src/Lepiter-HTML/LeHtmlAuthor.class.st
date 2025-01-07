Class {
	#name : #LeHtmlAuthor,
	#superclass : #Object,
	#traits : 'TLeHtmlAuthor',
	#classTraits : 'TLeHtmlAuthor classTrait',
	#instVars : [
		'name'
	],
	#category : #'Lepiter-HTML-Support'
}

{ #category : #accessing }
LeHtmlAuthor >> name [
	^ name
]

{ #category : #accessing }
LeHtmlAuthor >> name: anObject [
	name := anObject
]

{ #category : #printing }
LeHtmlAuthor >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self name asString;
		nextPut: $)
]

{ #category : #'api - writing' }
LeHtmlAuthor >> writeWithContext: aContext [
	"Write the HTML output using a context html stream.
	Called by LeHtmlAuthorPiece>>#writeWithContext:."
	
	self name ifNotNil: [ :aString |
		aContext html escape: aString asString ]
]
