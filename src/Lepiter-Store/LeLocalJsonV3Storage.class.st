Class {
	#name : #LeLocalJsonV3Storage,
	#superclass : #LeLocalStorage,
	#category : 'Lepiter-Store-LocalJSON-Store'
}

{ #category : #versions }
LeLocalJsonV3Storage class >> currentVersion [ 

	^ LeDbVersion fromString: self currentVersionString
]

{ #category : #versions }
LeLocalJsonV3Storage class >> currentVersionString [
	"Answer the string representation of the current version number"

	^ '3.3'
]

{ #category : #accessing }
LeLocalJsonV3Storage >> dbFileExtension [

	^ '.lepiter'
]

{ #category : #'schema updating' }
LeLocalJsonV3Storage >> dbFilesAllVersionsIn: aDirectory [
	"Answer all the db files in the supplied directory, including those from previous storage versions, i.e. V3.*"

	^ aDirectory childrenMatching: '*.lepiter;*.json;*.links'
]

{ #category : #enumerating }
LeLocalJsonV3Storage >> dbFilesIn: aDirectory [

	^ aDirectory childrenMatching: '*.lepiter'
]

{ #category : #enumerating }
LeLocalJsonV3Storage >> explicitLinksFileOrNilIn: aDirectory [
	self withExplicitLinksFileIn: aDirectory do: [ :aFile | ^ aFile].
	^ nil
]

{ #category : #loading }
LeLocalJsonV3Storage >> loadFromFile: aFileReference [

	^ [ aFileReference readStreamDo: [ :stream |
			LeJsonV4 uniqueInstance deserialize: stream ] ]
				on: NeoJSONParseError 
				do: [ :ex | | corruptFileReference loadError |
					corruptFileReference := (aFileReference withExtension: 'corrupt') nextVersion.
					UIManager default inform: 'Lepiter: Unable to load: ', aFileReference basename, ' in ', aFileReference parent fullName, ' due to a JSON parser error'.
					aFileReference resolve renameTo: corruptFileReference basename.
					loadError := LeDBLoadError new 
						fileReference: corruptFileReference;
						reason: 'JSON Parse Error';
						originalException: ex.
					loadError signal ]
]

{ #category : #saving }
LeLocalJsonV3Storage >> serialize: anObject on: aStream prettyPrint: aBoolean [

	LeJsonV3 uniqueInstance serialize: anObject on: aStream prettyPrint: aBoolean
]

{ #category : #'schema updating' }
LeLocalJsonV3Storage >> updateDatabasePropertiesNameIn: rootDirectory [
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

	self error: 'Unable to update database properties file'.
]

{ #category : #'schema updating' }
LeLocalJsonV3Storage >> updateDbStore: store [
	"Update the store to the latest minor version."
	| storeVersion currentVersion updateVersion |

	self updateDatabasePropertiesNameIn: store localRoot.
	storeVersion := store dbSchema.
	currentVersion := self class currentVersion.

	storeVersion = currentVersion ifTrue: [ ^ self ].
	storeVersion > currentVersion ifTrue: 
		[ self error: 'On-disk format newer than receiver' ].

	"Update the entire database one version at a time to allow for file renames, etc."
	updateVersion := storeVersion.
	[ updateVersion < currentVersion ] whileTrue:
		[ 
			(self dbFilesAllVersionsIn: store localRoot) do: [ :file |
				self updateFile: file from: updateVersion ].
			updateVersion := (LeJsonV3SchemaUpdater updaterFor: updateVersion minor) class updatedVersion ].
	store dbSchema: updateVersion.
]

{ #category : #'schema updating' }
LeLocalJsonV3Storage >> updateFile: file from: oldVersion [
	"If the supplied file is at the oldVersion, update it to the next version"
	| updater jsonObject version backup newFileReference |

	jsonObject := self loadJsonFrom: file.
	version := LeDbVersion fromString: (jsonObject at: #'__schema').
	version > oldVersion ifTrue: [ ^ self ].

	updater := LeJsonV3SchemaUpdater updaterFor: oldVersion minor.
	updater update: jsonObject.
	newFileReference := updater fileReferenceFor: jsonObject named: file.

	backup := file withExtension: (version asString, 'bak').
	backup ensureDelete.
	"Rename of FileLocators seems to always update the receiver, which we don't want.
	Be conservative and always resolve and copy the file reference to avoid updating the original."
	file resolve copy renameTo: backup basename.
	self write: jsonObject toJsonFile: newFileReference.

]

{ #category : #enumerating }
LeLocalJsonV3Storage >> withExplicitLinksFileIn: aDirectory do: aBlock [
	| linksFiles |
	linksFiles := aDirectory childrenMatching: '*.lepiter.links'.
	linksFiles ifEmpty: [ ^ nil ].
	self assert: [ linksFiles size = 1 ].
	^ aBlock value: linksFiles first
]
