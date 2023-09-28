Class {
	#name : #LeLocalAttachmentAlreadyExist,
	#superclass : #Error,
	#instVars : [
		'basename',
		'uuid'
	],
	#category : #'Lepiter-Store-LocalJSON-Store'
}

{ #category : #accessing }
LeLocalAttachmentAlreadyExist >> basename [
	<return: #String>
	^ basename
]

{ #category : #accessing }
LeLocalAttachmentAlreadyExist >> basename: aString [
	basename := aString
]

{ #category : #accessing }
LeLocalAttachmentAlreadyExist >> messageText [
	^ self messageText
		ifEmpty: [ messageText := String
					streamContents: [ :aStream | 
						aStream nextPutAll: 'Attachment already exist: '.
						aStream nextPutAll: uuid asString.
						aStream nextPut: $/.
						aStream nextPutAll: basename asString.
						aStream nextPutAll: '.' ] ]
]

{ #category : #accessing }
LeLocalAttachmentAlreadyExist >> uuid [
	<return: #String>
	^ uuid
]

{ #category : #accessing }
LeLocalAttachmentAlreadyExist >> uuid: aString [
	uuid := aString
]
