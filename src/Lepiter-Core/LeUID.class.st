"
LeUID is the model for Lepiter's model IDs.

LeUID initialises a UUID on creation, however this may be overwritten, mostly for controlled examples.
"
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
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ uid = anObject uid
]

{ #category : #accessing }
LeUID >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		items: [ {
			('LeUID/UUID Base64' -> self printString).
			('LeUID/UUID String' -> self uid asString).
			('LeUID/UUID Base36' -> self uid asString36).
			('LeUID/UUID Raw' -> self uid) } ];
		column: 'Key' text: #key;
		column: 'Value' text: #value;
		send: #value
]

{ #category : #'api - testing' }
LeUID >> hasUidString: aString64 [

	self deprecated: '= should be used, less space and CPU required'.

	^ uid isNotNil and: [
		 aString64 = uid base64Encoded ]
]

{ #category : #comparing }
LeUID >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ uid hash
]

{ #category : #accessing }
LeUID >> initialize [

	super initialize.
	uid := UUID new.
]

{ #category : #printing }
LeUID >> printOn: aStream [

	uid ifNil: [ ^ super printOn: aStream ].
	aStream << uid base64Encoded.
]

{ #category : #accessing }
LeUID >> uid [
	^ uid
]

{ #category : #accessing }
LeUID >> uid: aUUID [
	uid := aUUID
]

{ #category : #'api - accessing' }
LeUID >> uidString [ 

	^ uid base64Encoded
]

{ #category : #accessing }
LeUID >> uidString: aString64 [

	uid := UUID fromBase64EncodedString: aString64
]
