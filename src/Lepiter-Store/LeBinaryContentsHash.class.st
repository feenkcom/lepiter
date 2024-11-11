Class {
	#name : #LeBinaryContentsHash,
	#superclass : #Object,
	#instVars : [
		'hex'
	],
	#category : #'Lepiter-Store-LocalJSON-Store'
}

{ #category : #factory }
LeBinaryContentsHash class >> fromFileReference: aFileReference [
	| aByteArray |
	aByteArray := aFileReference binaryReadStreamDo: [ :aStream | 
		(SHA1 hashStream: aStream) ].
	^ self new hex: aByteArray hex
]

{ #category : #comparing }
LeBinaryContentsHash >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	
	^ self class = anObject class 
		and: [ self hex = anObject hex ]
]

{ #category : #printing }
LeBinaryContentsHash >> gtDisplayOn: aStream [
	aStream
		nextPutAll: 'Hash: ';
		nextPutAll: self hex asString
]

{ #category : #comparing }
LeBinaryContentsHash >> hash [
	^ self hex hash
]

{ #category : #accessing }
LeBinaryContentsHash >> hex [
	^ hex
]

{ #category : #accessing }
LeBinaryContentsHash >> hex: anObject [
	hex := anObject
]

{ #category : #testing }
LeBinaryContentsHash >> isSameAsFileReference: aFileReference [
	| anotherHash |
	anotherHash := self class fromFileReference: aFileReference.
	^ self = anotherHash
]

{ #category : #printing }
LeBinaryContentsHash >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self hex asString;
		nextPut: $)
]
