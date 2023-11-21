"
I am LePageZipArchiveExporter.

I export a single LePage into a .lepiter.zip archive so that it can be stored outside a database and be shared between users.

The archive will contain the original .lepiter file with all attachments that it refers to.

See LePageZipArchiveImporter for the inverse operation.
"
Class {
	#name : #LePageZipArchiveExporter,
	#superclass : #Object,
	#instVars : [
		'page',
		'directory'
	],
	#category : #'Lepiter-Zip-Archive'
}

{ #category : #accessing }
LePageZipArchiveExporter >> attachmentsDirectory [
	^ (self exportDirectory / 'attachments') ensureCreateDirectory
]

{ #category : #operations }
LePageZipArchiveExporter >> createZipArchive [
	| zipArchive |
	zipArchive := ZipArchive new.
	self exportDirectory allChildren do: [ :each | | zipName |
		zipName := (each relativeTo: self exportDirectory parent) pathString.
		each isDirectory
			ifTrue: [ zipArchive addDirectory: each as: zipName ]
			ifFalse: [ zipArchive addFile: each as: zipName ] ].
	zipArchive writeToFile: self zipFile.
	^ zipArchive
]

{ #category : #accessing }
LePageZipArchiveExporter >> directory [
	^ directory
		ifNil: [ directory := (FileReference newTempFilePrefix: 'gt-tmp-' suffix: '-dir')
					ensureCreateDirectory ]
]

{ #category : #accessing }
LePageZipArchiveExporter >> directory: anObject [
	directory := anObject
]

{ #category : #operations }
LePageZipArchiveExporter >> export [
	self assert: self page notNil.
	self exportFiles.
	self createZipArchive
]

{ #category : #accessing }
LePageZipArchiveExporter >> exportDirectory [
	^ (self directory / self exportTitle) ensureCreateDirectory
]

{ #category : #operations }
LePageZipArchiveExporter >> exportFiles [
	self lepiterFile copyTo: self exportDirectory / self lepiterFile basename.
	page attachments get items do: [ :each | | id file |
		id := ($/ split: each name) second. 
		file := each fileReference.
		(self attachmentsDirectory / id) ensureCreateDirectory.
		file copyTo: self attachmentsDirectory / id / file basename ]
]

{ #category : #accessing }
LePageZipArchiveExporter >> exportTitle [
	| titlePrefix | 
	titlePrefix := ((page title
		collect: [ :each | each isAlphaNumeric ifTrue: [ each asLowercase ] ifFalse: [ $- ] ])
		first: (page title size min: 32)).
	^ titlePrefix , '-' , page uid asString36
]

{ #category : #accessing }
LePageZipArchiveExporter >> gtCopyZipArchivePathFor: aView [
	<gtAction>
	^ aView button
		tooltip: 'Copy ZIP archive path';
		priority: 5;
		icon: BrGlamorousIcons folder;
		action: [ :aButton | Clipboard clipboardText: self zipFile pathString ]
]

{ #category : #accessing }
LePageZipArchiveExporter >> gtFilesFor: aView [
	<gtView>
	self page ifNil: [ aView empty ].
	^ aView forward
		title: 'Files';
		object: [ self directory ];
		view: #gtItemsFor:
]

{ #category : #accessing }
LePageZipArchiveExporter >> lepiterFile [
	^ page database monitor pageFileReference: page
]

{ #category : #accessing }
LePageZipArchiveExporter >> page [
	^ page
]

{ #category : #accessing }
LePageZipArchiveExporter >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LePageZipArchiveExporter >> zipFile [
	^ self directory / self exportTitle , 'lepiter' , 'zip'
]
