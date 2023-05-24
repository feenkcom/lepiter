Class {
	#name : #LeClassJsonV4Storage,
	#superclass : #LeClassStorage,
	#category : #'Lepiter-Store-Class-Model'
}

{ #category : #versions }
LeClassJsonV4Storage class >> currentVersion [ 

	^ LeDbVersion fromString: self currentVersionString
]

{ #category : #versions }
LeClassJsonV4Storage class >> currentVersionString [
	"Answer the string representation of the current version number"

	^ '4.1'
]

{ #category : #'schema updating' }
LeClassJsonV4Storage >> dbFilesAllVersionsIn: aDirectory [
	"Answer all the db files in the supplied directory, including those from previous storage versions, i.e. V4.*"

	^ aDirectory childrenMatching: '*.lepiter;*.json;*.links'
]

{ #category : #enumerating }
LeClassJsonV4Storage >> explicitLinksOrNilFor: dbClass [

	^ (dbClass respondsTo: #explicitLinks) ifTrue:
		[ self loadFromMethod: (dbClass class >> #explicitLinks) ]
	ifFalse:
		[ nil ]
]

{ #category : #saving }
LeClassJsonV4Storage >> serialize: anObject on: aStream prettyPrint: aBoolean [

	LeJsonV4 uniqueInstance serialize: anObject on: aStream prettyPrint: aBoolean
]

{ #category : #'schema updating' }
LeClassJsonV4Storage >> updateDatabasePropertiesNameIn: rootDirectory [
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
LeClassJsonV4Storage >> updateDbStore: store [
	"Update the store to the latest minor version.
	Class base storage was added with schema 4.1.  Until there is a new schema version, nothing to do."
]

{ #category : #enumerating }
LeClassJsonV4Storage >> withExplicitLinksFileIn: aDirectory do: aBlock [
	| linksFiles |
	linksFiles := aDirectory childrenMatching: '*.lepiter.links'.
	linksFiles ifEmpty: [ ^ nil ].
	self assert: [ linksFiles size = 1 ].
	^ aBlock value: linksFiles first
]
