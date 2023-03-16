Extension { #name : #Form }

{ #category : #'*Lepiter-Store' }
Form class >> deSerializeAllImplementorsInstances [
	"Answer a collection of instances to be tested for serialisation / deserialisation"

	^ #()
]

{ #category : #'*Lepiter-Store' }
Form >> height: anObject [
	"Set the receiver's height.
	Only used for deserialisation."

	height := anObject
]

{ #category : #'*Lepiter-Store' }
Form class >> leJsonV4Name [

	^ self = Form
		ifTrue: [ #form ]
		ifFalse: [ ].
]

{ #category : #'*Lepiter-Store' }
Form >> width: anObject [
	"Set the receiver's width.
	Only used for deserialisation."

	width := anObject
]
