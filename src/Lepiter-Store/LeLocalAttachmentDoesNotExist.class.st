Class {
	#name : #LeLocalAttachmentDoesNotExist,
	#superclass : #Error,
	#instVars : [
		'uuid'
	],
	#category : #'Lepiter-Store-LocalJSON-Store'
}

{ #category : #accessing }
LeLocalAttachmentDoesNotExist >> messageText [
	^ self messageText
		ifEmpty: [ messageText := String
					streamContents: [ :aStream | 
						aStream nextPutAll: 'Attachment does not exist: '.
						aStream nextPutAll: uuid asString ] ]
]

{ #category : #accessing }
LeLocalAttachmentDoesNotExist >> uuid [
	<return: #String>
	^ uuid
]

{ #category : #accessing }
LeLocalAttachmentDoesNotExist >> uuid: aString [
	uuid := aString
]
