Class {
	#name : #LeLocalJsonV4Storage,
	#superclass : #LeLocalStorage,
	#category : #'Lepiter-Store-LocalJSON-Store'
}

{ #category : #versions }
LeLocalJsonV4Storage class >> currentVersion [ 

	^ LeDbVersion fromString: self currentVersionString
]

{ #category : #versions }
LeLocalJsonV4Storage class >> currentVersionString [
	"Answer the string representation of the current version number"

	^ '4.1'
]

{ #category : #accessing }
LeLocalJsonV4Storage >> dbFileExtension [

	^ '.lepiter'
]

{ #category : #'schema updating' }
LeLocalJsonV4Storage >> dbFilesAllVersionsIn: aDirectory [
	"Answer all the db files in the supplied directory, including those from previous storage versions, i.e. V4.*"

	^ aDirectory childrenMatching: '*.lepiter;*.json;*.links'
]

{ #category : #enumerating }
LeLocalJsonV4Storage >> dbFilesIn: aDirectory [

	^ aDirectory childrenMatching: '*.lepiter'
]

{ #category : #enumerating }
LeLocalJsonV4Storage >> explicitLinksFileOrNilIn: aDirectory [
	self withExplicitLinksFileIn: aDirectory do: [ :aFile | ^ aFile].
	^ nil
]

{ #category : #loading }
LeLocalJsonV4Storage >> loadFromFile: aFileReference [
	| originalException result |

	result := [ aFileReference readStreamDo: [ :stream |
			LeJsonV4 uniqueInstance deserialize: stream ] ]
				on: NeoJSONParseError 
				do: [ :ex |
					originalException := ex.
					nil ].
	originalException ifNotNil:
		[ | corruptFileReference loadError |
		corruptFileReference := (aFileReference withExtension: 'corrupt') nextVersion.
		UIManager default inform: 'Lepiter: Unable to load: ', aFileReference basename, ' in ', aFileReference parent fullName, ' due to a JSON parser error'.
		aFileReference resolve renameTo: corruptFileReference basename.
		loadError := LeDBLoadError new.
			loadError properties at: #fileReference put: corruptFileReference.
			loadError
				reason: 'JSON Parse Error';
				originalException: originalException.
		loadError signal ].
	^ result
]

{ #category : #saving }
LeLocalJsonV4Storage >> serialize: anObject on: aStream prettyPrint: aBoolean [

	LeJsonV4 uniqueInstance serialize: anObject on: aStream prettyPrint: aBoolean
]

{ #category : #'schema updating' }
LeLocalJsonV4Storage >> updateDatabasePropertiesNameIn: rootDirectory [
	"Update the database properties file.
	Since we haven't read it yet, we don't know what the current version is, so this must update from any previous version to the current one."
	| propertiesFile oldFile |

	propertiesFile := rootDirectory / LepiterCoreDefaults databasePropertiesBasename.
	propertiesFile exists ifTrue: [ ^ self ].

	"V3.2 and earlier used `db.properties`"
	oldFile := rootDirectory / 'db.properties'.
	oldFile exists ifTrue: 
		[ oldFile copyTo: propertiesFile.
		oldFile renameTo: 'db.properties.bak'.
		^ self ].

	"Must be a new directory"
	^ self
]

{ #category : #'schema updating' }
LeLocalJsonV4Storage >> updateDbStore: store [
	"Update the store to the latest minor version."
	| storeVersion currentVersion updateVersion v33Updater |

	self updateDatabasePropertiesNameIn: store localRoot.
	storeVersion := store dbSchema.
	currentVersion := self class currentVersion.

	storeVersion = currentVersion ifTrue: [ ^ self ].
	storeVersion > currentVersion ifTrue: 
		[ self error: 'On-disk format newer than receiver' ].

	storeVersion major = 3 ifTrue: 
		[ LeLocalJsonV3Storage new updateDbStore: store.
		storeVersion := store dbSchema ].

	"V3.3 shouldn't have been used at all, but was.  Allow for those few cases by re-running the 3.3 upgrade.
	This code can be removed when support for V3 is dropped."
	storeVersion major = 3 ifTrue: 
		[ self assert: storeVersion minor equals: 3.
		v33Updater := LeLocalJsonV3Storage new.
		(self dbFilesAllVersionsIn: store localRoot) do: [ :file |
			v33Updater updateFile: file from: storeVersion ].
		storeVersion := LeDbVersion major: 4 minor: 0.
		 ].

	"Update the entire database one version at a time to allow for file renames, etc."
	updateVersion := storeVersion.
	[ updateVersion < currentVersion ] whileTrue:
		[ 
			(self dbFilesAllVersionsIn: store localRoot) do: [ :file |
				self updateFile: file from: updateVersion ].
			updateVersion := (LeJsonV4SchemaUpdater updaterFor: updateVersion minor) class updatedVersion ].
	store dbSchema: updateVersion.
]

{ #category : #'schema updating' }
LeLocalJsonV4Storage >> updateFile: file from: oldVersion [
	"If the supplied file is at the oldVersion, update it to the next version"
	| extension updater jsonObject version backup newFileReference |

	jsonObject := self loadJsonFrom: file.
	version := LeDbVersion fromString: (jsonObject at: #'__schema').
	version > oldVersion ifTrue: [ ^ self ].

	updater := LeJsonV4SchemaUpdater updaterFor: oldVersion minor.
	extension := file extension.
	extension = #lepiter ifTrue:
		[ updater update: jsonObject ]
	ifFalse: [ extension = #links ifTrue:
		[ updater updateLinks: jsonObject ]
	ifFalse: [ self error: 'Unknown file type: ', extension ] ].
	newFileReference := updater fileReferenceFor: jsonObject named: file.

	backup := file withExtension: (version asString, 'bak').
	backup ensureDelete.
	"Rename of FileLocators seems to always update the receiver, which we don't want.
	Be conservative and always resolve and copy the file reference to avoid updating the original."
	file resolve copy renameTo: backup basename.
	self write: jsonObject toJsonFile: newFileReference.

]

{ #category : #enumerating }
LeLocalJsonV4Storage >> withExplicitLinksFileIn: aDirectory do: aBlock [
	| linksFiles |
	linksFiles := aDirectory childrenMatching: '*.lepiter.links'.
	linksFiles ifEmpty: [ ^ nil ].
	self assert: [ linksFiles size = 1 ].
	^ aBlock value: linksFiles first
]
