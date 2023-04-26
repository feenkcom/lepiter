Class {
	#name : #LeHtmlBookExporter,
	#superclass : #Object,
	#instVars : [
		'database',
		'pageLinks',
		'resourcesExporter',
		'idGenerator',
		'decorator'
	],
	#category : #'Lepiter-HTML-Page Exporter'
}

{ #category : #accessing }
LeHtmlBookExporter >> database [
	^ database
]

{ #category : #accessing }
LeHtmlBookExporter >> database: anObject [
	database := anObject
]

{ #category : #accessing }
LeHtmlBookExporter >> decorator [
	<return: #LeHtmlPageDecorator>
	^ decorator
]

{ #category : #'api - exporting' }
LeHtmlBookExporter >> decorator: aDecorator [
	decorator := aDecorator
]

{ #category : #accessing }
LeHtmlBookExporter >> ensurePageLinks [
	pageLinks ifNotNil: [ ^ self ].

	pageLinks := LeBookPageLinksBuilder new
			database: database;
			html;
			idGenerator: idGenerator;
			build;
			links
]

{ #category : #'api - exporting' }
LeHtmlBookExporter >> export [
	self ensurePageLinks.
	
	pageLinks do: [ :aPageLink | 
		self exportPageLink: aPageLink ].
	
	decorator ifNotNil: [ 
		decorator addResourcesInto: resourcesExporter ]
]

{ #category : #'api - exporting' }
LeHtmlBookExporter >> exportPageLink: aPageLink [
	LeHtmlPageExporter new
		pageLink: aPageLink;
		pageLinks: pageLinks;
		resourcesExporter: resourcesExporter;
		decorator: (LeHtmlBookDecorator new pageDecorator: decorator);
		shouldGenerateHeader: true;
		export
]

{ #category : #'gt - extensions' }
LeHtmlBookExporter >> gtResourcesFor: aView [
	<gtView>
	resourcesExporter ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Resources';
		priority: 1;
		object: [ resourcesExporter ];
		view: #gtResourcesFor:
]

{ #category : #accessing }
LeHtmlBookExporter >> idGenerator [
	^ idGenerator
]

{ #category : #accessing }
LeHtmlBookExporter >> idGenerator: anObject [
	idGenerator := anObject
]

{ #category : #'api - initialization' }
LeHtmlBookExporter >> integerGenerator [
	self idGenerator: XdSequenceNumberGenerator new
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
LeHtmlBookExporter >> resourcesExporter [
	^ resourcesExporter
]

{ #category : #accessing }
LeHtmlBookExporter >> resourcesExporter: anObject [
	resourcesExporter := anObject
]

{ #category : #'api - initialization' }
LeHtmlBookExporter >> uuidGenerator [
	self idGenerator: XdUUIDGenerator new
]

{ #category : #'api - initialization' }
LeHtmlBookExporter >> withLocalAssets [
	self withLocalAssets: true
]

{ #category : #'api - initialization' }
LeHtmlBookExporter >> withLocalAssets: aBoolean [
	self decorator: (LeHtmlPageDecorator withLocalAssets: aBoolean)
]

{ #category : #'api - initialization' }
LeHtmlBookExporter >> withRemoteAssets [
	self withLocalAssets: false
]
