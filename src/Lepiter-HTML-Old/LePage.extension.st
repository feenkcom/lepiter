Extension { #name : #LePage }

{ #category : #'*Lepiter-HTML-Old' }
LePage >> asHTMLContent [
	"Answer the receiver as an HTML document"

	^ String streamContents: [ :stream |
		self acceptVisitor: (LeHtmlPageExporterVisitor new stream: stream) ]
]

{ #category : #'*Lepiter-HTML-Old' }
LePage >> asHTMLDocument [
	"Answer the receiver as an HTML document"

	^ String streamContents: [ :stream |
		self acceptVisitor: (LeHtmlPageExporterVisitor new 
			shouldGenerateHeader: true;
			stream: stream) ]
]

{ #category : #'*Lepiter-HTML-Old' }
LePage >> resourcesVisitor [
	^ LesPageResourceVisitor new 
		page: self
]
