"
Write the supplied LeModel on to the stream as an HTML fragment that uses DIVs to reflect the document structure and annotations.

This is a HTML fragment in that it doesn't contain metadata. body tag, etc.

To export a page as a complete HTML document see {{gtClass:name=LeHtmlPageExporterVisitor}}.

To export a fragment to the supplied stream see {{gtMethod:name=LeContent>>#asHTMLFragment}}.

"
Class {
	#name : #LeHtmlFragmentExporterVisitor,
	#superclass : #Object,
	#traits : 'TLeModelVisitor + TIndentWriter',
	#classTraits : 'TLeModelVisitor classTrait + TIndentWriter classTrait',
	#instVars : [
		'level',
		'externalPicturesWriter'
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

{ #category : #initialization }
LeHtmlFragmentExporterVisitor >> initialize [
	super initialize.
	level := 1.
	self nestingLevel:0.
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
	self putTag: 'div' andAttributes: 'class="text_snippet"' with: [
		aLeTextSnippet ast acceptVisitor: (LeHtmlExporterTextSnippetVisitor new 
			stream: stream;
			nestingLevel: nestingLevel;
			externalPicturesWriter: self externalPicturesWriter).
	self visitTextualSnippet: aLeTextSnippet.
	]
]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitTweetReferenceSnippet: aLeTweetReferenceSnippet [
	| linkHref |
	self putTag: 'blockquote' andAttributes: 'class="twitter-tweet"' with: [
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
