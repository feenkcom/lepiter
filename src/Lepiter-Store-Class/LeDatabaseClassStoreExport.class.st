Class {
	#name : #LeDatabaseClassStoreExport,
	#superclass : #LeDatabaseClassStore,
	#category : #'Lepiter-Store-Class-Model'
}

{ #category : #'api - exporting' }
LeDatabaseClassStoreExport >> export [
	"Export all the pages in the receiver's database to the localRoot directory"

	database pages do: [ :page |
		self exportPage: page ].
	self updateProperty: #schema value: storage class currentVersionString.
]

{ #category : #'api - exporting' }
LeDatabaseClassStoreExport >> exportPage: aLePage [

	storage savePage: aLePage inClass: dbClass
]
