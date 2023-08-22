Class {
	#name : #LeStoreAttachmentWriter,
	#superclass : #Object,
	#instVars : [
		'database',
		'content',
		'contentName',
		'attachmentName',
		'writer'
	],
	#category : #'Lepiter-Store-Attachments'
}

{ #category : #'api - accessing' }
LeStoreAttachmentWriter >> attachmentName [
	^ attachmentName
]

{ #category : #'api - accessing' }
LeStoreAttachmentWriter >> attachmentName: anObject [
	attachmentName := anObject
]

{ #category : #'api - storage' }
LeStoreAttachmentWriter >> binaryContent [
	| aBinaryContent |
	aBinaryContent := self content value.
	aBinaryContent isString ifTrue: [ aBinaryContent := aBinaryContent utf8Encoded ].

	^ aBinaryContent
]

{ #category : #'api - accessing' }
LeStoreAttachmentWriter >> content [
	^ content
]

{ #category : #'api - accessing' }
LeStoreAttachmentWriter >> content: anObject [
	content := anObject
]

{ #category : #'api - accessing' }
LeStoreAttachmentWriter >> contentName [
	^ contentName ifNil: [ contentName := 'content.txt' ]
]

{ #category : #'api - accessing' }
LeStoreAttachmentWriter >> contentName: anObject [
	contentName := anObject
]

{ #category : #'api - accessing' }
LeStoreAttachmentWriter >> database [
	^ database
]

{ #category : #'api - accessing' }
LeStoreAttachmentWriter >> database: anObject [
	database := anObject
]

{ #category : #'private - testing' }
LeStoreAttachmentWriter >> hasMonitor [
	^ self database isDatabase and: [ 
		self database monitor isNotNil ]
]

{ #category : #'api - storage' }
LeStoreAttachmentWriter >> write [
	"Store an attachment content"

	self hasMonitor ifFalse: [ ^ self ].

	self attachmentName
		ifNil: [ attachmentName := self database
					addAttachmentWithContent: self binaryContent
					named: self contentName.
			self writer value: attachmentName ]
		ifNotNil: [ self database
				updateAttachmentNamed: self attachmentName
				content: self binaryContent ]
]

{ #category : #'api - accessing' }
LeStoreAttachmentWriter >> writer [
	^ writer
]

{ #category : #'api - accessing' }
LeStoreAttachmentWriter >> writer: oneArgBlock [
	writer := oneArgBlock
]
