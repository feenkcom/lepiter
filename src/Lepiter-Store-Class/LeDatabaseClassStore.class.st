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

	^ self new storage: LeClassJsonV4Storage new
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
