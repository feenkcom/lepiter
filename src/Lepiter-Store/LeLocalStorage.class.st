"
LeLocalStorage is responsible for: 

- writing pages to the database
- loading pages from the database
- updating pages for changes within a schema version 

The database is a directory containing a page per file, with `db.properties` containing database attributes such as the schema version, user email, etc.


"
Class {
	#name : #LeLocalStorage,
	#superclass : #Object,
	#category : #'Lepiter-Store-LocalJSON-Store'
}

{ #category : #accessing }
LeLocalStorage >> dbFileExtension [

	self subclassResponsibility 
]

{ #category : #enumerating }
LeLocalStorage >> dbFilesIn: aDirectory [

	self subclassResponsibility 
]

{ #category : #loading }
LeLocalStorage >> loadFromFile: aFileReference [

	self subclassResponsibility 
]

{ #category : #'schema updating' }
LeLocalStorage >> loadJsonFrom: aFileReference [
	"Load the JSON object from the supplied file, without any interpretation of the contents, but keeping the attribute order"

	^ aFileReference readStreamDo: [ :stream |
		(NeoJSONReader new on: stream) 
			mapClass: OrderedDictionary;
			next ].

]

{ #category : #accessing }
LeLocalStorage >> pageFilename: aPage [
	"Answer the filename where aPage is stored"

	^ self pageFilenameForUid: aPage uid
]

{ #category : #accessing }
LeLocalStorage >> pageFilenameForUid: aPageUid [
	"Answer the filename where the page with the given id is stored"

	^ aPageUid asString36, self dbFileExtension
]

{ #category : #saving }
LeLocalStorage >> saveExplicitLinksAsPage: aPage in: aDirectory [
	"Write the supplied page back to the local store"
	| pageFile |
	self assert: [ aPage uid notNil ].
	
	pageFile := (aDirectory / ((self pageFilename: aPage), '.links')) resolve.
	self savePage: aPage inFile: pageFile
]

{ #category : #saving }
LeLocalStorage >> savePage: aPage in: aDirectory [
	"Write the supplied page back to the local store"
	| pageFile |

	pageFile := (aDirectory / (self pageFilename: aPage)) resolve.
	self savePage: aPage inFile: pageFile
]

{ #category : #saving }
LeLocalStorage >> savePage: aPage inFile: aPageFile [
	"Write the supplied page back to the local store"
	| backup |

	"It should be possible to truncate the write stream to what's been written (so that over-writing a shorter file doesn't leave garbage at the end), but that appears to corrupt the file.
	Taking a backup is safer anyway."
	aPageFile exists ifTrue:
		[ backup := aPageFile withExtension: 'bak'.
		backup ensureDelete.
		aPageFile copy renameTo: backup basename ].
	aPageFile writeStreamDo: [ :stream |
		[ self serialize: aPage on: (ZnNewLineWriterStream on: stream) prettyPrint: true ] ifCurtailed:
			[ Stdio stdout
				<< 'ERROR: Save to: ';
				<< aPageFile fullName;
				<< ' curtailed';
				lf; flush.
			self error: 'Lepiter DB page save curtailed' ] ].
	LeReloadOptimization ifEnabled: [
		aPage storageHash: (LeBinaryContentsHash fromFileReference: aPageFile) ].
	LeLocalStoreSignal new
		pageTitle: aPage title;
		operation: #save;
		emit.
]

{ #category : #saving }
LeLocalStorage >> serialize: aPage on: aStream prettyPrint: aBoolean [

	self subclassResponsibility 
]

{ #category : #accessing }
LeLocalStorage >> titleFilename: aString [
	"Answer the filename string used to store the supplied page title.
	This is the sha256 hash of the page's title."

	self error: '#titleFilename:'.
	^ (SHA256 hashMessage: aString) hex, self dbFileExtension
]

{ #category : #'schema updating' }
LeLocalStorage >> updateDbStore: store [
	"Update the store to the latest minor version.
	Subclasses should overwrite with the appropriate action."
]

{ #category : #enumerating }
LeLocalStorage >> withExplicitLinksFileIn: aRootFolder do: aBlock [
	"Override if the storage provides support for explicit links."
	^ nil
]

{ #category : #'schema updating' }
LeLocalStorage >> write: jsonObject toJsonFile: aFileReference [
	"Write the supplied JSON object to the given file."

	aFileReference writeStreamDo: [ :stream |
		(NeoJSONWriter on: (ZnNewLineWriterStream on: stream)) 
			newLine: Character cr asString;
			prettyPrint: true;
			nextPut: jsonObject ].
]
