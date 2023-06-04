Class {
	#name : #LeExportMemoryStore,
	#superclass : #Object,
	#traits : 'TLeExportFileStore',
	#classTraits : 'TLeExportFileStore classTrait',
	#instVars : [
		'memoryStore'
	],
	#category : #'Lepiter-Export-File Store'
}

{ #category : #'gt - extensions' }
LeExportMemoryStore >> gtFilesFor: aView [
	<gtView>
	memoryStore ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Files';
		priority: 10;
		object: [ memoryStore root ];
		view: #gtTreeFor:
]

{ #category : #'api - storing' }
LeExportMemoryStore >> hasChildren [
	"Return true if the file store has children (files or directories)"

	<return: #Boolean>
	^ memoryStore hasChildren: memoryStore root
]

{ #category : #initialization }
LeExportMemoryStore >> initialize [
	super initialize.
	
	memoryStore := FileSystem memory
]

{ #category : #'api - storing' }
LeExportMemoryStore >> nextFileReferenceTo: aRelativePath [
	<return: #FileReference>
	^ memoryStore referenceTo: aRelativePath
]
