"
LepiterCoreDefaults defines all default and constant values used by Lepiter-Core and dependents.
"
Class {
	#name : #LepiterCoreDefaults,
	#superclass : #Object,
	#category : #'Lepiter-Core-Defaults'
}

{ #category : #constants }
LepiterCoreDefaults class >> databasePropertiesBasename [

	^ 'lepiter.properties'
]

{ #category : #defaults }
LepiterCoreDefaults class >> defaultGtoolkitDocumentationDirectory [
	"^ GtResourcesUtility default 
		resourceAtPath: Path * 'feenkcom' / 'lepiter-engine' / 'glamorous-toolkit-lepiterdb'."
	
	^ FileLocator imageDirectory / 'pharo-local' / 'iceberg' / 'feenkcom' / 'lepiter-engine' / 'glamorous-toolkit-lepiterdb'
]

{ #category : #defaults }
LepiterCoreDefaults class >> defaultLocalLogicalDatabasePropertiesFileReference [
	^ FileLocator imageDirectory 
		/ 'pharo-local' 
		/ 'lepiter'
		/ self logicalDatabasePropertiesBasename
]

{ #category : #defaults }
LepiterCoreDefaults class >> defaultStorageDirectory [
	^ FileLocator documents / 'lepiter'
]

{ #category : #constants }
LepiterCoreDefaults class >> logicalDatabasePropertiesBasename [

	^ 'logical-database.properties'
]

{ #category : #defaults }
LepiterCoreDefaults class >> logicalDatabasePropertiesFileReference [
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
