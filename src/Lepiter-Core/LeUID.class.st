Class {
	#name : #LeUID,
	#superclass : #LeModel,
	#instVars : [
		'uid'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #comparing }
LeUID >> = anObject [
	^ self class = anObject class and: [ 
		self uid = anObject uid ]
]

{ #category : #'api - testing' }
LeUID >> hasUID: aUID [
	^ self uid isNotNil and: [
		 aUID = self uid ]
]

{ #category : #comparing }
LeUID >> hash [
	^ self class hash bitXor: self uid hash
]

{ #category : #printing }
LeUID >> printOn: aStream [
	self uid ifNil: [ ^ super printOn: aStream ].
	aStream nextPutAll: self uid asString.
]

{ #category : #accessing }
LeUID >> uid [
	^ uid
]

{ #category : #accessing }
LeUID >> uid: anObject [
	uid := anObject
]
