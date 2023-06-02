Class {
	#name : #LeHtmlContextOld,
	#superclass : #Object,
	#instVars : [
		'stream',
		'resources',
		'htmlStream',
		'sequencer',
		'fileStore',
		'log'
	],
	#category : #'Lepiter-HTML-Old-! New - Exporter'
}

{ #category : #'api - builders' }
LeHtmlContextOld >> assembler [
	^ LeExportResourceAssembler2 new context: self
]

{ #category : #initialization }
LeHtmlContextOld >> defaultFileStore [
	^ LeExportMemoryStore new
]

{ #category : #initialization }
LeHtmlContextOld >> defaultLog [
	^ LeExportLog new
]

{ #category : #initialization }
LeHtmlContextOld >> defaultResources [
	^ LeExportResources2 new
]

{ #category : #initialization }
LeHtmlContextOld >> defaultSequencer [
	^ LeExportIntegerSequencer new
]

{ #category : #'api - accessing' }
LeHtmlContextOld >> fileStore [
	<return: #TLeExportFileStore>
	^ fileStore ifNil: [ fileStore := self defaultFileStore ]
]

{ #category : #'api - initialization' }
LeHtmlContextOld >> fileStore: aLeExportFileStore [
	self
		assert: [ aLeExportFileStore isNotNil ]
		description: [ 'File store must be non-nil' ].
	self
		assert: [ sequencer isNil ]
		description: [ 'File store must be initialized only once' ].
	
	fileStore := aLeExportFileStore
]

{ #category : #'gt - extensions' }
LeHtmlContextOld >> gtFilesFor: aView [
	<gtView>
	fileStore ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Files';
		priority: 20;
		object: [ fileStore ];
		view: #gtFilesFor:
]

{ #category : #'gt - extensions' }
LeHtmlContextOld >> gtLogFor: aView [
	<gtView>
	log ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Log';
		priority: 20;
		object: [ log ];
		view: #gtLogItemsFor:
]

{ #category : #'gt - extensions' }
LeHtmlContextOld >> gtResourcesFor: aView [
	<gtView>
	resources ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Resources';
		priority: 15;
		object: [ resources ];
		view: #gtResourcesFor:
]

{ #category : #'gt - extensions' }
LeHtmlContextOld >> gtStreamStateFor: aView [
	<gtView>
	stream ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'HTML';
		priority: 10;
		object: [ stream ];
		view: #gtStreamStateFor:
]

{ #category : #'api - accessing' }
LeHtmlContextOld >> html [
	"Return HTML output stream.
	Currently we use {{gtClass:ZnHtmlOutputStream}} API to write HTML source code.
	{{gtClass:LeHtmlOutputPrettyStream}} is a pretty-print variant."

	<return: #ZnHtmlOutputStream>
	self
		assert: [ stream isNotNil ]
		description: [ 'Output stream must be non-nil' ].

	^ htmlStream
		ifNil: [ (stream isKindOf: ZnHtmlOutputStream)
				ifTrue: [ htmlStream := stream ]
				ifFalse: [ htmlStream := LeHtmlOutputPrettyStream on: stream ] ]
]

{ #category : #'api - accessing' }
LeHtmlContextOld >> log [
	<return: #TLeExportLog>
	^ log ifNil: [ log := self defaultLog ]
]

{ #category : #'api - builders' }
LeHtmlContextOld >> logger [
	^ LeExportLogger new context: self
]

{ #category : #'api - builders' }
LeHtmlContextOld >> nextFileReferenceTo: aRelativePath [
	<return: #FileReference>
	^ self fileStore nextFileReferenceTo: aRelativePath
]

{ #category : #'api - builders' }
LeHtmlContextOld >> nextSequenceId [
	<return: #String>
	^ self sequencer nextId
]

{ #category : #'api - builders' }
LeHtmlContextOld >> resourcer [
	^ LeExportResourceBuilder2 new context: self
]

{ #category : #'api - accessing' }
LeHtmlContextOld >> resources [
	<return: #LeExportResources2>
	^ resources ifNil: [ resources := self defaultResources ]
]

{ #category : #'api - initialization' }
LeHtmlContextOld >> resources: aLeExportResources [
	self
		assert: [ aLeExportResources isNotNil ]
		description: [ 'Resources must be non-nil' ].
	self
		assert: [ resources isNil ]
		description: [ 'Resources must be initialized only once' ].
	
	resources := aLeExportResources
]

{ #category : #'api - accessing' }
LeHtmlContextOld >> sequencer [
	<return: #TLeExportSequencer>
	^ sequencer ifNil: [ sequencer := self defaultSequencer ]
]

{ #category : #'api - initialization' }
LeHtmlContextOld >> sequencer: aLeSequencer [
	self
		assert: [ aLeSequencer isNotNil ]
		description: [ 'Sequencer must be non-nil' ].
	self
		assert: [ sequencer isNil ]
		description: [ 'Sequencer must be initialized only once' ].
	
	sequencer := aLeSequencer
]

{ #category : #'api - initialization' }
LeHtmlContextOld >> stream: aWriteStream [
	self
		assert: [ aWriteStream isNotNil ]
		description: [ 'Output stream must be non-nil' ].
	self
		assert: [ stream isNil ]
		description: [ 'Output stream must be initialized only once' ].
	
	stream := aWriteStream
]
