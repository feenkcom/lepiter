Extension { #name : #LePage }

{ #category : #'*Lepiter-HTML' }
LePage >> asHTMLContent [
	"Answer the receiver as an HTML document"

	^ String streamContents: [ :stream |
		self acceptVisitor: (LeHtmlPageExporterVisitor new stream: stream) ]
]

{ #category : #'*Lepiter-HTML' }
LePage >> asHTMLDocument [
	"Answer the receiver as an HTML document"

	^ String streamContents: [ :stream |
		self acceptVisitor: (LeHtmlPageExporterVisitor new 
			shouldGenerateHeader: true;
			stream: stream) ]
]

{ #category : #'*Lepiter-HTML' }
LePage >> gtHTMLLocalExportActionFor: anAction [
	<gtAction>
	self database ifNil: [ ^ anAction noAction ].
	self database isDatabase ifFalse: [ ^ anAction noAction ].

	^ anAction button
		label: 'HTML';
		tooltip: 'Export the page into an HTML format and store locally';
		priority: 10;
		icon: BrGlamorousVectorIcons spawn;
		action: [ :aButton | 
			| xdocFile |
			xdocFile := XdWriter new
					streamingStrategy: XdStreamingStrategy bytes;
					lepiterIndexPage: self withLocalAssets: false;
					write.
			aButton phlow spawnObject: xdocFile ]
]

{ #category : #'*Lepiter-HTML' }
LePage >> resourcesVisitor [
	^ LesPageResourceVisitor new 
		page: self
]
