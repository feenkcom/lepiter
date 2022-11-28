Class {
	#name : #LeExternalPicturesWriter,
	#superclass : #Object,
	#instVars : [
		'associatedNames',
		'counter',
		'memoryStore'
	],
	#category : #'Lepiter-HTML-Exporter'
}

{ #category : #initialization }
LeExternalPicturesWriter class >> initialCounterValue [
	^ 999
]

{ #category : #enumerating }
LeExternalPicturesWriter >> allFiles [
	<return: #Array of: #FileReference>
	^ self rootDirectory allFiles
]

{ #category : #accessing }
LeExternalPicturesWriter >> exampleResultReferenceFor: anExampleAnnotation [ 
	<return: #String>
	| aPath |
	aPath := (LepiterConstants exportedResultsDirectoryPath / self nextNumber asString) withExtension: LepiterConstants exportedResultsExtension.
	self exportExampleResultOf: anExampleAnnotation to: aPath.
	associatedNames at: anExampleAnnotation put: aPath.
	^ aPath fullName
]

{ #category : #accessing }
LeExternalPicturesWriter >> exampleSnippetResultReferenceFor: aSnippetExample [
	<return: #String>
	| aPath |
	aPath := LepiterConstants exportedResultsDirectoryPath
		/ self nextNumber asString
		withExtension: LepiterConstants exportedResultsExtension.
		
	self
		exportGtExampleResultOf: aSnippetExample referencedExample compiledMethod gtExample  
		to: aPath
		height: LepiterConstants defaultPreviewHeight
		withPreviewSelector: aSnippetExample previewShowSelector.
	associatedNames at: aSnippetExample put: aPath.
	^ aPath fullName
]

{ #category : #private }
LeExternalPicturesWriter >> exportExampleResultOf: anExampleAnnotation to: aRelativePath [ 
	| fileReference exampleReturnValue container scaleFactor height |
	fileReference := memoryStore referenceTo: aRelativePath.
	exampleReturnValue := anExampleAnnotation imageObject compiledMethod gtExample returnValue.
	
	container := XdExporterContainerElement new.
	"recommended size"
	scaleFactor := LepiterConstants exportFigureScaleFactor.
	height := anExampleAnnotation previewHeight ifNil: [ 
		LepiterConstants defaultPreviewHeight ].
	container size: LepiterConstants defaultExportFigureWidth @ height.

	BlUseAsyncFeatures disableDuring: [ 
		| view |
		view := GtPhlowView empty 
			on: exampleReturnValue 
			perform: (anExampleAnnotation previewShowSelector ifNil: [
				LepiterConstants defaultShowSelector ]).
		view asElementDo: [ :anElement | container addChild: anElement ].

		container forceLayout.

		fileReference ensureDelete.
		fileReference parent ensureCreateDirectory.
		
		BlExporter png 
			scaled: scaleFactor;
			background: Color white;
			element: container; 
			fileName: fileReference; 
			export ].
]

{ #category : #private }
LeExternalPicturesWriter >> exportGtExampleResultOf: aGtExample to: aRelativePath height: aHeight withPreviewSelector: aPreviewSelector [
	| fileReference exampleReturnValue container scaleFactor height |
	fileReference := memoryStore referenceTo: aRelativePath.
	exampleReturnValue := aGtExample  returnValue.
	
	container := XdExporterContainerElement new.
	"recommended size"
	scaleFactor := LepiterConstants exportFigureScaleFactor.
	height := aHeight.
	container size: LepiterConstants defaultExportFigureWidth @ height.

	BlUseAsyncFeatures disableDuring: [ 
		| view |
		view := GtPhlowView empty 
			on: exampleReturnValue 
			perform: aPreviewSelector asSymbol.
		view asElementDo: [ :anElement | container addChild: anElement ].

		container forceLayout.

		fileReference ensureDelete.
		fileReference parent ensureCreateDirectory.
		
		BlExporter png 
			scaled: scaleFactor;
			background: Color white;
			element: container; 
			fileName: fileReference; 
			export ].
]

{ #category : #'gt - extensions' }
LeExternalPicturesWriter >> gtDirectoryFor: aView [
	<gtView>
	memoryStore ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Directory';
		priority: 1;
		object: [ self rootDirectory ];
		view: #gtTreeFor:
]

{ #category : #initialization }
LeExternalPicturesWriter >> initialize [
	super initialize.
	associatedNames := Dictionary new.
	counter := self class initialCounterValue.
	memoryStore := FileSystem memory
]

{ #category : #private }
LeExternalPicturesWriter >> nextNumber [
	counter := counter + 1.
	^ counter
]

{ #category : #accessing }
LeExternalPicturesWriter >> rootDirectory [
	<return: #FileReference>
	^ memoryStore root
]
