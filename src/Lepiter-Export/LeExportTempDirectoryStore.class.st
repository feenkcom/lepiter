Class {
	#name : #LeExportTempDirectoryStore,
	#superclass : #Object,
	#traits : 'TLeExportFileStore',
	#classTraits : 'TLeExportFileStore classTrait',
	#instVars : [
		'tempDirectory'
	],
	#category : #'Lepiter-Export-File Store'
}

{ #category : #finalization }
LeExportTempDirectoryStore >> finalize [
	super finalize.

	tempDirectory ensureDeleteAll
]

{ #category : #'gt - extensions' }
LeExportTempDirectoryStore >> gtFilesFor: aView [
	<gtView>
	tempDirectory ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Files';
		priority: 10;
		object: [ tempDirectory root ];
		view: #gtTreeFor:
]

{ #category : #'api - storing' }
LeExportTempDirectoryStore >> hasChildren [
	"Return true if the file store has children (files or directories)"

	<return: #Boolean>
	^ tempDirectory exists and: [ tempDirectory hasChildren: tempDirectory root ]
]

{ #category : #initialization }
LeExportTempDirectoryStore >> initialize [
	super initialize.

	tempDirectory := FileReference
			newTempFilePrefix: 'lepiter-export-store-'
			suffix: '-directory'.
	
	tempDirectory ensureCreateDirectory.
	
	"Remove the directory when the object is not used."
	self class finalizationRegistry add: self
]

{ #category : #'api - storing' }
LeExportTempDirectoryStore >> nextFileReferenceTo: aRelativePath [
	<return: #FileReference>
	^ tempDirectory resolve: aRelativePath
]
