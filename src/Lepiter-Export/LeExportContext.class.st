Class {
	#name : #LeExportContext,
	#superclass : #Object,
	#traits : 'TLeExportContext',
	#classTraits : 'TLeExportContext classTrait',
	#instVars : [
		'specifications',
		'resources',
		'sequencer',
		'fileStore',
		'log'
	],
	#category : #'Lepiter-Export-! Core'
}

{ #category : #accessing }
LeExportContext >> assembler [
	"Return resources assembler that exports resources"

	<return: #TLeExportResourcesAssembler>
	^ LeExportResourcesAssembler new
		resources: self resources
]

{ #category : #initialization }
LeExportContext >> defaultFileStore [
	^ LeExportMemoryStore new
]

{ #category : #initialization }
LeExportContext >> defaultLog [
	^ LeExportLog new
]

{ #category : #initialization }
LeExportContext >> defaultResources [
	^ LeExportResources new
]

{ #category : #initialization }
LeExportContext >> defaultSequencer [
	^ LeExportIntegerSequencer new
]

{ #category : #initialization }
LeExportContext >> defaultSpecifications [
	^ LeSpecificationBuilder new
		start: self defaultSpecificationsStart;
		find;
		specifications
]

{ #category : #initialization }
LeExportContext >> defaultSpecificationsStart [
	^ LeExportSpecificationsStart new
]

{ #category : #accessing }
LeExportContext >> fileStore [
	"Return file store that is used to store resource files"

	<return: #TLeExportFileStore>
	^ fileStore ifNil: [ fileStore := self defaultFileStore ]
]

{ #category : #accessing }
LeExportContext >> fileStore: aLeExportFileStore [
	self
		assert: [ aLeExportFileStore isNotNil ]
		description: [ 'File store must be non-nil' ].
	self
		assert: [ fileStore isNil ]
		description: [ 'File store must be initialized only once' ].
	
	fileStore := aLeExportFileStore
]

{ #category : #'gt - extensions' }
LeExportContext >> gtFilesFor: aView [
	<gtView>
	fileStore ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Files';
		priority: 20;
		object: [ fileStore ];
		view: #gtFilesFor:
]

{ #category : #'gt - extensions' }
LeExportContext >> gtLogFor: aView [
	<gtView>
	log ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Log';
		priority: 20;
		object: [ log ];
		view: #gtLogItemsGroupedBySourceTypeFor:
]

{ #category : #'gt - extensions' }
LeExportContext >> gtResourcesFor: aView [
	<gtView>
	resources ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Resources';
		priority: 15;
		object: [ resources ];
		view: #gtResourcesGroupedBySourceTypeFor:
]

{ #category : #accessing }
LeExportContext >> log [
	<return: #TLeExportLog>
	^ log ifNil: [ log := self defaultLog ]
]

{ #category : #accessing }
LeExportContext >> log: aLog [
	self
		assert: [ aLog isNotNil ]
		description: [ 'Log must be non-nil' ].
	self
		assert: [ log isNil ]
		description: [ 'Log must be initialized only once' ].
	
	log := aLog
]

{ #category : #accessing }
LeExportContext >> logger [
	"Return resources assembler that exports resources"

	<return: #TLeExportLogger>
	^ LeExportLogger new
		log: self log
]

{ #category : #'api - builders' }
LeExportContext >> objectSpecificationBuilder [
	^ LeExportObjectSpecificationBuilder new
		specifications: self specifications;
		find
]

{ #category : #'api - builders' }
LeExportContext >> objectSpecificationFor: anObject [
	"Return object specification for a given object"

	<return: #TLeExportObjectSpecification>
	^ self objectSpecificationBuilder
		object: anObject;
		find;
		objectSpecification
]

{ #category : #accessing }
LeExportContext >> resources [
	"Return object specification for a given object"

	<return: #TLeExportResources>
	^ resources ifNil: [ resources := self defaultResources ]
]

{ #category : #'api - initialization' }
LeExportContext >> resources: aLeExportResources [
	self
		assert: [ aLeExportResources isNotNil ]
		description: [ 'Resources must be non-nil' ].
	self
		assert: [ resources isNil ]
		description: [ 'Resources must be initialized only once' ].
	
	resources := aLeExportResources
]

{ #category : #accessing }
LeExportContext >> sequencer [
	"Return sequencer that generates unique IDs"

	<return: #TLeExportSequencer>
	^ sequencer ifNil: [ sequencer := self defaultSequencer ]
]

{ #category : #accessing }
LeExportContext >> sequencer: aLeSequencer [
	self
		assert: [ aLeSequencer isNotNil ]
		description: [ 'Sequencer must be non-nil' ].
	self
		assert: [ sequencer isNil ]
		description: [ 'Sequencer must be initialized only once' ].
	
	sequencer := aLeSequencer
]

{ #category : #accessing }
LeExportContext >> specifications [
	<return: #TLeExportSpecifications>
	^ specifications ifNil: [ specifications := self defaultSpecifications ]
]

{ #category : #accessing }
LeExportContext >> specifications: aTLeExportSpecifications [
	specifications := aTLeExportSpecifications
]
