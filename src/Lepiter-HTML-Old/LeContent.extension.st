Extension { #name : #LeContent }

{ #category : #'*Lepiter-HTML-Old' }
LeContent >> asHTMLFragment [
	"Answer the receiver as an HTML fragment (no meta, body, etc.)"

	^ String streamContents: [ :stream |
		self acceptVisitor: (LeHtmlFragmentExporterVisitor new stream: stream) ].
]
