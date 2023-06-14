Class {
	#name : #LeStoreAttachmentReader,
	#superclass : #Object,
	#instVars : [
		'database',
		'reader',
		'attachmentName'
	],
	#category : 'Lepiter-Store-Attachments'
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
	| aFile aContent |
	self hasMonitor ifFalse: [ ^ self ].
	self attachmentName ifNil: [ ^ self ].
		
	aFile := self database resolveDbFile: self attachmentName.
	aFile exists ifFalse: [ ^ self ].
	
	aContent := aFile readStreamEncoded: #utf8 do: [ :aStream | aStream contents ].
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
