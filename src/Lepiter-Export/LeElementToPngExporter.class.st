Class {
	#name : #LeElementToPngExporter,
	#superclass : #Object,
	#instVars : [
		'fileReference',
		'height',
		'width',
		'scripter',
		'element',
		'scaleFactor'
	],
	#category : #'Lepiter-Export-Resources - Exporters'
}

{ #category : #asserting }
LeElementToPngExporter >> assertInitialization [
	self 
		assert: [ element isNotNil ] 
		description: [ 'Element must not be nil' ].
	self
		assert: [ fileReference isNotNil ]
		description: [ 'File reference must not be nil' ]
]

{ #category : #accessing }
LeElementToPngExporter >> element [
	^ element
]

{ #category : #accessing }
LeElementToPngExporter >> element: aBlElement [
	element := aBlElement
]

{ #category : #'api - exporting' }
LeElementToPngExporter >> export [
	self assertInitialization.
	
	"Prepare output file"
	fileReference ensureDelete.
	fileReference parent ensureCreateDirectory.
	
	"Prepare the element"
	element removeFromParent.

	"Initialize scripter"
	scripter := BlScripter new.
	scripter space title: element gtDisplayString.
	scripter maxPulseElapsedTime: 60 seconds.
	scripter space extent: width @ height.

	"Add element into a space"
	[
		scripter set 
			label: 'Add element to space';
			element: [ element ];
			play.

	]
		on: BlDevScripterPulseTimeoutError
		do: [ :anException | 
			NonInteractiveTranscript stderr
				show: 'ERROR: Scripter have not finished on time.'; cr;
				show: '       Element: '; show: element gtDisplayString; cr;
				show: '       Exception: '; show: anException; cr;
				show: '       The issue is ignored, proceeding to the PNG export.'; cr.
	].
	
	"Export element to a file"
	BlExporter png
		scaled: scaleFactor;
		background: Color white;
		element: element;
		fileName: fileReference;
		export
]

{ #category : #accessing }
LeElementToPngExporter >> fileReference [
	<return: #FileReference>
	^ fileReference
]

{ #category : #accessing }
LeElementToPngExporter >> fileReference: aFileReference [
	fileReference := aFileReference
]

{ #category : #'gt - extensions' }
LeElementToPngExporter >> gtFigureFor: aView [
	<gtView>
	fileReference ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Picture';
		priority: 10;
		object: [ fileReference ];
		view: #gtFigureFor:
]

{ #category : #'gt - extensions' }
LeElementToPngExporter >> gtScripterPreviewFor: aView [
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
LeElementToPngExporter >> height [
	^ height
]

{ #category : #accessing }
LeElementToPngExporter >> height: anObject [
	height := anObject
]

{ #category : #initialization }
LeElementToPngExporter >> initialize [
	super initialize.

	scaleFactor := LepiterConstants exportFigureScaleFactor.
	width := LepiterConstants defaultExportFigureWidth.
	height := LepiterConstants defaultPreviewHeight.
]

{ #category : #accessing }
LeElementToPngExporter >> scaleFactor [
	^ scaleFactor
]

{ #category : #accessing }
LeElementToPngExporter >> scaleFactor: anObject [
	scaleFactor := anObject
]

{ #category : #accessing }
LeElementToPngExporter >> width [
	^ width
]

{ #category : #accessing }
LeElementToPngExporter >> width: anObject [
	width := anObject
]
