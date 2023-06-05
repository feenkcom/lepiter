Class {
	#name : #LeEmail,
	#superclass : #LeModel,
	#instVars : [
		'email'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #accessing }
LeEmail class >> address: aString [

	^ self new email: aString
]

{ #category : #comparing }
LeEmail >> = anObject [
	^ self class = anObject class and: [ 
		self email = anObject email ]
]

{ #category : #'private - asserting' }
LeEmail >> assertEmail: aString [
	self 
		assert: [ aString isNotNil ]
		description: [ 'Email must be non-nil' ].
	self
		assert: [ (aString includes: $@) or: [ aString = '<unknown>' ] ]
		description: [ 'Email must include the "@" character' ]
]

{ #category : #'api - accessing' }
LeEmail >> email [
	<return: #String>
	^ email
]

{ #category : #'api - accessing' }
LeEmail >> email: aString [
	self assertEmail: aString.
	email := aString
]

{ #category : #comparing }
LeEmail >> hash [
	^ self class hash bitXor: self email hash
]

{ #category : #testing }
LeEmail >> isEmail [
	"Answer a boolean indicating if this is an email address"

	^ true
]

{ #category : #printing }
LeEmail >> printOn: aStream [
	self email ifNil: [ ^ super printOn: aStream ].
	aStream nextPutAll: self email asString.
]

{ #category : #printing }
LeEmail >> storeOn: aStream [

	aStream
		nextPut: $(;
		<< self class name;
		<< ' new';
		<< ' instVarNamed: ''email'' put: ';
			<< (self instVarNamed: 'email') storeString;
			<< ';';
		<< ' yourself)'
]
