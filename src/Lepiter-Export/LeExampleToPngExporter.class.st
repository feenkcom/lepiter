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
		'width',
		'useScripter',
		'scripter',
		'container',
		'exampleReturnValue'
	],
	#category : #'Lepiter-Export-Resources - Exporters'
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

{ #category : #'private - exporting' }
LeExampleToPngExporter >> createContainer [
	scripter substep: 'Initialize example and element' do: [ :aStep | 
		aStep set 
			label: 'Run example';
			model: [ 
				exampleReturnValue := example returnValue.
				(exampleReturnValue isKindOf: BlElement)
					ifTrue: [ exampleReturnValue removeFromParent ].
				exampleReturnValue ];
			play.
		aStep set 
			label: 'Create export container';
			element: [ 
				container := XdExporterContainerElement new.	
				
				"recommended size"
				container size: width @ height.
				container ];
			onModel;
			play ].
]

{ #category : #accessing }
LeExampleToPngExporter >> example [
	<return: #GtExampleWithResult>
	^ example
]

{ #category : #accessing }
LeExampleToPngExporter >> example: aGtExampleWithResult [
	self
		assert: [ aGtExampleWithResult isNotNil ]
		description: [ 'Example must be non-nil' ].

	example := aGtExampleWithResult asExampleWithResult
]

{ #category : #'api - exporting' }
LeExampleToPngExporter >> export [
	useScripter
		ifTrue: [ self exportWithScripter ]
		ifFalse: [ self exportWithoutScripter ]
]

{ #category : #'api - exporting' }
LeExampleToPngExporter >> exportWithScripter [
	self assertInitialization.

	scripter := BlScripter new.
	scripter space title: example gtDisplayString.
	scripter maxPulseElapsedTime: 60 seconds.

	self createContainer.

	[ scripter
		doStep: [ :s | 
			s
				label: 'Create phlow view element';
				block: [ | view |
						view := GtPhlowView empty
								on: scripter model
								perform: previewSelector asSymbol.
						view asElementDo: [ :anElement | 
							container addChild: anElement ] ] ] ]
		on: BlDevScripterPulseTimeoutError
		do: [ :anException | 
			NonInteractiveTranscript stderr
				show: 'ERROR: Scripter have not finished on time.'; cr;
				show: '       Example: '; show: example gtDisplayString; cr;
				show: '       Scripter model: '; show: scripter model gtDisplayString; cr;
				show: '       Preview selector: '; show: previewSelector; cr;
				show: '       Exception: '; show: anException; cr;
				show: '       The issue is ignored, proceeding to the PNG export.'; cr ].

	fileReference ensureDelete.
	fileReference parent ensureCreateDirectory.

	BlExporter png
		scaled: scaleFactor;
		background: Color white;
		element: container;
		fileName: fileReference;
		export
]

{ #category : #accessing }
LeExampleToPngExporter >> exportWithoutScripter [
	self assertInitialization.

	exampleReturnValue := example returnValue.

	(exampleReturnValue isKindOf: BlElement)
		ifTrue: [ exampleReturnValue removeFromParent ].

	container := XdExporterContainerElement new.
	
	"recommended size"
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

{ #category : #'gt - extensions' }
LeExampleToPngExporter >> gtScripterPreviewFor: aView [
	<gtView>
	scripter ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Scripter Preview';
		priority: 15;
		object: [ scripter ];
		view: #gtSpaceFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Scripter'
			tooltip: 'Inspect scripter'
			action: [ :aButton | aButton phlow spawnObject: scripter ]
]

{ #category : #accessing }
LeExampleToPngExporter >> height [
	<return: #Integer>
	^ height
]

{ #category : #accessing }
LeExampleToPngExporter >> height: anInteger [
	self assert: [ anInteger isNotNil ] description: [ 'Height must be non-nil' ].

	height := anInteger
]

{ #category : #accessing }
LeExampleToPngExporter >> initialize [
	super initialize.

	useScripter := true.
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
	self
		assert: [ aSymbol isNotNil ]
		description: [ 'Preview selector must be non-nil' ].

	previewSelector := aSymbol asSymbol
]

{ #category : #accessing }
LeExampleToPngExporter >> scaleFactor [
	^ scaleFactor
]

{ #category : #accessing }
LeExampleToPngExporter >> scaleFactor: anInteger [
	self
		assert: [ anInteger isNotNil ]
		description: [ 'Scale factor must be non-nil' ].

	scaleFactor := anInteger
]

{ #category : #accessing }
LeExampleToPngExporter >> width [
	^ width
]

{ #category : #accessing }
LeExampleToPngExporter >> width: anInteger [
	self assert: [ anInteger isNotNil ] description: [ 'Width must be non-nil' ].

	width := anInteger
]

{ #category : #'api - initialization' }
LeExampleToPngExporter >> withScripter [
	useScripter := true
]

{ #category : #'api - initialization' }
LeExampleToPngExporter >> withoutScripter [
	useScripter := false
]
