Class {
	#name : #LeHtmlExporterTextSnippetVisitor,
	#superclass : #Object,
	#traits : 'TLeExtensibleContentNodeVisitor + TSmaCCCompositeVisitor + (TLeContentNodeVisitor - {#acceptNode:}) + TIndentWriter',
	#classTraits : 'TLeExtensibleContentNodeVisitor classTrait + TSmaCCCompositeVisitor classTrait + TLeContentNodeVisitor classTrait + TIndentWriter classTrait',
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

{ #category : #accessing }
LeHtmlExporterTextSnippetVisitor >> putPre: aString [
	stream
		nextPutAll: aString;
		cr
]

{ #category : #visiting }
LeHtmlExporterTextSnippetVisitor >> visitBold: aBold [
	self putTagInline: 'b' with: [self visitContent: aBold]
]

{ #category : #generated }
LeHtmlExporterTextSnippetVisitor >> visitCodeBlock: aCodeBlock [
	self putTag: 'div' andAttributes: 'class="code_block"' with: [
		self putTag: 'pre' with: [
			self putTag: 'code' andAttributes: 'class="smalltalk"' with: [
				self putStringInline: aCodeBlock code value asString trimBoth asHTMLString.
				stream cr.
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
		<< ('<figure class="{1}">' format: { LepiterConstants defaultAlignment }); 
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

{ #category : #generated }
LeHtmlExporterTextSnippetVisitor >> visitExternalUrlLink: anExternalUrlLink [
	| linkUrl convertedUrl |
	linkUrl := anExternalUrlLink url.
	convertedUrl := self convertToLocalOrAbsoluteUrl: linkUrl.
	stream
		<< '<a href="';
		<< convertedUrl asHTMLString;
		<< '">';
		<< convertedUrl asHTMLString;
		<< '</a>'; 
		cr
]

{ #category : #generated }
LeHtmlExporterTextSnippetVisitor >> visitHeader: aHeader [
	^ self
		  putTag: 'h' , (aHeader headerLevel + 1) asString
		  with: [ self visitContent: aHeader ]
]

{ #category : #visiting }
LeHtmlExporterTextSnippetVisitor >> visitInlineCode: anInlineCode [
	| md code |
	md := anInlineCode code value.
	code := md copyFrom: 2 to: md size - 1.
	self putTagInline: 'code' with: [
		self putStringInline: code asHTMLString ].
]

{ #category : #visiting }
LeHtmlExporterTextSnippetVisitor >> visitItalic: anItalic [
	self putTagInline: 'i' with: [self visitContent: anItalic]
]

{ #category : #generated }
LeHtmlExporterTextSnippetVisitor >> visitPageLink: aPageLink [

	^ self visitDefinedLink: aPageLink
]

{ #category : #generated }
LeHtmlExporterTextSnippetVisitor >> visitText: aText [
	self putStringInline: aText content asHTMLString
]
