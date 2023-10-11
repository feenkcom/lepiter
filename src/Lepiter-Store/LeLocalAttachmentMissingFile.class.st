Class {
	#name : #LeLocalAttachmentMissingFile,
	#superclass : #Error,
	#instVars : [
		'uuid',
		'directory'
	],
	#category : #'Lepiter-Store-LocalJSON-Store'
}

{ #category : #accessing }
LeLocalAttachmentMissingFile >> directory [
	^ directory
]

{ #category : #accessing }
LeLocalAttachmentMissingFile >> directory: anObject [
	directory := anObject
]

{ #category : #accessing }
LeLocalAttachmentMissingFile >> messageText [
	^ self messageText
		ifEmpty: [ messageText := String
					streamContents: [ :aStream | 
						aStream nextPutAll: 'Missing attachment file: '.
						aStream nextPutAll: uuid asString.
						aStream nextPutAll: '; '.

						self directory files
							do: [ :aFile | aStream nextPutAll: aFile basename ]
							separatedBy: [ aStream nextPutAll: ', ' ] ] ]
]

{ #category : #accessing }
LeLocalAttachmentMissingFile >> uuid [
	<return: #String>
	^ uuid
]

{ #category : #accessing }
LeLocalAttachmentMissingFile >> uuid: aString [
	uuid := aString
]
