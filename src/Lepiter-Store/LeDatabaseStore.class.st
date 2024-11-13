Class {
	#name : #LeDatabaseStore,
	#superclass : #Object,
	#instVars : [
		'database',
		'storage',
		'dbProperties'
	],
	#category : #'Lepiter-Store-Model'
}

{ #category : #'instance creation' }
LeDatabaseStore class >> current [
	"Answer an instance of the receiver with the current storage format"

	^ self forJsonV4
]

{ #category : #accessing }
LeDatabaseStore class >> defaultDelay [

	^ 30 seconds
]

{ #category : #accessing }
LeDatabaseStore class >> loaderFor: aDatabaseUrl [

	^ self allSubclasses detect: [ :each |
		each loadsDatabaseUrl: aDatabaseUrl ]
]

{ #category : #testing }
LeDatabaseStore class >> loadsDatabaseUrl: aDatabaseZnUrl [
	"Answer a boolean indicating whether the receiver can load the supplied URL"

	^ false
]

{ #category : #testing }
LeDatabaseStore class >> noLepiterReload [
	"Answer a boolean indicating whether the image has been started with the --noLepiterReload option"

	^ Smalltalk commandLine argumentsInclude: '--noLepiterReload'
]

{ #category : #private }
LeDatabaseStore >> clearDatabaseProperties [
	dbProperties := nil.
]

{ #category : #accessing }
LeDatabaseStore >> database [
	^ database
]

{ #category : #accessing }
LeDatabaseStore >> database: anObject [
	database := anObject
]

{ #category : #'accessing - db properties' }
LeDatabaseStore >> databaseName [
	<return: #String or: nil>

	^ self dbProperties at: 'databaseName'
		ifPresent: [ :aString | aString ]
		ifAbsent: [ self defaultDatabaseName ]
]

{ #category : #'accessing - db properties' }
LeDatabaseStore >> databaseName: aString [
	"Store the database name"

	aString ifNil: [ 
		self dbProperties removeKey: #databaseName ifAbsent: [ ].
		^ self savePropertiesDictionary: dbProperties ].
	self updateProperty: #databaseName value: aString asString 
]

{ #category : #'accessing - db properties' }
LeDatabaseStore >> dbProperties [
	<return: #GtStringContentDictionary>
	^ dbProperties ifNil: [ dbProperties := self loadPropertiesDictionary ]
]

{ #category : #'accessing - db properties' }
LeDatabaseStore >> dbPropertiesOrNil [
	<return: #GtStringContentDictionary or: nil>
	^ dbProperties
]

{ #category : #accessing }
LeDatabaseStore >> dbSchema [

	^ LeDbVersion fromString: (self dbProperties at: 'schema')
]

{ #category : #'private - accessing' }
LeDatabaseStore >> dbSchema: aLeDbVersion [ 


	self dbProperties at: #schema put: aLeDbVersion asString.
	self savePropertiesDictionary: dbProperties
]

{ #category : #'accessing - db properties' }
LeDatabaseStore >> defaultDatabaseName [
	"Answer the name to be used if one hasn't been explicitly set"
	<return: #String>

	^ self subclassResponsibility
]

{ #category : #accessing }
LeDatabaseStore >> defaultDelay [

	^ self class defaultDelay
]

{ #category : #'private - db properties' }
LeDatabaseStore >> fileReferenceFrom: aString [
	"Answer a FileReference or FileLocator from the supplied string.
	FileLocator origins + 'dbParentDirectory' are available as formatted strings, e.g.
		{home}/lepiter
	is the equivalent of
		FileLocator home / 'lepiter'"
	| namedDirectories regex name path |

	namedDirectories := (FileLocator supportedOrigins collect: [ :origin | 
		origin -> (FileLocator origin: origin) ]) asGtStringContentDictionary.
	namedDirectories at: #dbParentDirectory put: self localRoot parent.
	regex := '\{([a-zA-Z]+)\}(.*)' asRegex.
	^ (regex matches: aString) ifTrue: 
		[ name := regex subexpression: 2.
		path := regex subexpression: 3.
		namedDirectories at: name
			ifPresent: [ :locator | locator resolve: path allButFirst ]
			ifAbsent: [ self error: 'Unknown directory: ', name printString ] ]
	ifFalse:
	 	[ aString asFileReference ].
]

{ #category : #ui }
LeDatabaseStore >> gtPropertiesFor: aView [
	"Provide a simple view of the current properties"
	<gtView>
	
	dbProperties ifNil: [ ^ aView empty ].

	^ aView forward 
		title: 'Properties';
		priority: 15;
		object: [ self dbProperties ];
		view: #gtItemsFor:
]

{ #category : #'private - db properties' }
LeDatabaseStore >> loadDatabasePropertiesIn: aDatabase [
	"Load the lepiter.properties file and update the database"

	self dbProperties 
		at: #userEmail 
		ifPresent: [ :email | database userEmail: email ].
]

{ #category : #'accessing - db properties' }
LeDatabaseStore >> loadPropertiesDictionary [
	"Answer the lepiter properties dictionary"

	^ self subclassResponsibility
]

{ #category : #accessing }
LeDatabaseStore >> localRoot [
	"Answer the 'localRoot'.
	For stores that aren't disk based, answer the default lepiter directory."

	^ LepiterCoreDefaults defaultLocalDirectory
]

{ #category : #accessing }
LeDatabaseStore >> newPropertiesDictionary [
	"Answer a new, initialised properties dictionary"
	| dict |
	
	dict := GtStringContentDictionary new
		at: #schema put: storage class currentVersionString;
		at: #uuid put: UUID new asString;
		yourself.
	self savePropertiesDictionary: dict.
	^ dict.
]

{ #category : #'accessing - db properties' }
LeDatabaseStore >> propertyAt: aSymbol [
	<return: #String or: #Dictionary>

	^ self dbProperties at: aSymbol
]

{ #category : #'accessing - db properties' }
LeDatabaseStore >> propertyAt: aSymbol ifAbsent: absentBlock [
	<return: #String or: #Dictionary>

	^ self dbProperties at: aSymbol ifAbsent: absentBlock
]

{ #category : #'accessing - db properties' }
LeDatabaseStore >> propertyAt: aSymbol ifPresent: presentBlock ifAbsent: absentBlock [

	^ self dbProperties 
		at: aSymbol 
		ifPresent: presentBlock
		ifAbsent: absentBlock
]

{ #category : #'accessing - db properties' }
LeDatabaseStore >> savePersonalInformation [
	<return: #Boolean>

	^ self dbProperties at: #savePersonalInformation 
		ifPresent: [ :aBoolean | aBoolean ]
		ifAbsent: [ false ]
]

{ #category : #'accessing - db properties' }
LeDatabaseStore >> savePersonalInformation: aBooleanOrNil [
	"Update the flag on whether to store personal information in the database.
	nil = default, which is false (see #savePersonalInformaation)"

	self updateProperty: #savePersonalInformation value: aBooleanOrNil 
]

{ #category : #'accessing - db properties' }
LeDatabaseStore >> savePropertiesDictionary: aDictionary [
	"Save the supplied properties dictionary"
	
	self subclassResponsibility
]

{ #category : #accessing }
LeDatabaseStore >> storage [
	^ storage
]

{ #category : #accessing }
LeDatabaseStore >> storage: anObject [
	storage := anObject
]

{ #category : #'accessing - db properties' }
LeDatabaseStore >> tableOfContentsPageID [
	"Answer the page UUID for the Table Of Contents, or nil if not set"

	^ self dbProperties at: #tableOfContents 
		ifPresent: [ :uuidString | UUID fromString36: uuidString ]
		ifAbsent: [ nil ]
]

{ #category : #'accessing - db properties' }
LeDatabaseStore >> tableOfContentsPageID: aUUID [
	"Store the page to be used as a Table of Contents"

	self updateProperty: #tableOfContents value: (aUUID ifNotNil: #asString36) 
]

{ #category : #'private - db properties' }
LeDatabaseStore >> updateProperty: propertyName value: aJSONObject [
	| properties |

	properties := self dbProperties.
	aJSONObject ifNil: 
		[ properties removeKey: propertyName ifAbsent: [ ].
		^ self savePropertiesDictionary: properties ].
	(properties at: propertyName ifAbsent: [nil]) = aJSONObject ifTrue: [ ^ self ].
	properties at: propertyName put: aJSONObject.
	self savePropertiesDictionary: properties.
]

{ #category : #accessing }
LeDatabaseStore >> userEmail [

	^ database userEmail
]

{ #category : #'accessing - db properties' }
LeDatabaseStore >> uuid [ 
	"Answer the UUID of the receiver's DB"
	<return: #UUID>

	^ UUID fromString: (self dbProperties at: 'uuid')
]

{ #category : #'accessing - db properties' }
LeDatabaseStore >> uuidString [
	"Answer the UUID of the receiver's DB in String36 format"
	<return: #String>

	^ self uuid asString36
]
