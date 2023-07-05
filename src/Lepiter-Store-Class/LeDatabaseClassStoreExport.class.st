Class {
	#name : #LeDatabaseClassStoreExport,
	#superclass : #LeDatabaseClassStore,
	#category : #'Lepiter-Store-Class-Model'
}

{ #category : #'api - exporting' }
LeDatabaseClassStoreExport >> export [
	"Export all the pages in the receiver's database to the receiver's dbClass.
	#exportAttachments assumes that the source database is disk based."

	database pages do: [ :page |
		self exportPage: page ].
	database hasMonitor ifTrue:
		[ self exportAttachments.
		self exportProperties ].
	self updateProperty: #schema value: storage class currentVersionString.
]

{ #category : #'api - exporting' }
LeDatabaseClassStoreExport >> exportAttachments [

	database attachmentDirectories do: [ :dir |
		| properties fileName file |
		self assert: dir children size = 2.
		properties := LeAttachment loadFrom: dir / LeAttachment basename.
		fileName := (dir childNames asSet remove: LeAttachment basename; yourself) anyOne.
		file := dir / fileName.
		storage
			saveAttachment: file binaryContents
			inClass: dbClass
			selector: (storage attachmentSelectorFor: dir basename)
			title: fileName
			classified: 'attachments'
			metadata: properties ].
]

{ #category : #'api - exporting' }
LeDatabaseClassStoreExport >> exportPage: aLePage [

	storage savePage: aLePage inClass: dbClass
]

{ #category : #private }
LeDatabaseClassStoreExport >> exportProperties [

	self savePropertiesDictionary: database properties dbProperties.
]
