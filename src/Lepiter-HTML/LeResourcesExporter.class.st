Class {
	#name : #LeResourcesExporter,
	#superclass : #Object,
	#instVars : [
		'counter',
		'memoryStore',
		'resources'
	],
	#category : #'Lepiter-HTML-Exporter'
}

{ #category : #initialization }
LeResourcesExporter class >> initialCounterValue [
	"The first used value will be 1000"

	^ 999
]

{ #category : #'api - exporting' }
LeResourcesExporter >> addResource: aResource [
	resources add: aResource
]

{ #category : #enumerating }
LeResourcesExporter >> allFiles [
	<return: #Array of: #FileReference>
	^ self rootDirectory allFiles
]

{ #category : #converting }
LeResourcesExporter >> asArray [
	^ resources asArray
]

{ #category : #enumerating }
LeResourcesExporter >> detectResource: aDetectBlock ifFound: aFoundBlock ifNone: aNoneBlock [
	^ resources
		detect: aDetectBlock
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #enumerating }
LeResourcesExporter >> do: aDoBlock [
	resources do: aDoBlock
]

{ #category : #'api - exporting' }
LeResourcesExporter >> elementSnippetReferenceFor: aLeElementSnippet [
	<return: #String>
	| aPath aFileReference anExporter aViewModel aSnippetElement aHeight |
	
	"Prepare element"
	aViewModel := aLeElementSnippet asSnippetViewModel.
	aSnippetElement := aViewModel snippetView asElement.
	aSnippetElement snippetViewModel: aViewModel.
	aSnippetElement padding: (BlInsets all: 10).
	
	"Compute height"
	aHeight := aLeElementSnippet elementHeight.
	aLeElementSnippet codeVisible ifTrue: [
		aHeight := aHeight + aLeElementSnippet codeHeight
	].
	
	"Prepare file"
	aPath := LepiterConstants exportedResultsDirectoryPath
		/ self nextNumber asString
		withExtension: LepiterConstants exportedResultsExtension.
	aFileReference := memoryStore referenceTo: aPath.
	
	"Export"
	anExporter := LeElementToPngExporter new
		element: aSnippetElement;
		fileReference: aFileReference;
		height: aHeight;
		export.
		
	"Store the resource"
	resources add: (LeExportedSnippetResource new 
		snippet: aLeElementSnippet;
		path: aPath;
		reference: aFileReference).
	
	"Return relative path"
	^ aPath fullName
]

{ #category : #'api - exporting' }
LeResourcesExporter >> exampleResultReferenceFor: anExampleAnnotation [ 
	<return: #String>
	| aPath fileReference |
	aPath := (LepiterConstants exportedResultsDirectoryPath / self nextNumber asString) withExtension: LepiterConstants exportedResultsExtension.
	fileReference := self 
		exportExampleResultOf: anExampleAnnotation 
		to: aPath.
	resources add: (LeExportedAnnotationResource new 
		annotation: anExampleAnnotation;
		path: aPath;
		reference: fileReference).
	^ aPath fullName
]

{ #category : #'api - exporting' }
LeResourcesExporter >> exampleSnippetResultReferenceFor: aSnippetExample [
	<return: #String>
	| aPath fileReference |
	aPath := LepiterConstants exportedResultsDirectoryPath
		/ self nextNumber asString
		withExtension: LepiterConstants exportedResultsExtension.
		
	fileReference := self
		exportGtExampleResultOf: aSnippetExample referencedExample compiledMethod gtExample  
		to: aPath
		height: LepiterConstants defaultPreviewHeight
		withPreviewSelector: aSnippetExample previewShowSelector.
	resources add: (LeExportedSnippetResource new 
		snippet: aSnippetExample;
		path: aPath;
		reference: fileReference).
	^ aPath fullName
]

{ #category : #private }
LeResourcesExporter >> exportExampleResultOf: anExampleAnnotation to: aRelativePath [ 
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
			
	^ fileReference
]

{ #category : #private }
LeResourcesExporter >> exportGtExampleResultOf: aGtExample to: aRelativePath height: aHeight withPreviewSelector: aPreviewSelector [
	| fileReference |
	fileReference := memoryStore referenceTo: aRelativePath.
	
	^ LeExampleToPngExporter new
		fileReference: fileReference;
		example: aGtExample;
		height: aHeight;
		previewSelector: aPreviewSelector;
		export;
		withScripter;
		fileReference
]

{ #category : #'gt - extensions' }
LeResourcesExporter >> gtDirectoryFor: aView [
	<gtView>
	memoryStore ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Directory';
		priority: 5;
		object: [ self rootDirectory ];
		view: #gtTreeFor:
]

{ #category : #'gt - extensions' }
LeResourcesExporter >> gtResourcesFor: aView [
	<gtView>
	resources ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Resources';
		priority: 1;
		items: [ resources ifNil: [ #() ] ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 60;
		column: 'Source' text: [ :aResource | aResource source ];
		column: 'Path' text: [ :aResource | aResource path fullName ]
]

{ #category : #initialization }
LeResourcesExporter >> initialize [
	super initialize.
	resources := OrderedCollection new.
	counter := self class initialCounterValue.
	memoryStore := FileSystem memory
]

{ #category : #private }
LeResourcesExporter >> nextNumber [
	counter := counter + 1.
	^ counter
]

{ #category : #accessing }
LeResourcesExporter >> rootDirectory [
	<return: #FileReference>
	^ memoryStore root
]

{ #category : #accessing }
LeResourcesExporter >> saveAllToDirectory: aDirectory [ 
]

{ #category : #'api - exporting' }
LeResourcesExporter >> wardleyMapSnippetReferenceFor: aLeWardleyMapSnippet [
	<return: #String>
	| aPath aFileReference anExporter aViewModel aSnippetElement |
	
	"Prepare element"
	aViewModel := aLeWardleyMapSnippet asSnippetViewModel.
	aSnippetElement := aViewModel snippetView asElement.
	aSnippetElement snippetViewModel: aViewModel.
	aSnippetElement padding: (BlInsets all: 10).
	
	"Prepare file"
	aPath := LepiterConstants exportedResultsDirectoryPath
		/ self nextNumber asString
		withExtension: LepiterConstants exportedResultsExtension.
	aFileReference := memoryStore referenceTo: aPath.
	
	"Export"
	anExporter := LeElementToPngExporter new
		element: aSnippetElement;
		fileReference: aFileReference;
		height: aLeWardleyMapSnippet height;
		export.
		
	"Store the resource"
	resources add: (LeExportedSnippetResource new 
		snippet: aLeWardleyMapSnippet;
		path: aPath;
		reference: aFileReference).
	
	"Return relative path"
	^ aPath fullName
]
