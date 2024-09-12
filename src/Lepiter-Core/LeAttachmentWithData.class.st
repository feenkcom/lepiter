Class {
	#name : #LeAttachmentWithData,
	#superclass : #Object,
	#instVars : [
		'id',
		'metadata',
		'database'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #accessing }
LeAttachmentWithData >> attachmentName [
	^ self id
]

{ #category : #accessing }
LeAttachmentWithData >> database [
	^ database
]

{ #category : #accessing }
LeAttachmentWithData >> database: aDatabase [
	database := aDatabase
]

{ #category : #testing }
LeAttachmentWithData >> hasWithDiskStorage [
	^ false
]

{ #category : #accessing }
LeAttachmentWithData >> id [
	^ id
]

{ #category : #accessing }
LeAttachmentWithData >> id: anAttachmentId [
	id := anAttachmentId
]

{ #category : #accessing }
LeAttachmentWithData >> metadata [
	^ metadata
]

{ #category : #accessing }
LeAttachmentWithData >> metadata: anAttachmentMetadata [
	metadata := anAttachmentMetadata
]

{ #category : #reading }
LeAttachmentWithData >> readData [
	^ LeStoreAttachmentReader new
		database: self database;
		attachmentName: self attachmentName;
		reader: [ :aBinaryContent | aBinaryContent ];
		read.
]
