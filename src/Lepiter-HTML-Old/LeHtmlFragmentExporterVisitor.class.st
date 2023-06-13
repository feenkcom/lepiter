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
		'externalPicturesWriter',
		'pageLinks'
	],
	#category : #'Lepiter-HTML-Old-Exporter'
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

{ #category : #accessing }
LeHtmlFragmentExporterVisitor >> pageLinks [
	^ pageLinks
]

{ #category : #accessing }
LeHtmlFragmentExporterVisitor >> pageLinks: anObject [
	pageLinks := anObject
]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitContent: aLeContent [
	aLeContent hasChildren ifFalse: [ ^ self ].
	self putTag: 'div' andAttributes: #('class' 'snippet-children') with: [
		aLeContent children acceptVisitor: self.
	]
]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitElementSnippet: aLeElementSnippet [
	| aFileName |
	
	aFileName := self externalPicturesWriter  
			elementSnippetReferenceFor: aLeElementSnippet.

	self
		putTag: 'figure'
		andAttributes: #('class' 'snippet picture-snippet paragraphWidth')
		with: [

			self
				putTag: 'img'
				andAttributes: {'class'. 'picture-snippet-image'. 'src'. aFileName }.

			(aLeElementSnippet caption isNotNil
				and: [ aLeElementSnippet title trimBoth isNotEmpty ])
				ifTrue: [ self
						putTag: 'figcaption'
						andAttributes: #('class' 'picture-snippet-caption')
						with: [ self putString: aLeElementSnippet caption trimBoth asString asHTMLString ] ] ]
]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitExampleSnippet: aLeExampleSnippet [
	self
		putTag: 'div'
		with: [ aLeExampleSnippet noCode
				ifFalse: [ self
						putTag: 'div'
						andAttributes: #('class' 'snippet textual-snippet code-snippet pharo-snippet documentWidth')
						with: [ self
								putPre: 'pre'
								andAttributes: #('class' 'no_bottom_margin')
								with:
									[ self putPre: aLeExampleSnippet referencedExample sourceCode asString ] ] ].
			self writeExampleResult: aLeExampleSnippet ]
]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitPage: aLePage [

	"Iterate over children, but don't mark as child content"
	aLePage children acceptVisitor: self.

]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitPharoSnippet: aLePharoSnippet [
	self
		putTag: 'div'
		andAttributes: #('class' 'snippet textual-snippet code-snippet pharo-snippet')
		with: [ self
				putPre: 'pre'
				andAttributes: #('class' 'no_bottom_margin')
				with: [ self putPre:aLePharoSnippet code asHTMLString ] ]
]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitPictureSnippet: aLePictureSnippet [
	self
		putTag: 'figure'
		andAttributes: #('class' 'snippet picture-snippet paragraphWidth')
		with: [ | anImgSrc |
			anImgSrc := (aLePictureSnippet urlString
					beginsWith: 'https://'
					caseSensitive: false)
					ifTrue: [ aLePictureSnippet urlString ]
					ifFalse: [ './' , aLePictureSnippet urlString ].

			self
				putTag: 'img'
				andAttributes: {'class'. 'picture-snippet-image'. 'src'. anImgSrc }.

			(aLePictureSnippet caption isNotNil
				and: [ aLePictureSnippet caption trimBoth isNotEmpty ])
				ifTrue: [ self
						putTag: 'figcaption'
						andAttributes: #('class' 'picture-snippet-caption')
						with: [ self putString: aLePictureSnippet caption asString asHTMLString ] ] ]
]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitTextSnippet: aLeTextSnippet [
	self putTag: 'div' andAttributes: #('class' 'snippet textual-snippet text-snippet') with: [
		aLeTextSnippet ast acceptVisitor: (LeHtmlExporterTextSnippetVisitor new 
				stream: stream;
				nestingLevel: nestingLevel;
				externalPicturesWriter: self externalPicturesWriter;
				pageLinks: pageLinks).
		self visitTextualSnippet: aLeTextSnippet. ]
]

{ #category : #visiting }
LeHtmlFragmentExporterVisitor >> visitTweetReferenceSnippet: aLeTweetReferenceSnippet [
	| linkHref |
	self
		putTag: 'div'
		andAttributes: #('class' 'snippet textual-snippet tweet-reference-snippet')
		with: [ self
				putTag: 'blockquote'
				andAttributes: #('class' 'twitter-tweet')
				with: [ self
						putTag: 'p'
						andAttributes: #('lang' 'en' 'dir' 'ltr')
						with: [ self putString: aLeTweetReferenceSnippet tweet plainText ].
					self putString: '&mdash; '.
					self putString: (aLeTweetReferenceSnippet tweet authorObject at: 'name').
					self putString: '(@' , aLeTweetReferenceSnippet tweet authorUsername , ')'.
					linkHref := {'href'. aLeTweetReferenceSnippet url asString
							, '?ref_src=twsrc%5Etfw"'}.
					self
						putTag: 'a'
						andAttributes: linkHref
						with: [ self putString: aLeTweetReferenceSnippet tweet createdAt asString ] ] ].
	self
		putString: '<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>'
]

{ #category : #accessing }
LeHtmlFragmentExporterVisitor >> writeExampleResult: aLeExampleSnippet [ 
	| aMethod aFigureReference |
	aMethod := aLeExampleSnippet referencedExample compiledMethod.
	
	aMethod ifNotNil: [
		aFigureReference := self externalPicturesWriter  
			exampleSnippetResultReferenceFor: aLeExampleSnippet ].

	self putTag: 'div' andAttributes: #('class' 'height-one-em') with:[].
	self putTag: 'figure' andAttributes: #('class' 'documentWidth') with: [
		aMethod ifNotNil: [
			self putTag: 'img' andAttributes: {'src'. aFigureReference asString } with: [
			] ]
	]
]
