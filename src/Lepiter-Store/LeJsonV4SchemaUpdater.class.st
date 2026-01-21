"
LeJsonV3SchemaUpdater updates a given page.

While this is normall one minor version, e.g. 3.0 to 3.1, the updater is reponsible for specifying what the new version is, allowing for major version upgrades, e.g. 3.2 to 4.0.

To avoid shotgun parsing, i.e. the core model dealing with different DB representations, all updates are done using basic JSON types, i.e. numbers, strings, arrays and dictionaries, avoiding the need to create core objects.

A subclass is created for each step of the upgrade, allowing the database to be updated from any previous minor version to the current version.

"
Class {
	#name : #LeJsonV4SchemaUpdater,
	#superclass : #Object,
	#category : 'Lepiter-Store-JsonV4'
}

{ #category : #'private - accessing' }
LeJsonV4SchemaUpdater class >> minorVersion [ 
	"Answer the minor version number that this class upgrades from"

	^ self subclassResponsibility 
]

{ #category : #accessing }
LeJsonV4SchemaUpdater class >> updatedVersion [ 
	"Answer the version that the file is updated to, typically minorVersion+1"

	^ LeDbVersion new
		major: 4;
		minor: self minorVersion + 1.
]

{ #category : #accessing }
LeJsonV4SchemaUpdater class >> updaterFor: version [
	"Answer an instance of the subclass that updates from minor version to version+1"

	^ (self subclasses detect: [ :cls | cls minorVersion = version ]) new
]

{ #category : #private }
LeJsonV4SchemaUpdater >> fileReferenceFor: jsonObject named: file [
	"Answer the new file name to be used to store the page.
	By default file names don't change.  Subclasses should over-write as appropriate.
	Copy the file reference in case it is used for renaming later on."

	^ file resolve copy
]

{ #category : #private }
LeJsonV4SchemaUpdater >> update: jsonObject [
	"Update the supplied JSON object by one version"

	jsonObject at: #'__schema' put: ('4.', (self class minorVersion + 1) asString)
]
