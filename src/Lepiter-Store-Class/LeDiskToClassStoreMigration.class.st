"
LeDiskToClassStoreMigration assists with the migration of a lepiter database using a Json V4 disk store to class based storage.

This has only been used for a single migration, and was enough for that, but hasn't been tested extensively.
"
Class {
	#name : #LeDiskToClassStoreMigration,
	#superclass : #Object,
	#traits : 'TLeModelVisitor',
	#classTraits : 'TLeModelVisitor classTrait',
	#instVars : [
		'diskDb',
		'dbClassName',
		'dbClass',
		'packageName',
		'classDb'
	],
	#category : #'Lepiter-Store-Class'
}

{ #category : #accessing }
LeDiskToClassStoreMigration class >> migrate: diskDb to: dbClassName package: packageName [

	^ self new
		diskDb: diskDb;
		dbClassName: dbClassName;
		packageName: packageName;
		migrate.
]

{ #category : #accessing }
LeDiskToClassStoreMigration >> dbClass [
	^ dbClass
]

{ #category : #accessing }
LeDiskToClassStoreMigration >> dbClass: anObject [
	dbClass := anObject
]

{ #category : #accessing }
LeDiskToClassStoreMigration >> dbClassName [
	^ dbClassName
]

{ #category : #accessing }
LeDiskToClassStoreMigration >> dbClassName: anObject [
	dbClassName := anObject
]

{ #category : #accessing }
LeDiskToClassStoreMigration >> diskDb [
	^ diskDb
]

{ #category : #accessing }
LeDiskToClassStoreMigration >> diskDb: anObject [
	diskDb := anObject
]

{ #category : #actions }
LeDiskToClassStoreMigration >> migrate [

	self class environment 	
		at: dbClassName	
		ifPresent: #removeFromSystem.
	LeDatabaseClassStoreExport forJsonV4	
		database: diskDb;
		dbClassName: dbClassName package: packageName;
		export.
	dbClass := self class environment at: dbClassName.
	classDb := LeDatabaseClassStoreLoad forJsonV4 
		loadFromClass: dbClass.
	self migratePageLinks.
]

{ #category : #private }
LeDiskToClassStoreMigration >> migratePageLinks [

	classDb acceptVisitor: self.
]

{ #category : #accessing }
LeDiskToClassStoreMigration >> packageName [
	^ packageName
]

{ #category : #accessing }
LeDiskToClassStoreMigration >> packageName: anObject [
	packageName := anObject
]

{ #category : #visiting }
LeDiskToClassStoreMigration >> visitDefinedLink: aDefinedLink [
	^ self visitLink: aDefinedLink
]

{ #category : #visiting }
LeDiskToClassStoreMigration >> visitDoubleBracketLink: aDoubleBracketLink [
	^ self visitPageLink: aDoubleBracketLink
]

{ #category : #visiting }
LeDiskToClassStoreMigration >> visitLink: aLink [

]

{ #category : #visiting }
LeDiskToClassStoreMigration >> visitPage: aLePage [

	^ self visitContent: aLePage
]

{ #category : #visiting }
LeDiskToClassStoreMigration >> visitPageAnnotation: anAnnotation [

	anAnnotation dbUuidString = diskDb uuidString ifFalse: [ ^ self ].
	"Links to the local database shouldn't be page annotations, rather double-bracket links."
	self error: 'Unexpected UUID'.
]

{ #category : #visiting }
LeDiskToClassStoreMigration >> visitPageLink: aPageLink [
	^ self visitDefinedLink: aPageLink
]

{ #category : #visiting }
LeDiskToClassStoreMigration >> visitTextualLink: aLink [
	^ self visitLink: aLink
]
