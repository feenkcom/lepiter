Class {
	#name : #LePageResource,
	#superclass : #Object,
	#instVars : [
		'source',
		'name'
	],
	#category : #'Lepiter-HTML-Exporter'
}

{ #category : #comparing }
LePageResource >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ name = anObject label
]

{ #category : #comparing }
LePageResource >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self class hash bitXor: name hash
]

{ #category : #accessing }
LePageResource >> name [
	^ name
]

{ #category : #accessing }
LePageResource >> name: anObject [
	name := anObject
]

{ #category : #printing }
LePageResource >> printOn: aStream [
	super printOn: aStream.
	self name ifNil: [ ^ self ].
	aStream 
		nextPut: $(;
		print: self name;
		nextPut: $)
]

{ #category : #accessing }
LePageResource >> source [
	^ source
]

{ #category : #accessing }
LePageResource >> source: anObject [
	source := anObject
]
