Class {
	#name : #LeHtmlBookPageLink,
	#superclass : #Object,
	#traits : 'TLeHtmlBookPageLink',
	#classTraits : 'TLeHtmlBookPageLink classTrait',
	#instVars : [
		'fileName',
		'id',
		'page'
	],
	#category : #'Lepiter-HTML-Old-Book Helpers'
}

{ #category : #accessing }
LeHtmlBookPageLink >> fileName [
	^ fileName
]

{ #category : #accessing }
LeHtmlBookPageLink >> fileName: aString [
	fileName := aString
]

{ #category : #accessing }
LeHtmlBookPageLink >> id [
	^ id
]

{ #category : #accessing }
LeHtmlBookPageLink >> id: anObject [
	id := anObject
]

{ #category : #accessing }
LeHtmlBookPageLink >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeHtmlBookPageLink >> page: aLePage [
	page := aLePage
]

{ #category : #printing }
LeHtmlBookPageLink >> printOn: aStream [
	super printOn: aStream.

	self page ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self pageTitle asString;
		nextPut: $)
]
