Class {
	#name : #LeDatabaseClassStore,
	#superclass : #LeDatabaseStore,
	#instVars : [
		'dbClass'
	],
	#category : #'Lepiter-Store-Class-Model'
}

{ #category : #'instance creation' }
LeDatabaseClassStore class >> forJsonV4 [
	"Answer an instance of the receiver with JSON V4 storage format"

	^ self new storage: LeDatabaseClassJsonV4Storage new
]

{ #category : #attachments }
LeDatabaseClassStore >> addAttachmentByCopy: aFileReference [
	"Copy the attached file to the receiver's DB and answer the string identifying the attachment"
	<return: #String>
	| attachmentUUID metadata |

	attachmentUUID := UUID new asString36.
	metadata := LeAttachment new uploadDate: DateAndTime now.
	self savePersonalInformation ifTrue:
		[ metadata
			originalReference: aFileReference asFileReference;
			uploadedBy: self userEmail ].
	storage
		saveAttachment: aFileReference binaryContents 
		inClass: dbClass 
		selector: ('attachment_', attachmentUUID) asSymbol
		title: aFileReference basename
		classified: 'attachments'
		metadata: metadata.
	^ attachmentUUID
]

{ #category : #attachments }
LeDatabaseClassStore >> addAttachmentByMove: aFileReference [
	"Move the attached file to the receiver's DB and answer a string identifying the attachment"

	self error: 'LeDatabaseClassStore is unable to reference external files'
]

{ #category : #attachments }
LeDatabaseClassStore >> addAttachmentWithContent: aString named: aName [
	"Copy the attached file to the receiver's DB and answer the string identifying the attachment"
	<return: #String>
	| attachmentUUID metadata |

	attachmentUUID := UUID new asString36.
	metadata := LeAttachment new uploadDate: DateAndTime now.
	self savePersonalInformation ifTrue:
		[ metadata
			originalReference: aName asFileReference;
			uploadedBy: self userEmail ].
	storage
		saveAttachment: aString utf8Encoded
		inClass: dbClass 
		selector: ('attachment_', attachmentUUID) asSymbol
		title: aName
		classified: 'attachments'
		metadata: metadata.
	^ attachmentUUID
]

{ #category : #attachments }
LeDatabaseClassStore >> attachmentBinaryStream: attachmentId do: aBlock [
	"Answer a stream on the binary contents of the supplied attachment path"

	^ aBlock value: (storage loadAttachmentFromMethod: (dbClass class >> (storage attachmentSelectorFor: attachmentId))) readStream
]

{ #category : #accessing }
LeDatabaseClassStore >> attachmentIds [

	^ storage attachmentIdsFor: dbClass
]

{ #category : #attachments }
LeDatabaseClassStore >> attachmentUtf8Stream: attachmentId do: aBlock [
	"Answer a stream on the binary contents of the supplied attachment path"

	^ aBlock value: (ZnCharacterReadStream on: (storage loadAttachmentFromMethod: (dbClass class >> (storage attachmentSelectorFor: attachmentId))) readStream encoding: 'utf-8')
]

{ #category : #accessing }
LeDatabaseClassStore >> dbClass [
	^ dbClass
]

{ #category : #accessing }
LeDatabaseClassStore >> dbClass: anObject [
	dbClass := anObject
]

{ #category : #accessing }
LeDatabaseClassStore >> dbClassName [

	^ dbClass name
]

{ #category : #accessing }
LeDatabaseClassStore >> dbClassName: aSymbol package: packageName [

	self assert: [ dbClass isNil ]
		description: 'Renaming the DB class store is not supported'.

	dbClass := self class environment
		at: aSymbol
		ifPresent: [ :aClass | aClass ]
		ifAbsent: 
			[ Object subclass: aSymbol
				instanceVariableNames: '' 
				classVariableNames: ''
				package: packageName ]
]

{ #category : #'accessing - db properties' }
LeDatabaseClassStore >> defaultDatabaseName [
	"Answer the name to be used if one hasn't been explicitly set"
	<return: #String>

	^ self dbClassName
]

{ #category : #'accessing - db properties' }
LeDatabaseClassStore >> loadPropertiesDictionary [
	"Answer the lepiter properties dictionary"

	^ [ storage loadFromMethod: dbClass class >> #databaseProperties ]
		on: KeyNotFound
		do: [ :ex | Dictionary new ]
]

{ #category : #'accessing - db properties' }
LeDatabaseClassStore >> preloadScript [
	<return: #FileReference or: nil>

	^ nil
	"^ self dbProperties at: #preloadScript 
		ifPresent: [ :aString | self fileReferenceFrom: aString ]
		ifAbsent: [ nil ]"
]

{ #category : #private }
LeDatabaseClassStore >> reloadPage: aLePage [

	^ storage loadFromMethod: (dbClass class >> (storage pageSelectorFor: aLePage))
]

{ #category : #private }
LeDatabaseClassStore >> savePageNow: aLePage [

	storage
		savePage: aLePage
		inClass: dbClass
]

{ #category : #'accessing - db properties' }
LeDatabaseClassStore >> savePropertiesDictionary: propertiesDictionary [

	storage
		save: propertiesDictionary
		inClass: dbClass
		selector: #databaseProperties
		title: 'Database Properties'
		classified: 'properties'
]
