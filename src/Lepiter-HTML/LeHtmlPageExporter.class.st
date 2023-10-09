Class {
	#name : #LeHtmlPageExporter,
	#superclass : #Object,
	#instVars : [
		'context',
		'piece'
	],
	#category : #'Lepiter-HTML-! Core'
}

{ #category : #convenience }
LeHtmlPageExporter class >> exportPage: page to: directory [
	| pageLinks context database html pageLinkBuilder |
	database := page database.
	context := LeHtmlContext new
			page: page;
			database: database.
	
	pageLinkBuilder := LeExportPageLinksBuilder new
			in: [ :theBuilder | database ifNotNil: [ theBuilder database: database ] ];
			mainPage: page;
			sequencer: context sequencer;
			html;
			build.
	pageLinks := pageLinkBuilder links.
	context pageLinks: pageLinks.
	
	LeHtmlAssetsUtility addGtBookAssetsInto: context resources.

	html := LeHtmlPageExporter new
			context: context;
			piece: LeHtmlGtBookPiece gtSinglePage;
			contents.

	context resources
		addResource: (LeExportPageOutputResource new
				content: html;
				hrefBuilder: context hrefBuilder;
				pageLink: (pageLinks
						linkForPage: page
						ifFound: [ :thePage | thePage ]
						ifNone: [  "ignore" ])).
						
	context assembler assemble.
						
	LeExportResourcesDirectorySaver new
		resources: context resources;
		rootDirectory: directory;
		save.

	^ LeHtmlPage new
		directory: directory;
		pageFile: directory / pageLinkBuilder mainFileName;
		resources: context resources;
		log: context log
]

{ #category : #'api - exporting' }
LeHtmlPageExporter >> buildResources [
	| visitor |
	visitor := LeExportVisitor new.
	visitor context: context.
	
	context page acceptVisitor: visitor
]

{ #category : #convenience }
LeHtmlPageExporter >> contents [
	<return: #String>
	^ String streamContents: [ :aStream |
		context stream: aStream.
		self export. ]
]

{ #category : #convenience }
LeHtmlPageExporter >> contentsDo: aBlock [
	<return: #String>
	^ String streamContents: [ :aStream |
		context stream: aStream.
		aBlock cull: self cull: aStream. ]
]

{ #category : #accessing }
LeHtmlPageExporter >> context [
	^ context ifNil: [ context := LeHtmlContext new ]
]

{ #category : #'api - initialization' }
LeHtmlPageExporter >> context: anObject [
	context := anObject
]

{ #category : #'api - exporting' }
LeHtmlPageExporter >> export [
	self buildResources.
	self exportHtml
]

{ #category : #'api - exporting' }
LeHtmlPageExporter >> exportHtml [
	self piece writeWithContext: context
]

{ #category : #'gt - extensions' }
LeHtmlPageExporter >> gtFilesFor: aView [
	<gtView>
	context ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Files';
		priority: 20;
		object: [ context ];
		view: #gtFilesFor:
]

{ #category : #'gt - extensions' }
LeHtmlPageExporter >> gtLogFor: aView [
	<gtView>
	context ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Log';
		priority: 20;
		object: [ context ];
		view: #gtLogFor:
]

{ #category : #'gt - extensions' }
LeHtmlPageExporter >> gtPageFor: aView [
	<gtView>
	context ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Page';
		priority: 30;
		object: [ context ];
		view: #gtPageFor:
]

{ #category : #'gt - extensions' }
LeHtmlPageExporter >> gtResourcesFor: aView [
	<gtView>
	context ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Resources';
		priority: 15;
		object: [ context ];
		view: #gtResourcesFor:
]

{ #category : #'gt - extensions' }
LeHtmlPageExporter >> gtStreamStateFor: aView [
	<gtView>
	context ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'HTML';
		priority: 10;
		object: [ context ];
		view: #gtStreamStateFor:
]

{ #category : #'api - initialization' }
LeHtmlPageExporter >> page: aLePage [
	self context page: aLePage
]

{ #category : #accessing }
LeHtmlPageExporter >> piece [
	<return: #TLeHtmlPiece>
	^ piece ifNil: [ piece := LeHtmlPagePiece new ]
]

{ #category : #'api - initialization' }
LeHtmlPageExporter >> piece: aTLeHtmlPiece [
	piece := aTLeHtmlPiece
]
