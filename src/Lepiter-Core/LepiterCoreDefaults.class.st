"
LepiterCoreDefaults defines all default and constant values used by Lepiter-Core and dependents.

"
Class {
	#name : #LepiterCoreDefaults,
	#superclass : #Object,
	#classInstVars : [
		'defaultDocumentationDirectory'
	],
	#category : #'Lepiter-Core-Defaults'
}

{ #category : #constants }
LepiterCoreDefaults class >> databasePropertiesBasename [

	^ 'lepiter.properties'
]

{ #category : #defaults }
LepiterCoreDefaults class >> defaultDocumentationDirectory [
	^ defaultDocumentationDirectory ifNil: [ 
		FileLocator imageDirectory 
			/ 'gt-extra' ]
]

{ #category : #defaults }
LepiterCoreDefaults class >> defaultDocumentationDirectory: aFileLocator [
	defaultDocumentationDirectory := aFileLocator
]

{ #category : #defaults }
LepiterCoreDefaults class >> defaultGemStonePropertiesFileReference [

	^ self defaultLocalDirectory / self gemStonePropertiesBasename
]

{ #category : #defaults }
LepiterCoreDefaults class >> defaultGtoolkitDocumentationDirectory [
	^ self defaultDocumentationDirectory
		/ 'feenkcom' 
		/ 'gtoolkit' 
		/ 'lepiter'
]

{ #category : #defaults }
LepiterCoreDefaults class >> defaultLocalDirectory [
	"Answer the FileReference pointing to the lepiter knowledge base root directory as used by GtWorld."

	^ FileLocator imageDirectory 
		/ 'pharo-local' 
		/ 'lepiter'
]

{ #category : #defaults }
LepiterCoreDefaults class >> defaultLocalLogicalDatabasePropertiesFileReference [
	"Answer the FileReference pointing to the logical database properties used by GtWorld."

	^ self defaultLocalDirectory / self logicalDatabasePropertiesBasename
]

{ #category : #defaults }
LepiterCoreDefaults class >> defaultStorageDirectory [
	"Answer the FileReference pointing to the lepiter knowledge base root directory as used by the Lepiter Application."

	^ FileLocator documents / 'lepiter'
]

{ #category : #constants }
LepiterCoreDefaults class >> gemStonePropertiesBasename [

	^ 'gt4gemstone.properties'
]

{ #category : #constants }
LepiterCoreDefaults class >> logicalDatabasePropertiesBasename [

	^ 'logical-database.properties'
]

{ #category : #defaults }
LepiterCoreDefaults class >> logicalDatabasePropertiesFileReference [
	"Answer the FileReference pointing to the logical database properties used by the Lepiter Application."

	^ self defaultStorageDirectory
		/ self logicalDatabasePropertiesBasename
]

{ #category : #defaults }
LepiterCoreDefaults class >> playgroundDatabaseDirectory [ 

	^ self defaultStorageDirectory / 'playground'
]

{ #category : #defaults }
LepiterCoreDefaults class >> primaryDatabaseDirectory [

	^ self defaultStorageDirectory / 'default'
]
