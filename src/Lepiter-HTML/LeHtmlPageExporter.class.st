Class {
	#name : #LeHtmlPageExporter,
	#superclass : #Object,
	#instVars : [
		'resourcesExporter',
		'content',
		'decorator',
		'pageLinks',
		'pageLink',
		'shouldGenerateHeader'
	],
	#category : #'Lepiter-HTML-Page Exporter'
}

{ #category : #accessing }
LeHtmlPageExporter >> content [
	"Return an exported HTML content."

	<return: #String>
	^ content
]

{ #category : #accessing }
LeHtmlPageExporter >> decorator [
	<return: #LeHtmlPageDecorator>
	^ decorator
]

{ #category : #accessing }
LeHtmlPageExporter >> decorator: aLeHTMLPageDecorator [
	decorator := aLeHTMLPageDecorator
]

{ #category : #'api - exporting' }
LeHtmlPageExporter >> export [
	| exportVisitor |
	exportVisitor := LeHtmlPageExporterVisitor new.
	
	shouldGenerateHeader ifNotNil: [ :aBoolean | 
		exportVisitor shouldGenerateHeader: aBoolean ].
	
	resourcesExporter ifNotNil: [ :aWriter | 
		exportVisitor externalPicturesWriter: aWriter ].
		
	pageLinks ifNotNil: [ :aPageLinks | 
		exportVisitor pageLinks: aPageLinks ].
	
	decorator ifNotNil: [ 
		decorator initializeHTMLPageExporter: exportVisitor ].
		
	content := String streamContents: [ :aStream |
		exportVisitor stream: aStream.
		self page acceptVisitor: exportVisitor ].
		
	resourcesExporter ifNotNil: [ :aWriter | 
		aWriter addResource: (LeExportedHtmlResource new
			content: content;
			pageLink: pageLink).
			
		decorator ifNotNil: [ 
			decorator addResourcesInto: resourcesExporter ] ]
]

{ #category : #accessing }
LeHtmlPageExporter >> gtContentFor: aView [
	<gtView>
	^ aView textEditor
		title: 'HTML';
		priority: 5;
		text: [ self content ifNil: [ '' ] ];
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		actionUpdateButton
]

{ #category : #'gt - extensions' }
LeHtmlPageExporter >> gtResourcesFor: aView [
	<gtView>
	resourcesExporter ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Resources';
		priority: 10;
		object: [ resourcesExporter ];
		view: #gtResourcesFor:
]

{ #category : #accessing }
LeHtmlPageExporter >> page [
	<return: #LePage>
	^ self pageLink page
]

{ #category : #accessing }
LeHtmlPageExporter >> pageLink [
	<return: #TLeHtmlBookPageLink>
	^ pageLink
]

{ #category : #accessing }
LeHtmlPageExporter >> pageLink: aPageLink [
	pageLink := aPageLink
]

{ #category : #accessing }
LeHtmlPageExporter >> pageLinks [
	^ pageLinks
]

{ #category : #accessing }
LeHtmlPageExporter >> pageLinks: anObject [
	pageLinks := anObject
]

{ #category : #accessing }
LeHtmlPageExporter >> resourcesExporter [
	<return: #LeResourcesExporter>
	^ resourcesExporter
]

{ #category : #accessing }
LeHtmlPageExporter >> resourcesExporter: aLeResourcesExporter [
	resourcesExporter := aLeResourcesExporter
]

{ #category : #accessing }
LeHtmlPageExporter >> shouldGenerateHeader [
	^ shouldGenerateHeader
]

{ #category : #accessing }
LeHtmlPageExporter >> shouldGenerateHeader: anObject [
	shouldGenerateHeader := anObject
]

{ #category : #'api - initialization' }
LeHtmlPageExporter >> withLocalAssets: aBoolean [
	self decorator: (LeHtmlPageDecorator withLocalAssets: aBoolean)
]
