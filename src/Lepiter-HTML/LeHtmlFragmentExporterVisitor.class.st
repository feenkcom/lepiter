"
Write the supplied LeModel on to the stream as an HTML fragment that uses DIVs to reflect the document structure and annotations.

This is a HTML fragment in that it doesn't contain metadata. body tag, etc.

To export a page as a complete HTML document see {{gtClass:name=LeHtmlPageExporterVisitor}}.

To export a fragment to the supplied stream see {{gtMethod:name=LeContent>>#asHTMLFragment}}.

"
Class {
	#name : #LeHtmlFragmentExporterVisitor,
	#superclass : #Object,
	#traits : 'TLeModelVisitor',
	#classTraits : 'TLeModelVisitor classTrait',
	#instVars : [
		'stream',
		'level',
		'externalPicturesWriter',
		'nestingLevel'
	],
	#category : #'Lepiter-HTML-Exporter'
}

{ #category : #accessing }
LeHtmlFragmentExporterVisitor >> externalPicturesWriter [
	^ externalPicturesWriter
]

{ #category : #accessing }
LeHtmlFragmentExporterVisitor >> externalPicturesWriter: aDataWriter [
	externalPicturesWriter := aDataWriter
]

{ #category : #accessing }
LeHtmlFragmentExporterVisitor >> indent: aBlock [
	nestingLevel := nestingLevel + 1.
	aBlock value.
	nestingLevel := nestingLevel - 1.
]

{ #category : #initialization }
LeHtmlFragmentExporterVisitor >> initialize [

	super initialize.
	level := 1.
	nestingLevel := 1.
]

{ #category : #accessing }
LeHtmlFragmentExporterVisitor >> putPre: aString [
	stream
		nextPutAll: aString;
		cr
]

{ #category : #accessing }
LeHtmlFragmentExporterVisitor >> putString: aString [
	stream
		tab: nestingLevel;
		nextPutAll: aString;
		cr
]

{ #category : #accessing }
LeHtmlFragmentExporterVisitor >> putTag: aTag andAttributes: attributesString with: aBlock [
	self putString: '<',aTag, (attributesString ifNotEmpty: [' ',attributesString]), '>'.
	self indent:aBlock.
	self putString: '</',aTag,'>'.
]

{ #category : #accessing }
LeHtmlFragmentExporterVisitor >> putTag: aTag with: aBlock [
	self putTag: aTag andAttributes: '' with: aBlock
]

{ #category : #accessing }
LeHtmlFragmentExporterVisitor >> stream [
	^ stream
]

{ #category : #accessing }
LeHtmlFragmentExporterVisitor >> stream: anObject [
	stream := anObject
]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitContent: aLeContent [

	aLeContent hasChildren ifFalse: [ ^ self ].
	level := level + 1.
	stream 
		<< '<div class="content_children" style="margin-left: ';
		print: level * 20;
		<< 'pt';
		<< '">'.
	aLeContent children acceptVisitor: self.
	stream << '</div>'; cr.

]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitPage: aLePage [

	"Iterate over children, but don't mark as child content"
	aLePage children acceptVisitor: self.

]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitPharoSnippet: aLePharoSnippet [
	self putTag: 'div' andAttributes: 'class="pharo_snippet codeBlock"' with: [
		self putTag: 'pre' with: [
			self putTag: 'code' with: [
				self putPre: aLePharoSnippet code asHTMLString.
			]
		]
	]
]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitTextSnippet: aLeTextSnippet [

	stream << '<div class="text_snippet">'.
	aLeTextSnippet ast acceptVisitor: (LeHtmlExporterTextSnippetVisitor new 
		stream: stream;
		externalPicturesWriter: self externalPicturesWriter).
	self visitTextualSnippet: aLeTextSnippet.
	stream
		<< '</div>';
		cr.

]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitTweetReferenceSnippet: aLeTweetReferenceSnippet [
	self putTag: 'blockquote' andAttributes: 'class="twitter-tweet"' with: [
		self putTag: 'p' andAttributes: 'lang="en" dir="ltr"' with: [
			self putString: aLeTweetReferenceSnippet tweet plainText
		]
	]
]
