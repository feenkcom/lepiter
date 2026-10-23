Class {
	#name : #LeHtmlBookExporter,
	#superclass : #Object,
	#instVars : [
		'database',
		'pageLinks',
		'resources',
		'sequencer',
		'mainPage',
		'log',
		'piece',
		'resourceTime',
		'htmlTime',
		'fileStore',
		'hrefBuilder',
		'siteName',
		'baseUrl'
	],
	#category : #'Lepiter-HTML-! Core'
}

{ #category : #'api - exporting' }
LeHtmlBookExporter >> addAssetResourcesFrom: aDirectory [
	LeHtmlAssetsUtility addAssetResourcesFrom: aDirectory into: self resources
]

{ #category : #'api - exporting' }
LeHtmlBookExporter >> addGtBookAssets [
	LeHtmlAssetsUtility addGtBookAssetsInto: self resources
]

{ #category : #'api - exporting' }
LeHtmlBookExporter >> assembleNewResources: aDirectory [
	"If a resource is found in the output directory, do not assemble it."

	resourceTime := [ 
	
		LeExportResourcesAssembler new
			resources: self resources;
			condition: (LeExportNewResourceCondition new rootDirectory: aDirectory);
			assemble 
			
	] timeToRun
]

{ #category : #'api - exporting' }
LeHtmlBookExporter >> assembleResources [
	resourceTime := [ 
	
		LeExportResourcesAssembler new
			resources: self resources;
			assemble 
	
	] timeToRun
]

{ #category : #accessing }
LeHtmlBookExporter >> baseUrl [
	^ baseUrl
]

{ #category : #accessing }
LeHtmlBookExporter >> baseUrl: aStringOrUrl [
	"Set the URL under which the exported pages are published. A default one of the URL piece is used if it is nil."

	baseUrl := aStringOrUrl
]

{ #category : #accessing }
LeHtmlBookExporter >> database [
	^ database
]

{ #category : #accessing }
LeHtmlBookExporter >> database: anObject [
	database := anObject
]

{ #category : #initialization }
LeHtmlBookExporter >> defaultFileStore [
	^ LeExportTempDirectoryStore new
]

{ #category : #accessing }
LeHtmlBookExporter >> defaultHrefBuilder [
	^ LeExportFilenameAndExtensionHypertextReferenceBuilder new
]

{ #category : #accessing }
LeHtmlBookExporter >> defaultLog [
	^ LeExportLog new
]

{ #category : #initialization }
LeHtmlBookExporter >> defaultResources [
	^ LeExportResources new
]

{ #category : #initialization }
LeHtmlBookExporter >> defaultSequencer [
	^ LeExportIntegerSequencer new
]

{ #category : #'private - exporting' }
LeHtmlBookExporter >> ensurePageLinks [
	pageLinks ifNotNil: [ ^ self ].

	pageLinks := LeExportPageLinksBuilder new
			database: database;
			mainPage: mainPage;
			html;
			sequencer: sequencer;
			build;
			links
]

{ #category : #'api - exporting' }
LeHtmlBookExporter >> export [
	self exportHtml.
	self assembleResources.
]

{ #category : #'api - exporting' }
LeHtmlBookExporter >> exportHtml [
	htmlTime := [

		self ensurePageLinks.
		
		pageLinks do: [ :aPageLink | 
			self exportPageLink: aPageLink ].

	 ] timeToRun.
]

{ #category : #'api - exporting' }
LeHtmlBookExporter >> exportPageLink: aPageLink [

	| aContext anHtml |
	aContext := LeHtmlContext new
		page: aPageLink page;
		pageLinks: self pageLinks;
		resources: self resources;
		database: self database;
		siteName: self siteName;
		baseUrl: self baseUrl;
		sequencer: self sequencer;
		fileStore: self fileStore;
		hrefBuilder: self hrefBuilder;
		log: self log.

	anHtml := LeHtmlPageExporter new
		context: aContext;
		piece: self piece;
		contentsDo: [ :theExporter | theExporter export ].
		
	resources addResource: (LeExportPageOutputResource new 
		content: anHtml;
		pageLink: aPageLink)
]

{ #category : #accessing }
LeHtmlBookExporter >> fileStore [
	^ fileStore ifNil: [ fileStore := self defaultFileStore ]
]

{ #category : #accessing }
LeHtmlBookExporter >> fileStore: aFileStore [
	fileStore := aFileStore
]

{ #category : #'gt - extensions' }
LeHtmlBookExporter >> gtLinksFor: aView [
	<gtView>
	pageLinks ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Links';
		priority: 30;
		object: [ pageLinks ];
		view: #gtLinksFor:
]

{ #category : #'gt - extensions' }
LeHtmlBookExporter >> gtLogFor: aView [
	<gtView>
	log ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Log';
		priority: 20;
		object: [ log ];
		view: #gtLogItemsGroupedBySourceTypeFor:
]

{ #category : #'gt - extensions' }
LeHtmlBookExporter >> gtResourcesFor: aView [
	<gtView>
	resources ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Resources';
		priority: 15;
		object: [ resources ];
		view: #gtResourcesGroupedBySourceTypeFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Details'
			tooltip: 'Inspect resources'
			action: [ :aButton | aButton phlow spawnObject: resources ]
]

{ #category : #accessing }
LeHtmlBookExporter >> hrefBuilder [
	<return: #TLeExportHypertextReferenceBuilder>
	^ hrefBuilder ifNil: [ hrefBuilder := self defaultHrefBuilder ]
]

{ #category : #accessing }
LeHtmlBookExporter >> hrefBuilder: aBuilder [
	hrefBuilder := aBuilder
]

{ #category : #'api - initialization' }
LeHtmlBookExporter >> integerSequencer [
	self sequencer: LeExportIntegerSequencer new
]

{ #category : #accessing }
LeHtmlBookExporter >> log [
	<return: #TLeExportLog>
	^ log ifNil: [ log := self defaultLog ]
]

{ #category : #accessing }
LeHtmlBookExporter >> log: anObject [
	log := anObject
]

{ #category : #accessing }
LeHtmlBookExporter >> mainPage [
	^ mainPage
]

{ #category : #accessing }
LeHtmlBookExporter >> mainPage: anObject [
	mainPage := anObject
]

{ #category : #accessing }
LeHtmlBookExporter >> pageLinks [
	^ pageLinks
]

{ #category : #accessing }
LeHtmlBookExporter >> pageLinks: anObject [
	pageLinks := anObject
]

{ #category : #accessing }
LeHtmlBookExporter >> piece [
	<return: #TLeHtmlPiece>
	^ piece ifNil: [ piece := LeHtmlPagePiece new ]
]

{ #category : #accessing }
LeHtmlBookExporter >> piece: aTLeHtmlPiece [
	piece := aTLeHtmlPiece
]

{ #category : #accessing }
LeHtmlBookExporter >> resources [
	^ resources ifNil: [ resources := self defaultResources ]
]

{ #category : #accessing }
LeHtmlBookExporter >> resources: anObject [
	resources := anObject
]

{ #category : #convenience }
LeHtmlBookExporter >> saveToRootDirectory: aDirectory [
	LeExportResourcesDirectorySaver new
		resources: resources;
		rootDirectory: aDirectory;
		save
]

{ #category : #accessing }
LeHtmlBookExporter >> sequencer [
	<return: #TLeExportSequencer>
	^ sequencer ifNil: [ sequencer := self defaultSequencer ]
]

{ #category : #accessing }
LeHtmlBookExporter >> sequencer: anObject [
	sequencer := anObject
]

{ #category : #accessing }
LeHtmlBookExporter >> siteName [
	<return: #String or: nil>
	^ siteName
]

{ #category : #accessing }
LeHtmlBookExporter >> siteName: aString [
	"Set the name of the site. The name of the database is used if it is nil."

	siteName := aString
]

{ #category : #'api - initialization' }
LeHtmlBookExporter >> uuidSequencer [
	self sequencer: LeExportUUIDSequencer new
]
