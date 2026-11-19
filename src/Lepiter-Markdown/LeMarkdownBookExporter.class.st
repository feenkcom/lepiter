"
Database exporter using shared page naming, resource assembly and directory saving infrastructure.
"
Class {
	#name : #LeMarkdownBookExporter,
	#superclass : #Object,
	#instVars : [
		'database',
		'mainPage',
		'context',
		'pageLinks',
		'exporters',
		'fileStore',
		'log',
		'sequencer',
		'resources'
	],
	#category : #'Lepiter-Markdown-Core'
}

{ #category : #exporting }
LeMarkdownBookExporter >> assembleResources [
	LeExportResourcesAssembler new
		resources: self resources;
		assemble
]

{ #category : #exporting }
LeMarkdownBookExporter >> buildResources [
	"Prepare page links and discover resources for every page before rendering."

	pageLinks := LeExportPageLinksBuilder new
			database: database;
			mainPage: mainPage;
			sequencer: self sequencer;
			fileExtension: 'md';
			build;
			links.
	exporters := OrderedCollection new.
	pageLinks
		do: [ :link | 
			| pageContext exporter |
			pageContext := LeMarkdownContext new
					page: link page;
					pageLinks: pageLinks;
					resources: self resources;
					sequencer: self sequencer;
					fileStore: self fileStore;
					log: self log.
			exporter := LeMarkdownPageExporter new context: pageContext.
			exporter buildResources.
			exporters add: exporter ]
]

{ #category : #accessing }
LeMarkdownBookExporter >> database: anObject [
	database := anObject
]

{ #category : #accessing }
LeMarkdownBookExporter >> defaultFileStore [
	^ LeExportTempDirectoryStore new
]

{ #category : #accessing }
LeMarkdownBookExporter >> defaultLog [
	^ LeExportLog new
]

{ #category : #accessing }
LeMarkdownBookExporter >> defaultResources [
	^ LeExportResources new
]

{ #category : #accessing }
LeMarkdownBookExporter >> defaultSequencer [
	^ LeExportIntegerSequencer new
]

{ #category : #exporting }
LeMarkdownBookExporter >> export [
	self buildResources.
	self exportMarkdown.
	self assembleResources.
	^ self
]

{ #category : #exporting }
LeMarkdownBookExporter >> exportMarkdown [
	"Render prepared page exporters without rediscovering their resources."

	exporters ifNil: [ self error: 'Call buildResources before exportMarkdown' ].
	exporters
		do: [ :exporter | 
			| link |
			exporter exportMarkdown.
			pageLinks
				do: [ :each | each page == exporter context page ifTrue: [ link := each ] ].
			self resources
				addResource: (LeExportPageOutputResource new
						content: exporter contents;
						pageLink: link) ].
	^ self
]

{ #category : #accessing }
LeMarkdownBookExporter >> exporters [
	^ exporters ifNil: [ #() ]
]

{ #category : #accessing }
LeMarkdownBookExporter >> fileStore [
	^ fileStore ifNil: [ fileStore := self defaultFileStore ]
]

{ #category : #accessing }
LeMarkdownBookExporter >> fileStore: aFileStore [
	fileStore := aFileStore
]

{ #category : #views }
LeMarkdownBookExporter >> gtPagesFor: aView [
	"Which page exports make up this book?"

	<gtView>
	^ aView list
		title: 'Pages';
		priority: 10;
		items: [ self exporters ]
]

{ #category : #views }
LeMarkdownBookExporter >> gtResourcesFor: aView [
	"Which files will be saved with this book?"

	<gtView>
	resources ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Resources';
		priority: 20;
		object: [ self resources ];
		view: #gtResourcesGroupedBySourceTypeFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Details'
			tooltip: 'Inspect resources'
			action: [ :aButton | aButton phlow spawnObject: self resources ]
]

{ #category : #accessing }
LeMarkdownBookExporter >> log [
	<return: #TLeExportLog>
	^ log ifNil: [ log := self defaultLog ]
]

{ #category : #accessing }
LeMarkdownBookExporter >> log: anObject [
	log := anObject
]

{ #category : #accessing }
LeMarkdownBookExporter >> mainPage: anObject [
	mainPage := anObject
]

{ #category : #accessing }
LeMarkdownBookExporter >> pageLinks [
	^ pageLinks
]

{ #category : #accessing }
LeMarkdownBookExporter >> resources [
	^ resources ifNil: [ resources := self defaultResources ]
]

{ #category : #accessing }
LeMarkdownBookExporter >> resources: anObject [
	resources := anObject
]

{ #category : #exporting }
LeMarkdownBookExporter >> saveToRootDirectory: aDirectory [
	aDirectory ensureCreateDirectory.
	LeExportResourcesDirectorySaver new
		resources: self resources;
		rootDirectory: aDirectory;
		save
]

{ #category : #accessing }
LeMarkdownBookExporter >> sequencer [
	<return: #TLeExportSequencer>
	^ sequencer ifNil: [ sequencer := self defaultSequencer ]
]

{ #category : #accessing }
LeMarkdownBookExporter >> sequencer: anObject [
	sequencer := anObject
]
