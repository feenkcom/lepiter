Class {
	#name : #LeHtmlExporterTextSnippetVisitor,
	#superclass : #Object,
	#traits : 'TSmaCCCompositeVisitor + TIndentWriter + (TLeContentNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCCompositeVisitor classTrait + TIndentWriter classTrait + TLeContentNodeVisitor classTrait',
	#instVars : [
		'externalPicturesWriter'
	],
	#category : #'Lepiter-HTML-Exporter'
}

{ #category : #utils }
LeHtmlExporterTextSnippetVisitor >> convertLocalAttachmentToRelativeUrl: anUrlLink [
	^ anUrlLink removePrefix: 'file://'
]

{ #category : #utils }
LeHtmlExporterTextSnippetVisitor >> convertToLocalOrAbsoluteUrl: aUrlLink [
	^ (self isLocalAttachmentUrl: aUrlLink) 
		ifTrue: [ self convertLocalAttachmentToRelativeUrl: aUrlLink ]
		ifFalse: [ aUrlLink ].

]

{ #category : #utils }
LeHtmlExporterTextSnippetVisitor >> exportImageTagFor: anExternalImageLink [
	| linkUrl |
	linkUrl := self convertToLocalOrAbsoluteUrl: anExternalImageLink url.
	stream
		<< ('<img src="{1}" alt="{2}"/>' format: {
			linkUrl asHTMLString. 
			anExternalImageLink label 
				ifNil: [ '' ]
				ifNotNil: [ :aLabel | aLabel asHTMLString ] });
		cr.

]

{ #category : #accessing }
LeHtmlExporterTextSnippetVisitor >> externalPicturesWriter [
	^ externalPicturesWriter
]

{ #category : #accessing }
LeHtmlExporterTextSnippetVisitor >> externalPicturesWriter: aDataWriter [
	externalPicturesWriter := aDataWriter
]

{ #category : #utils }
LeHtmlExporterTextSnippetVisitor >> isLocalAttachmentUrl: aUrlLink [
	^ aUrlLink beginsWith: 'file://'
]

{ #category : #visiting }
LeHtmlExporterTextSnippetVisitor >> visitBold: aBold [
	self putTag: 'b' with: [self visitContent: aBold]
]

{ #category : #generated }
LeHtmlExporterTextSnippetVisitor >> visitCodeBlock: aCodeBlock [
	self putTag: 'div' andAttributes: 'class="code_block"' with: [
		self putTag: 'pre' with: [
			self putTag: 'code' andAttributes: 'class="smalltalk"' with: [
				self putPre: aCodeBlock code value asString asHTMLString
			]
		]
	]
]

{ #category : #generated }
LeHtmlExporterTextSnippetVisitor >> visitDocumenterAnnotation: aDocumenterAnnotation [
	aDocumenterAnnotation annotation acceptVisitor: (LeHtmlExporterAnnotationVisitor new 
		stream: stream;
		nestingLevel: nestingLevel;
		externalPicturesWriter: self externalPicturesWriter)
]

{ #category : #generated }
LeHtmlExporterTextSnippetVisitor >> visitExternalImageLink: anExternalImageLink [	
	| linkLabel |
	stream
		<< ('<figure class="{1}">' format: { GtDocumentConstants defaultAlignment }); 
		cr.
		
	self exportImageTagFor: anExternalImageLink.
	linkLabel := anExternalImageLink label.
	(linkLabel notNil and: [ linkLabel notEmpty ]) ifTrue: [ 
		stream
			<< '<figcaption>';
			<< linkLabel asHTMLString;
			<< '</figcaption>'; cr ].
	
	stream
		<< '</figure>'; cr
]

{ #category : #generated }
LeHtmlExporterTextSnippetVisitor >> visitExternalLabelUrlLink: anExternalLabelUrlLink [
	| linkUrl convertedUrl |
	linkUrl := anExternalLabelUrlLink url.
	convertedUrl := self convertToLocalOrAbsoluteUrl: linkUrl.
	
	stream
		<< '<a href="';
		<< convertedUrl asHTMLString;
		<< '">';
		<< anExternalLabelUrlLink label asHTMLString;
		<< '</a>'; 
		cr
]

{ #category : #visiting }
LeHtmlExporterTextSnippetVisitor >> visitInlineCode: anInlineCode [
	| md code |
	md := anInlineCode code value.
	code := md copyFrom: 2 to: md size - 1.
	self putTag: 'code' with: [
		self putString: code asHTMLString ].
]

{ #category : #visiting }
LeHtmlExporterTextSnippetVisitor >> visitItalic: anItalic [
	self putTag: 'i' with: [self visitContent: anItalic]
]

{ #category : #generated }
LeHtmlExporterTextSnippetVisitor >> visitPageLink: aPageLink [

	^ self visitDefinedLink: aPageLink
]

{ #category : #generated }
LeHtmlExporterTextSnippetVisitor >> visitText: aText [
	self putString: aText content asHTMLString
]
