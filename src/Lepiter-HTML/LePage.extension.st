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
LePage >> resourcesVisitor [
	^ LesPageResourceVisitor new 
		page: self
]
