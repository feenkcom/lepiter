"
Two-pass page exporter: discover resources, then render Markdown. Export does not execute Pharo snippets; example resource discovery follows the existing export policy.
"
Class {
	#name : #LeMarkdownPageExporter,
	#superclass : #Object,
	#instVars : [
		'context',
		'contents',
		'diagnostics'
	],
	#category : #'Lepiter-Markdown-Core'
}

{ #category : #'instance creation' }
LeMarkdownPageExporter class >> contextForPage: aPage [
	"A single-page export resolves only links whose targets are actually exported."

	^ LeMarkdownContext new page: aPage
]

{ #category : #exporting }
LeMarkdownPageExporter class >> exportPage: aPage to: aDirectory [
	| exporter context link |
	context := self contextForPage: aPage.
	exporter := self new
			context: context;
			export.
	exporter saveToRootDirectory: aDirectory.
	link := context pageLinks
			linkForPage: aPage
			ifFound: [ :each | each ]
			ifNone: [ self error: 'Missing output link' ].
	^ LeMarkdownPage new
		directory: aDirectory;
		pageFile: aDirectory
				/ (LeExportFilenameAndExtensionHypertextReferenceBuilder new
						hrefFromPageLink: link);
		exporter: exporter
]

{ #category : #exporting }
LeMarkdownPageExporter >> assembleResources [
	LeExportResourcesAssembler new
		resources: context resources;
		assemble
]

{ #category : #exporting }
LeMarkdownPageExporter >> buildResources [
	"Discover resources without rendering Markdown."

	context page acceptVisitor: (LeExportVisitor new context: context)
]

{ #category : #accessing }
LeMarkdownPageExporter >> contents [
	^ contents ifNil: [ '' ]
]

{ #category : #accessing }
LeMarkdownPageExporter >> context [
	^ context
]

{ #category : #accessing }
LeMarkdownPageExporter >> context: anObject [
	context := anObject
]

{ #category : #accessing }
LeMarkdownPageExporter >> diagnostics [
	^ diagnostics
]

{ #category : #exporting }
LeMarkdownPageExporter >> export [
	self buildResources.
	self exportMarkdown.
	self assembleResources.
	^ self
]

{ #category : #exporting }
LeMarkdownPageExporter >> exportMarkdown [
	"Render using the resources already discovered. Do not execute resource builders."

	diagnostics removeAll.
	contents := String
			streamContents: [ :out | 
				context page
					acceptVisitor: (LeMarkdownVisitor new
							context: context;
							stream: out;
							diagnostics: diagnostics) ].
	^ self
]

{ #category : #views }
LeMarkdownPageExporter >> gtDiagnosticsFor: aView [
	"Which content could not be faithfully represented?"

	<gtView>
	^ aView list
		title: 'Diagnostics';
		priority: 20;
		items: [ diagnostics ]
]

{ #category : #printing }
LeMarkdownPageExporter >> gtDisplayOn: stream [
	self context
		ifNotNil: [ :aContext | 
			aContext page
				ifNotNil: [ :aPage | 
					stream nextPutAll: 'Exporter for '.
					aPage gtDisplayOn: stream ]
				ifNil: [ super gtDisplayOn: stream ] ]
		ifNil: [ super gtDisplayOn: stream ]
]

{ #category : #views }
LeMarkdownPageExporter >> gtMarkdownFor: aView [
	"What Markdown did this export produce?"

	<gtView>
	^ aView textEditor
		title: 'Markdown';
		priority: 10;
		text: [ self contents ]
]

{ #category : #views }
LeMarkdownPageExporter >> gtResourcesFor: aView [
	"Which image and output resources belong to this export?"

	<gtView>
	^ aView forward
		title: 'Resources';
		priority: 30;
		object: [ context ];
		view: #gtResourcesFor:
]

{ #category : #initialization }
LeMarkdownPageExporter >> initialize [
	super initialize.
	context := LeMarkdownContext new.
	diagnostics := OrderedCollection new
]

{ #category : #accessing }
LeMarkdownPageExporter >> page [
	^ context page
]

{ #category : #accessing }
LeMarkdownPageExporter >> page: aPage [
	context page: aPage
]

{ #category : #exporting }
LeMarkdownPageExporter >> saveToRootDirectory: aDirectory [
	| link |
	aDirectory ensureCreateDirectory.
	link := nil.
	context pageLinks
		do: [ :each | each page == context page ifTrue: [ link := each ] ].
	link ifNil: [ self error: 'No output link for page' ].
	context resources
		addResource: (LeExportPageOutputResource new
				content: self contents;
				pageLink: link).
	LeExportResourcesDirectorySaver new
		resources: context resources;
		rootDirectory: aDirectory;
		save
]
