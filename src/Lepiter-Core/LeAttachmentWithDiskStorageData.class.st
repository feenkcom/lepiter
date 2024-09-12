Class {
	#name : #LeAttachmentWithDiskStorageData,
	#superclass : #LeAttachmentWithData,
	#instVars : [
		'attachmentPath'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #'instance creation' }
LeAttachmentWithDiskStorageData class >> fromDirectory: aDirectory inDatabase: aDatabase [
	^ self new  
		initializeFromDirectory: aDirectory inDatabase: aDatabase
]

{ #category : #accessing }
LeAttachmentWithDiskStorageData >> attachmentName [
	^ self attachmentPath
]

{ #category : #accessing }
LeAttachmentWithDiskStorageData >> attachmentPath [
	^ attachmentPath
]

{ #category : #accessing }
LeAttachmentWithDiskStorageData >> attachmentPath: aPathString [
	attachmentPath := aPathString
]

{ #category : #accessing }
LeAttachmentWithDiskStorageData >> attachmentReference [
	self attachmentPath ifNil: [ ^ nil ].
	
	^ database attachmentsDirectory  / (self attachmentPath 
		removePrefix: 'attachments/')
]

{ #category : #ui }
LeAttachmentWithDiskStorageData >> createPictureWidget [
	| attachmentReference  |
	attachmentReference := self attachmentReference.
	
	^ BrAsyncFileWidget new 
		file:  attachmentReference 
]

{ #category : #printing }
LeAttachmentWithDiskStorageData >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	
	aStream parenthesize: [
		aStream 
			<< self id;
			<< ', '.
		self attachmentPath 
			ifNil: [
				aStream << self metadata fileNameDescription]
			ifNotNil: [ 
				aStream << self attachmentPath]]
]

{ #category : #'gt - extensions' }
LeAttachmentWithDiskStorageData >> gtFigureFor: aView [
	<gtView>
	| originalExtension |
	originalExtension := self originalExtension.
	originalExtension ifNil: [ ^ aView empty ].
	(ImageReadWriter allTypicalFileExtensions includes: originalExtension asLowercase)
		ifFalse: [ ^ aView empty ].

	^ aView explicit
		title: 'Picture';
		priority: 10;
		stencil: [ self createPictureWidget
				margin: (BlInsets all: 10);
				constraintsDo: [ :c | 
					c vertical matchParent.
					c horizontal matchParent ] ]
]

{ #category : #testing }
LeAttachmentWithDiskStorageData >> hasWithDiskStorage [
	^ true
]

{ #category : #initialization }
LeAttachmentWithDiskStorageData >> initializeFromDirectory: aDirectory inDatabase: aDatabase [
	| allFiles |
			
	database := aDatabase.
	id := aDirectory basename.
	metadata := LeAttachment loadFromFolder: aDirectory.
	
	allFiles := aDirectory files select: [ :aFile | 
		aFile basename ~= LeAttachment basename ].
	allFiles size = 1 ifTrue: [
		attachmentPath := (allFiles first 
			relativeTo: aDatabase attachmentsDirectory parent) fullName ].
]

{ #category : #accessing }
LeAttachmentWithDiskStorageData >> originalExtension [
	^ self metadata originalExtension ifNil: [
		self attachmentPath ifNotNil: [ :aString |
			aString copyAfterLast: Path extensionDelimiter ] ]
]
