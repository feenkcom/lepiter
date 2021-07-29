"
Write the supplied LeModel on to the stream as an HTML fragment that uses DIVs to reflect the document structure and annotations.

This is a HTML fragment in that it doesn't contain metadata. body tag, etc.

To export a page as a complete HTML document see {{gtClass:name=LeHtmlPageExporterVisitor}}.

To export a fragment to the supplied stream see {{gtMethod:name=LeContent>>#asHTMLFragment}}.

"
Class {
	#name : 'LeHtmlFragmentExporterVisitor',
	#superclass : 'Object',
	#traits : 'TLeModelVisitor + TIndentWriter',
	#classTraits : 'TLeModelVisitor classTrait + TIndentWriter classTrait',
	#instVars : [
		'level',
		'externalPicturesWriter'
	],
	#category : 'Lepiter-HTML-Exporter'
}

{ #category : 'accessing' }
LeHtmlFragmentExporterVisitor >> externalPicturesWriter [
	^ externalPicturesWriter
]

{ #category : 'accessing' }
LeHtmlFragmentExporterVisitor >> externalPicturesWriter: aDataWriter [
	externalPicturesWriter := aDataWriter
]

{ #category : 'initialization' }
LeHtmlFragmentExporterVisitor >> initialize [
	super initialize.
	level := 1.
	self nestingLevel:0.
]

{ #category : 'visiting' }
LeHtmlFragmentExporterVisitor >> putPre: aTag andAttributes: attributesString with: aBlock [
	self putString: '<',aTag, (attributesString ifNotEmpty: [' ',attributesString]), '>'.
	self indent:aBlock.
	self putPre: '</',aTag,'>'.
]

{ #category : 'accessing' }
LeHtmlFragmentExporterVisitor >> putTag: aTag andAttributes: attributesString with: aBlock [
	self putString: '<',aTag, (attributesString ifNotEmpty: [' ',attributesString]), '>'.
	self indent:aBlock.
	self putString: '</',aTag,'>'.
]

{ #category : 'visiting' }
LeHtmlFragmentExporterVisitor >> visitContent: aLeContent [
	aLeContent hasChildren ifFalse: [ ^ self ].
	self putTag: 'div' andAttributes: 'class="content_children"' with: [
		aLeContent children acceptVisitor: self.
	]
]

{ #category : 'visiting' }
LeHtmlFragmentExporterVisitor >> visitExampleSnippet: aLeExampleSnippet [
	| linkHref |
	self
		putTag: 'div'
		with: [ aLeExampleSnippet noCode
				ifFalse: [ self
						putTag: 'div'
						andAttributes: 'class="snippet textual-snippet code-snippet pharo-snippet"'
						with: [ self
								putPre: 'pre'
								andAttributes: 'class="no_bottom_margin"'
								with:
									[ self putPre: aLeExampleSnippet referencedExample sourceCode ] ] ].
			self writeExampleResult: aLeExampleSnippet ]
]

{ #category : 'visiting' }
LeHtmlFragmentExporterVisitor >> visitPage: aLePage [

	"Iterate over children, but don't mark as child content"
	aLePage children acceptVisitor: self.

]

{ #category : 'visiting' }
LeHtmlFragmentExporterVisitor >> visitPharoSnippet: aLePharoSnippet [
	self
		putTag: 'div'
		andAttributes: 'class="snippet textual-snippet code-snippet pharo-snippet"'
		with: [ self
				putPre: 'pre'
				andAttributes: 'class="no_bottom_margin"'
				with: [ self putPre:aLePharoSnippet code asHTMLString ] ]
]

{ #category : 'visiting' }
LeHtmlFragmentExporterVisitor >> visitPictureSnippet: aLePictureSnippet [
	self putTag: 'img' andAttributes: 'class="snippet picture-snippet paragraphWidth" src="./',aLePictureSnippet urlString, '"' with: []
]

{ #category : 'visiting' }
LeHtmlFragmentExporterVisitor >> visitTextSnippet: aLeTextSnippet [
	self putTag: 'p' andAttributes: 'class="snippet textual-snippet text-snippet"' with: [
		aLeTextSnippet ast acceptVisitor: (LeHtmlExporterTextSnippetVisitor new 
			stream: stream;
			nestingLevel: nestingLevel;
			externalPicturesWriter: self externalPicturesWriter).
	self visitTextualSnippet: aLeTextSnippet.]
]

{ #category : 'visiting' }
LeHtmlFragmentExporterVisitor >> visitTweetReferenceSnippet: aLeTweetReferenceSnippet [
	| linkHref |
	self putTag: 'blockquote' andAttributes: 'class="snippet textual-snippet tweet-reference-snippet"' with: [
		self putTag: 'p' andAttributes: 'lang="en" dir="ltr"' with: [
			self putString: aLeTweetReferenceSnippet tweet plainText.
			self putString:'&mdash; '.
			self putString: (aLeTweetReferenceSnippet tweet authorObject at: 'name').
			self putString:'(@',aLeTweetReferenceSnippet tweet authorUsername,')'.
			linkHref := 'href="',aLeTweetReferenceSnippet url,'?ref_src=twsrc%5Etfw"'.
			self putTag: 'a' andAttributes: linkHref with: [
				self putString: aLeTweetReferenceSnippet tweet createdAt asString.
			].
		]
	].
	self putString: '<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>'.
]

{ #category : 'visiting' }
LeHtmlFragmentExporterVisitor >> visitYoutubeReferenceSnippet: aLeYoutubeReferenceSnippet [
	self putTag: 'div' andAttributes: 'class="snippet youtube-reference-snippet"' with: [
		self putString: aLeYoutubeReferenceSnippet html]
]

{ #category : 'accessing' }
LeHtmlFragmentExporterVisitor >> writeExampleResult: aLeExampleSnippet [ 
	|  aFigureReference |
	aFigureReference := self externalPicturesWriter  exampleSnippetResultReferenceFor: aLeExampleSnippet.

	self putTag: 'div' andAttributes: 'class="height-one-em"' with:[].
	self putTag: 'figure' andAttributes: 'paragraphWidth"' with: [
		self putTag: 'img' andAttributes: 'src="', aFigureReference, '"' with: [
		]
	]
]
