Class {
	#name : #LeStoreAttachmentReader,
	#superclass : #Object,
	#instVars : [
		'database',
		'reader',
		'attachmentName',
		'isBinaryContent'
	],
	#category : #'Lepiter-Store-Attachments'
}

{ #category : #'api - accessing' }
LeStoreAttachmentReader >> attachmentName [
	^ attachmentName
]

{ #category : #'api - accessing' }
LeStoreAttachmentReader >> attachmentName: anObject [
	attachmentName := anObject
]

{ #category : #'api - accessing' }
LeStoreAttachmentReader >> database [
	^ database
]

{ #category : #'api - accessing' }
LeStoreAttachmentReader >> database: anObject [
	database := anObject
]

{ #category : #'private - testing' }
LeStoreAttachmentReader >> hasMonitor [
	^ self database isDatabase and: [ 
		self database monitor isNotNil ]
]

{ #category : #'api - storage' }
LeStoreAttachmentReader >> read [
	"read an attachment content and return its content"

	<return: #Object>
	| aContent |
	self hasMonitor ifFalse: [ ^ self ].
	self attachmentName ifNil: [ ^ self ].

	self database
		attachmentBinaryStream: self attachmentName
		do: [ :stream | aContent := stream contents ].

	^ self reader value: aContent
]

{ #category : #'api - accessing' }
LeStoreAttachmentReader >> reader [
	^ reader
]

{ #category : #'api - accessing' }
LeStoreAttachmentReader >> reader: aValuable [
	reader := aValuable
]
