"
I export an {{gtMethod:GtExample >> returnValue | label=example return value}} to a PNG format using a {{gtMethod: BlExporter class >> #png | label=PNG exporter}}. 
#Example
{{gtExample:LeExampleToPngExporterExamples>>#exportGtHistory | codeExpanded=false | previewExpanded=true | previewHeight=400}}
"
Class {
	#name : #LeExampleToPngExporter,
	#superclass : #Object,
	#instVars : [
		'example',
		'fileReference',
		'height',
		'previewSelector',
		'scaleFactor',
		'width'
	],
	#category : #'Lepiter-HTML-Exporter'
}

{ #category : #asserting }
LeExampleToPngExporter >> assertInitialization [
	self 
		assert: [ example isNotNil ] 
		description: [ 'Example must not be nil' ].
	self
		assert: [ fileReference isNotNil ]
		description: [ 'File reference must not be nil' ]
]

{ #category : #accessing }
LeExampleToPngExporter >> example [
	<return: #GtExampleWithResult>
	^ example
]

{ #category : #accessing }
LeExampleToPngExporter >> example: aGtExampleWithResult [
	example := aGtExampleWithResult asExampleWithResult
]

{ #category : #accessing }
LeExampleToPngExporter >> export [
	| exampleReturnValue container |
	self assertInitialization.

	exampleReturnValue := example returnValue.

	(exampleReturnValue isKindOf: BlElement)
		ifTrue: [ exampleReturnValue removeFromParent ].

	container := XdExporterContainerElement new.	"recommended size"
	container size: width @ height.

	BlUseAsyncFeatures
		disableDuring: [ | view |
			view := GtPhlowView empty
					on: exampleReturnValue
					perform: previewSelector asSymbol.
			view asElementDo: [ :anElement | container addChild: anElement ].

			container forceLayout.

			fileReference ensureDelete.
			fileReference parent ensureCreateDirectory.

			BlExporter png
				scaled: scaleFactor;
				background: Color white;
				element: container;
				fileName: fileReference;
				export ]
]

{ #category : #accessing }
LeExampleToPngExporter >> fileReference [
	<return: #FileReference>
	^ fileReference
]

{ #category : #accessing }
LeExampleToPngExporter >> fileReference: aFileReference [
	fileReference := aFileReference
]

{ #category : #'gt - extensions' }
LeExampleToPngExporter >> gtFigureFor: aView [
	<gtView>
	fileReference ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Picture';
		priority: 10;
		object: [ fileReference ];
		view: #gtFigureFor:
]

{ #category : #accessing }
LeExampleToPngExporter >> height [
	<return: #Integer>
	^ height
]

{ #category : #accessing }
LeExampleToPngExporter >> height: anInteger [
	height := anInteger
]

{ #category : #accessing }
LeExampleToPngExporter >> initialize [
	super initialize.

	scaleFactor := LepiterConstants exportFigureScaleFactor.
	width := LepiterConstants defaultExportFigureWidth.
	height := LepiterConstants defaultPreviewHeight.
	previewSelector := LepiterConstants defaultShowSelector
]

{ #category : #accessing }
LeExampleToPngExporter >> previewSelector [
	<return: #Symbol>
	^ previewSelector
]

{ #category : #accessing }
LeExampleToPngExporter >> previewSelector: aSymbol [
	previewSelector := aSymbol asSymbol
]

{ #category : #accessing }
LeExampleToPngExporter >> scaleFactor [
	^ scaleFactor
]

{ #category : #accessing }
LeExampleToPngExporter >> scaleFactor: anObject [
	scaleFactor := anObject
]

{ #category : #accessing }
LeExampleToPngExporter >> width [
	^ width
]

{ #category : #accessing }
LeExampleToPngExporter >> width: anObject [
	width := anObject
]
