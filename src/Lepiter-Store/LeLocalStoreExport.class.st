Class {
	#name : #LeLocalStoreExport,
	#superclass : #LeLocalStore,
	#category : 'Lepiter-Store-LocalJSON-Store'
}

{ #category : #'api - exporting' }
LeLocalStoreExport >> export [
	"Export all the pages in the receiver's database to the localRoot directory"

	database pages do: [ :page |
		self exportPage: page ].
	self updateProperty: #schema value: storage class currentVersionString.
]

{ #category : #'api - exporting' }
LeLocalStoreExport >> export: aLeDatabase to: aDirectory [

	^ self
		database: aLeDatabase;
		localRoot: aDirectory;
		export
]

{ #category : #'api - exporting' }
LeLocalStoreExport >> exportPage: page [
	"Export the supplied page to localRoot"

	storage savePage: page in: localRoot
]

{ #category : #'api - exporting' }
LeLocalStoreExport >> localRoot: aFileReference [
	"Set the localRoot for the storage, which will be created.
	The supplied file reference must not exist, but its parent must."

	super localRoot: aFileReference.
	self assert: localRoot exists not.
	self assert: localRoot parent isDirectory.
	localRoot ensureCreateDirectory.
]
