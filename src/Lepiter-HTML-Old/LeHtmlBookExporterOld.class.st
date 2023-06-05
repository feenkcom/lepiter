Class {
	#name : #LeHtmlBookExporterOld,
	#superclass : #Object,
	#instVars : [
		'database',
		'pageLinks',
		'resourcesExporter',
		'idGenerator',
		'decorator',
		'mainPage',
		'exportTime'
	],
	#category : #'Lepiter-HTML-Old-Page Exporter'
}

{ #category : #accessing }
LeHtmlBookExporterOld >> database [
	^ database
]

{ #category : #accessing }
LeHtmlBookExporterOld >> database: anObject [
	database := anObject
]

{ #category : #accessing }
LeHtmlBookExporterOld >> decorator [
	<return: #LeHtmlPageDecorator>
	^ decorator
]

{ #category : #'api - exporting' }
LeHtmlBookExporterOld >> decorator: aDecorator [
	decorator := aDecorator
]

{ #category : #accessing }
LeHtmlBookExporterOld >> ensurePageLinks [
	pageLinks ifNotNil: [ ^ self ].

	pageLinks := LeExportPageLinksBuilder new
			database: database;
			mainPage: mainPage;
			html;
			sequencer: idGenerator;
			build;
			links
]

{ #category : #'api - exporting' }
LeHtmlBookExporterOld >> export [
	exportTime := [

		self ensurePageLinks.
		
		pageLinks do: [ :aPageLink | 
			self exportPageLink: aPageLink ].
		
		decorator ifNotNil: [ 
			decorator addResourcesInto: resourcesExporter ]
		
	 ] timeToRun.
]

{ #category : #'api - exporting' }
LeHtmlBookExporterOld >> exportPageLink: aPageLink [
	LeHtmlPageExporterOld new
		pageLink: aPageLink;
		pageLinks: pageLinks;
		resourcesExporter: resourcesExporter;
		decorator: (LeHtmlBookDecorator new pageDecorator: decorator);
		withBookNavigation: database pageLinks: pageLinks;
		shouldGenerateHeader: true;
		export
]

{ #category : #'gt - extensions' }
LeHtmlBookExporterOld >> gtResourcesFor: aView [
	<gtView>
	resourcesExporter ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Resources';
		priority: 1;
		object: [ resourcesExporter ];
		view: #gtResourcesFor:
]

{ #category : #'api - initialization' }
LeHtmlBookExporterOld >> integerGenerator [
	self sequencer: XdSequenceNumberGenerator new
]

{ #category : #accessing }
LeHtmlBookExporterOld >> mainPage [
	"Return a {{gtClass:LePage}} instance that should be displayed 
	by default, e.g., as `index.html` in case of the HTML export."

	<return: #LePage>
	^ mainPage
]

{ #category : #accessing }
LeHtmlBookExporterOld >> mainPage: aLePage [
	"Set a {{gtClass:LePage}} instance that should be displayed 
	by default, e.g., as `index.html` in case of the HTML export."

	mainPage := aLePage
]

{ #category : #accessing }
LeHtmlBookExporterOld >> pageLinks [
	^ pageLinks
]

{ #category : #accessing }
LeHtmlBookExporterOld >> pageLinks: anObject [
	pageLinks := anObject
]

{ #category : #accessing }
LeHtmlBookExporterOld >> resourcesExporter [
	^ resourcesExporter
]

{ #category : #accessing }
LeHtmlBookExporterOld >> resourcesExporter: anObject [
	resourcesExporter := anObject
]

{ #category : #convenience }
LeHtmlBookExporterOld >> saveToRootDirectory: aDirectory [
	LeExportResourcesDirectorySaver new
		resources: resourcesExporter;
		rootDirectory: aDirectory;
		save
]

{ #category : #accessing }
LeHtmlBookExporterOld >> sequencer [
	^ idGenerator
]

{ #category : #accessing }
LeHtmlBookExporterOld >> sequencer: anObject [
	idGenerator := anObject
]

{ #category : #'api - initialization' }
LeHtmlBookExporterOld >> uuidSequencer [
	self sequencer: XdUUIDGenerator new
]

{ #category : #'api - initialization' }
LeHtmlBookExporterOld >> withFileAssets: aRootDirectory [
	self
		decorator: (LeHtmlPageDirectoryAssetsDecorator new rootDiretory: aRootDirectory)
]

{ #category : #'api - initialization' }
LeHtmlBookExporterOld >> withGtBookAssets [
	self withFileAssets: FileLocator gtResource 
		/ 'feenkcom/lepiter/doc/gtbook/assets'
]

{ #category : #'api - initialization' }
LeHtmlBookExporterOld >> withLocalAssets [
	self withLocalAssets: true
]

{ #category : #'api - initialization' }
LeHtmlBookExporterOld >> withLocalAssets: aBoolean [
	self decorator: (LeHtmlPageDecorator withLocalAssets: aBoolean)
]

{ #category : #'api - initialization' }
LeHtmlBookExporterOld >> withRemoteAssets [
	self withLocalAssets: false
]
