"
LeJsonV4LogicalPropertiesUpdater updates earlier logical-database.properties files

The updater can be run in default mode:

``` 
LeJsonV4LogicalPropertiesUpdater updateDefault
```

which searches for the properties file in `FileLocator preferences / 'pharo' / 'lepiterdbs' / 'v3'` and updates it if it exists, or it can be given a specific file to update (without moving):

``` 
LeJsonV4LogicalPropertiesUpdater updateFile: aPropertiesFile
```


The default actions are: 

- Move the properties file from `FileLocator preferences / 'pharo' / 'lepiterdbs' / 'v3'` to `FileLocator documents / 'lepiter'`
- Add the schema version number to the properties.

"
Class {
	#name : #LeJsonV4LogicalPropertiesUpdater,
	#superclass : #Object,
	#category : 'Lepiter-Store-JsonV4'
}

{ #category : #updating }
LeJsonV4LogicalPropertiesUpdater class >> updateDefault [
	"Update the default properties file if found"
	| oldPropertiesFile propertiesFile |

	oldPropertiesFile := FileLocator preferences / 'pharo' / 'lepiterdbs' / 'v3' / 'logical-database.properties'.
	oldPropertiesFile exists ifFalse: [ ^ self ].

	"If the new file already exists, we have an inconsistent state"
	LepiterCoreDefaults logicalDatabasePropertiesFileReference exists ifTrue: 
		[ self error: 'Both old and new default properties file exists' ].

	propertiesFile := LepiterCoreDefaults logicalDatabasePropertiesFileReference.
	propertiesFile parent ensureCreateDirectory.
	oldPropertiesFile moveTo: propertiesFile.

	self updateFile: propertiesFile.
]

{ #category : #updating }
LeJsonV4LogicalPropertiesUpdater class >> updateFile: propertiesFile [
	"Update the supplied properties file"
	| jsonDictionary |

	jsonDictionary := STONJSON fromString: propertiesFile contents.
	jsonDictionary at: #schema put: LeLocalJsonV4Storage currentVersionString.

	propertiesFile resolve copy renameTo: (propertiesFile basename, '.3bak').
	propertiesFile writeStreamDo: [ :stream |
		STONJSON put: jsonDictionary onStreamPretty: (ZnNewLineWriterStream on: stream) ].

]
