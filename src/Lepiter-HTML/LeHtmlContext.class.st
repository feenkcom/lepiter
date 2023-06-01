Class {
	#name : #LeHtmlContext,
	#superclass : #Object,
	#instVars : [
		'stream',
		'resources',
		'htmlStream',
		'sequencer',
		'fileStore',
		'log'
	],
	#category : #'Lepiter-HTML-! New - Exporter'
}

{ #category : #'api - builders' }
LeHtmlContext >> assembler [
	^ LeExportResourceAssembler new context: self
]

{ #category : #initialization }
LeHtmlContext >> defaultFileStore [
	^ LeExportMemoryStore new
]

{ #category : #initialization }
LeHtmlContext >> defaultLog [
	^ LeExportLog new
]

{ #category : #initialization }
LeHtmlContext >> defaultResources [
	^ LeExportResources2 new
]

{ #category : #initialization }
LeHtmlContext >> defaultSequencer [
	^ LeExportIntegerSequencer new
]

{ #category : #'api - accessing' }
LeHtmlContext >> fileStore [
	<return: #TLeExportFileStore>
	^ fileStore ifNil: [ fileStore := self defaultFileStore ]
]

{ #category : #'api - initialization' }
LeHtmlContext >> fileStore: aLeExportFileStore [
	self
		assert: [ aLeExportFileStore isNotNil ]
		description: [ 'File store must be non-nil' ].
	self
		assert: [ sequencer isNil ]
		description: [ 'File store must be initialized only once' ].
	
	fileStore := aLeExportFileStore
]

{ #category : #'gt - extensions' }
LeHtmlContext >> gtFilesFor: aView [
	<gtView>
	fileStore ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Files';
		priority: 20;
		object: [ fileStore ];
		view: #gtFilesFor:
]

{ #category : #'gt - extensions' }
LeHtmlContext >> gtLogFor: aView [
	<gtView>
	log ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Log';
		priority: 20;
		object: [ log ];
		view: #gtLogItemsFor:
]

{ #category : #'gt - extensions' }
LeHtmlContext >> gtResourcesFor: aView [
	<gtView>
	resources ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Resources';
		priority: 15;
		object: [ resources ];
		view: #gtResourcesFor:
]

{ #category : #'gt - extensions' }
LeHtmlContext >> gtStreamStateFor: aView [
	<gtView>
	stream ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'HTML';
		priority: 10;
		object: [ stream ];
		view: #gtStreamStateFor:
]

{ #category : #'api - accessing' }
LeHtmlContext >> html [
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
LeHtmlContext >> log [
	<return: #TLeExportLog>
	^ log ifNil: [ log := self defaultLog ]
]

{ #category : #'api - builders' }
LeHtmlContext >> logger [
	^ LeExportLogger new context: self
]

{ #category : #'api - builders' }
LeHtmlContext >> nextFileReferenceTo: aRelativePath [
	<return: #FileReference>
	^ self fileStore nextFileReferenceTo: aRelativePath
]

{ #category : #'api - builders' }
LeHtmlContext >> nextSequenceId [
	<return: #String>
	^ self sequencer nextId
]

{ #category : #'api - builders' }
LeHtmlContext >> resourcer [
	^ LeExportResourceBuilder2 new context: self
]

{ #category : #'api - accessing' }
LeHtmlContext >> resources [
	<return: #LeExportResources2>
	^ resources ifNil: [ resources := self defaultResources ]
]

{ #category : #'api - initialization' }
LeHtmlContext >> resources: aLeExportResources [
	self
		assert: [ aLeExportResources isNotNil ]
		description: [ 'Resources must be non-nil' ].
	self
		assert: [ resources isNil ]
		description: [ 'Resources must be initialized only once' ].
	
	resources := aLeExportResources
]

{ #category : #'api - accessing' }
LeHtmlContext >> sequencer [
	<return: #TLeExportSequencer>
	^ sequencer ifNil: [ sequencer := self defaultSequencer ]
]

{ #category : #'api - initialization' }
LeHtmlContext >> sequencer: aLeSequencer [
	self
		assert: [ aLeSequencer isNotNil ]
		description: [ 'Sequencer must be non-nil' ].
	self
		assert: [ sequencer isNil ]
		description: [ 'Sequencer must be initialized only once' ].
	
	sequencer := aLeSequencer
]

{ #category : #'api - initialization' }
LeHtmlContext >> stream: aWriteStream [
	self
		assert: [ aWriteStream isNotNil ]
		description: [ 'Output stream must be non-nil' ].
	self
		assert: [ stream isNil ]
		description: [ 'Output stream must be initialized only once' ].
	
	stream := aWriteStream
]
