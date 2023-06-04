Class {
	#name : #LeHtmlPageExporterOld,
	#superclass : #Object,
	#instVars : [
		'resourcesExporter',
		'content',
		'decorator',
		'pageLinks',
		'pageLink',
		'shouldGenerateHeader',
		'exportParts',
		'exportPart'
	],
	#category : #'Lepiter-HTML-Old-Page Exporter'
}

{ #category : #accessing }
LeHtmlPageExporterOld >> content [
	"Return an exported HTML content."

	<return: #String>
	^ content
]

{ #category : #accessing }
LeHtmlPageExporterOld >> decorator [
	<return: #LeHtmlPageDecorator>
	^ decorator
]

{ #category : #accessing }
LeHtmlPageExporterOld >> decorator: aLeHTMLPageDecorator [
	decorator := aLeHTMLPageDecorator
]

{ #category : #convenience }
LeHtmlPageExporterOld >> export [
	| exportVisitor |
	exportVisitor := LeHtmlBookPageExporterVisitor new.
	
	exportVisitor addMetaTag: { #charset -> 'utf-8' }.
	exportVisitor addMetaTag: { #name -> 'viewport'. #content -> 'width=device-width, initial-scale=1' }.
	
	shouldGenerateHeader ifNotNil: [ :aBoolean | 
		exportVisitor shouldGenerateHeader: aBoolean ].
	
	resourcesExporter ifNotNil: [ :aWriter | 
		exportVisitor externalPicturesWriter: aWriter ].
		
	pageLinks ifNotNil: [ :aPageLinks | 
		exportVisitor pageLinks: aPageLinks ].
		
	exportVisitor exportPart: exportPart.
	
	decorator ifNotNil: [ 
		decorator initializeHTMLPageExporter: exportVisitor ].
		
	content := LeHtmlOutputPrettyStream streamContents: [ :aStream |
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
LeHtmlPageExporterOld >> gtContentFor: aView [
	<gtView>
	^ aView textEditor
		title: 'HTML';
		priority: 5;
		text: [ self content ifNil: [ '' ] ];
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		actionUpdateButton
]

{ #category : #'gt - extensions' }
LeHtmlPageExporterOld >> gtResourcesFor: aView [
	<gtView>
	resourcesExporter ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Resources';
		priority: 10;
		object: [ resourcesExporter ];
		view: #gtResourcesFor:
]

{ #category : #initialization }
LeHtmlPageExporterOld >> initialize [
	super initialize.

	exportPart := LeHtmlNoPageExportPart uniqueInstance
]

{ #category : #accessing }
LeHtmlPageExporterOld >> page [
	<return: #LePage>
	^ self pageLink page
]

{ #category : #accessing }
LeHtmlPageExporterOld >> pageLink [
	<return: #TLeHtmlBookPageLink>
	^ pageLink
]

{ #category : #accessing }
LeHtmlPageExporterOld >> pageLink: aPageLink [
	pageLink := aPageLink
]

{ #category : #accessing }
LeHtmlPageExporterOld >> pageLinks [
	^ pageLinks
]

{ #category : #accessing }
LeHtmlPageExporterOld >> pageLinks: anObject [
	pageLinks := anObject
]

{ #category : #accessing }
LeHtmlPageExporterOld >> resourcesExporter [
	<return: #LeResourcesExporter>
	^ resourcesExporter
]

{ #category : #accessing }
LeHtmlPageExporterOld >> resourcesExporter: aLeResourcesExporter [
	resourcesExporter := aLeResourcesExporter
]

{ #category : #convenience }
LeHtmlPageExporterOld >> saveToRootDirectory: aDirectory [
	LeResourcesDirectorySaver new
		resources: resourcesExporter;
		rootDirectory: aDirectory;
		save
]

{ #category : #accessing }
LeHtmlPageExporterOld >> shouldGenerateHeader [
	^ shouldGenerateHeader
]

{ #category : #accessing }
LeHtmlPageExporterOld >> shouldGenerateHeader: anObject [
	shouldGenerateHeader := anObject
]

{ #category : #'api - initialization' }
LeHtmlPageExporterOld >> withBookNavigation: aGtBook pageLinks: thePageLinks [
	| aPart |
	aPart := LeHtmlBookNavigationExportPart new
			database: aGtBook;
			pageLinks: thePageLinks.

	exportPart := exportPart withPageExportPart: aPart
]

{ #category : #'api - initialization' }
LeHtmlPageExporterOld >> withFileAssets: aRootDirectory [
	self
		decorator: (LeHtmlPageDirectoryAssetsDecorator new rootDiretory: aRootDirectory)
]

{ #category : #'api - initialization' }
LeHtmlPageExporterOld >> withLocalAssets: aBoolean [
	self decorator: (LeHtmlPageDecorator withLocalAssets: aBoolean)
]
