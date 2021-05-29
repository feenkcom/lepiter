Class {
	#name : #LeLogicalDatabasePropertiesExamples,
	#superclass : #Object,
	#category : #'Lepiter-Store-Examples'
}

{ #category : #private }
LeLogicalDatabasePropertiesExamples >> createStonDictionaryString [
	"Answer a properties dictionary string in STON format.
	Since the ston format is never written, the representation can't change, thus a constant string is used instead: #stonDictionaryString.
	Below is the code originally used to generate it."
	| dictionary |

	dictionary := Dictionary new 
		at: #primaryDatabaseDirectory put: (STON toString: LepiterCoreDefaults primaryDatabaseDirectory);
		at: #playgroundDatabaseDirectory put: (STON toString: LepiterCoreDefaults playgroundDatabaseDirectory);
		at: #registeredDatabaseDirectories put: (STON toString: { FileLocator image / 'registered' });
		yourself.
	"Answer the printString so it is ready to paste above"
	^ (STONJSON toStringPretty: dictionary) printString.
]

{ #category : #examples }
LeLogicalDatabasePropertiesExamples >> defaultPlaygroundDirectory [
	"Answer the default directory for the primary database"
	<gtExample>
	| properties |

	properties := self newProperties.
	self assert: properties playgroundDatabaseDirectory 
			equals: LepiterCoreDefaults playgroundDatabaseDirectory.
	^ properties playgroundDatabaseDirectory
]

{ #category : #examples }
LeLogicalDatabasePropertiesExamples >> defaultPrimaryDirectory [
	"Answer the default directory for the primary database"
	<gtExample>
	| properties |

	properties := self newProperties.
	self assert: properties primaryDatabaseDirectory 
			equals: LepiterCoreDefaults primaryDatabaseDirectory.
	^ properties primaryDatabaseDirectory
]

{ #category : #examples }
LeLogicalDatabasePropertiesExamples >> defaultRegisteredDatabaseDirectories [
	"Answer the default directory for the primary database"
	<gtExample>
	| properties |

	properties := self newProperties.
	self assert: properties registeredDatabaseDirectories isEmpty.
	^ properties registeredDatabaseDirectories
]

{ #category : #examples }
LeLogicalDatabasePropertiesExamples >> migrateStonProperties [
	"Confirm the migration of the old STON format"
	<gtExample>
	| propertiesFile properties |

	propertiesFile := self newPropertiesFile.
	propertiesFile writeStreamDo: [ :stream |
			stream << self stonDictionaryString ].
	properties := LeLogicalDatabaseProperties new localFile: propertiesFile.

	self assert: (properties properties at: #primaryDatabaseDirectory)
			equals: (FileLocator preferences / 'pharo' / 'lepiterdbs' / 'v3' / 'default') printString.
	self assert: (properties properties at: #playgroundDatabaseDirectory)
			equals: (FileLocator localDirectory / 'lepiterdbs' / 'v3' / 'playground') printString.
	self assert: (properties properties at: #registeredDatabaseDirectories) first
			equals: '{image}', FileSystem disk delimiter asString, 'registered'.

	^ propertiesFile
]

{ #category : #private }
LeLogicalDatabasePropertiesExamples >> newProperties [
	"Anwswer a new default logical database properties"

	^ LeLogicalDatabaseProperties withDefaultValues 
		localFile: self newPropertiesFile.
]

{ #category : #private }
LeLogicalDatabasePropertiesExamples >> newPropertiesFile [

	^ FileSystem memory root / LepiterCoreDefaults logicalDatabasePropertiesBasename
]

{ #category : #examples }
LeLogicalDatabasePropertiesExamples >> setAbsolutePlaygroundDirectory [
	"Set the directory to an absolute file reference"
	<gtExample>
	| fileReference properties |

	properties := self newProperties.
	fileReference := FileLocator home resolve asAbsolute.
	properties playgroundDatabaseDirectory: fileReference.

	self assert: (properties properties at: #primaryDatabaseDirectory)
			equals: LepiterCoreDefaults primaryDatabaseDirectory printString.
	self assert: (properties properties at: #playgroundDatabaseDirectory)
			equals: fileReference fullName.

	^ fileReference
]

{ #category : #examples }
LeLogicalDatabasePropertiesExamples >> setAbsolutePrimaryDirectory [
	"Set the directory to an absolute file reference"
	<gtExample>
	| fileReference properties |

	properties := self newProperties.
	fileReference := FileLocator image resolve asAbsolute.
	properties primaryDatabaseDirectory: fileReference.

	self assert: (properties properties at: #primaryDatabaseDirectory)
			equals: fileReference fullName.

	^ fileReference
]

{ #category : #examples }
LeLogicalDatabasePropertiesExamples >> setAbsoluteRegisteredDirectory [
	"Set the directory to an absolute file reference"
	<gtExample>
	| fileReference properties |

	properties := self newProperties.
	fileReference := FileLocator home resolve asAbsolute.
	properties addRegisteredDirectory: fileReference.

	self assert: (properties properties at: #primaryDatabaseDirectory)
			equals: LepiterCoreDefaults primaryDatabaseDirectory printString.
	self assert: (properties properties at: #playgroundDatabaseDirectory)
			equals: LepiterCoreDefaults playgroundDatabaseDirectory printString.
	self assert: (properties properties at: #registeredDatabaseDirectories) first
			equals: fileReference fullName.

	^ fileReference
]

{ #category : #examples }
LeLogicalDatabasePropertiesExamples >> setLocatorPlaygroundDirectory [
	"Set the directory to an absolute file reference"
	<gtExample>
	| fileReference properties |

	properties := self newProperties.
	fileReference := FileLocator home / 'path'.
	properties playgroundDatabaseDirectory: fileReference.

	self assert: (properties properties at: #primaryDatabaseDirectory)
			equals: LepiterCoreDefaults primaryDatabaseDirectory printString.
	self assert: (properties properties at: #playgroundDatabaseDirectory)
			equals: fileReference printString.

	^ fileReference
]

{ #category : #examples }
LeLogicalDatabasePropertiesExamples >> setLocatorPrimaryDirectory [
	"Set the directory to an absolute file reference"
	<gtExample>
	| fileReference properties |

	properties := self newProperties.
	fileReference := FileLocator home / 'path'.
	properties primaryDatabaseDirectory: fileReference.

	self assert: (properties properties at: #primaryDatabaseDirectory)
			equals: '{home}', FileSystem disk delimiter asString, 'path'.

	^ fileReference
]

{ #category : #examples }
LeLogicalDatabasePropertiesExamples >> setLocatorRegisteredDirectory [
	"Set the directory to an absolute file reference"
	<gtExample>
	| fileReference properties |

	properties := self newProperties.
	fileReference := FileLocator home / 'path'.
	properties addRegisteredDirectory: fileReference.

	self assert: (properties properties at: #primaryDatabaseDirectory)
			equals: LepiterCoreDefaults primaryDatabaseDirectory printString.
	self assert: (properties properties at: #playgroundDatabaseDirectory)
			equals: LepiterCoreDefaults playgroundDatabaseDirectory printString.
	self assert: (properties properties at: #registeredDatabaseDirectories) first
			equals: fileReference printString.

	^ fileReference
]

{ #category : #private }
LeLogicalDatabasePropertiesExamples >> stonDictionaryString [
	"Answer a properties dictionary string in STON format"

^ '{
	"registeredDatabaseDirectories" : "[FileLocator{#origin:#image,#path:RelativePath[''registered'']}]",
	"playgroundDatabaseDirectory" : "FileLocator{#origin:#localDirectory,#path:RelativePath[''lepiterdbs'',''v3'',''playground'']}",
	"primaryDatabaseDirectory" : "FileLocator{#origin:#preferences,#path:RelativePath[''pharo'',''lepiterdbs'',''v3'',''default'']}"
}'
]
