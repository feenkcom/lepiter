Class {
	#name : #LeHtmlExporterTextSnippetVisitor,
	#superclass : #Object,
	#traits : 'TSmaCCCompositeVisitor + (TLeContentNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCCompositeVisitor classTrait + TLeContentNodeVisitor classTrait',
	#instVars : [
		'stream',
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
LeHtmlExporterTextSnippetVisitor >> stream [
	^ stream
]

{ #category : #accessing }
LeHtmlExporterTextSnippetVisitor >> stream: anObject [
	stream := anObject
]

{ #category : #visiting }
LeHtmlExporterTextSnippetVisitor >> visitBold: aBold [

	stream << '<b>'.
	self visitContent: aBold.
	stream << '</b>'.

]

{ #category : #generated }
LeHtmlExporterTextSnippetVisitor >> visitCodeBlock: aCodeBlock [

	stream
		<< '<div class="code_block">';
		<< '<pre>';
		<< '<code class="hljs smalltalk">';
		<< aCodeBlock code value asString asHTMLString;
		<< '</code>';
		<< '</pre>';
		<< '</div>'; cr.
]

{ #category : #generated }
LeHtmlExporterTextSnippetVisitor >> visitDocumenterAnnotation: aDocumenterAnnotation [

	aDocumenterAnnotation annotation acceptVisitor: (LeHtmlExporterAnnotationVisitor new 
		stream: stream;
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
	stream 
		<< '<code>';
		<< code asHTMLString;
		<< '</code>'.

]

{ #category : #visiting }
LeHtmlExporterTextSnippetVisitor >> visitItalic: anItalic [

	stream << '<i>'.
	self visitContent: anItalic.
	stream << '</i>'.

]

{ #category : #generated }
LeHtmlExporterTextSnippetVisitor >> visitPageLink: aPageLink [

	^ self visitDefinedLink: aPageLink
]

{ #category : #generated }
LeHtmlExporterTextSnippetVisitor >> visitText: aText [

	stream << aText content asHTMLString

]
