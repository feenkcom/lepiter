"
I am used by {{gtClass:LeHtmlBookExporter}} for [](https://book.gtoolkit.com) exports.
"
Class {
	#name : #LeHtmlBookFragmentExporterVisitor,
	#superclass : #Object,
	#traits : 'TLeModelVisitor + TIndentWriter',
	#classTraits : 'TLeModelVisitor classTrait + TIndentWriter classTrait',
	#instVars : [
		'level',
		'externalPicturesWriter',
		'pageLinks'
	],
	#category : #'Lepiter-HTML-Exporter'
}

{ #category : #accessing }
LeHtmlBookFragmentExporterVisitor >> externalPicturesWriter [
	^ externalPicturesWriter
]

{ #category : #accessing }
LeHtmlBookFragmentExporterVisitor >> externalPicturesWriter: aDataWriter [
	externalPicturesWriter := aDataWriter
]

{ #category : #initialization }
LeHtmlBookFragmentExporterVisitor >> initialize [
	super initialize.
	level := 1.
	self nestingLevel:0.
]

{ #category : #accessing }
LeHtmlBookFragmentExporterVisitor >> pageLinks [
	^ pageLinks
]

{ #category : #accessing }
LeHtmlBookFragmentExporterVisitor >> pageLinks: anObject [
	pageLinks := anObject
]

{ #category : #visiting }
LeHtmlBookFragmentExporterVisitor >> visitContent: aLeContent [
	aLeContent hasChildren ifFalse: [ ^ self ].
	self putTag: 'div' andAttributes: #('class' 'snippet-children') with: [
		aLeContent children acceptVisitor: self.
	]
]

{ #category : #visiting }
LeHtmlBookFragmentExporterVisitor >> visitElementSnippet: aLeElementSnippet [
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
LeHtmlBookFragmentExporterVisitor >> visitExampleSnippet: aLeExampleSnippet [
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
LeHtmlBookFragmentExporterVisitor >> visitPage: aLePage [

	"Iterate over children, but don't mark as child content"
	aLePage children acceptVisitor: self.

]

{ #category : #visiting }
LeHtmlBookFragmentExporterVisitor >> visitPharoSnippet: aLePharoSnippet [
	self
		putTag: 'div'
		andAttributes: #('class' 'snippet textual-snippet code-snippet pharo-snippet')
		with: [ self
				putPre: 'pre'
				andAttributes: #('class' 'no_bottom_margin')
				with: [ self putPre:aLePharoSnippet code asHTMLString ] ]
]

{ #category : #visiting }
LeHtmlBookFragmentExporterVisitor >> visitPictureSnippet: aLePictureSnippet [
	| anImgSrc |
	anImgSrc := self externalPicturesWriter 
		pictureSnippetReferenceFor: aLePictureSnippet.
			
	self
		putTag: 'figure'
		andAttributes: #('class' 'snippet picture-snippet paragraphWidth')
		with: [

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
LeHtmlBookFragmentExporterVisitor >> visitTextSnippet: aLeTextSnippet [
	self putTag: 'div' andAttributes: #('class' 'snippet textual-snippet text-snippet') with: [
		aLeTextSnippet ast acceptVisitor: (LeHtmlExporterTextSnippetVisitor new 
				stream: stream;
				nestingLevel: nestingLevel;
				externalPicturesWriter: self externalPicturesWriter;
				pageLinks: pageLinks).
		self visitTextualSnippet: aLeTextSnippet. ]
]

{ #category : #visiting }
LeHtmlBookFragmentExporterVisitor >> visitTweetReferenceSnippet: aLeTweetReferenceSnippet [
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

{ #category : #visiting }
LeHtmlBookFragmentExporterVisitor >> visitWardleyMapSnippet: aLeWardleyMapSnippet [
	| aFileName |

	aFileName := self externalPicturesWriter  
			wardleyMapSnippetReferenceFor: aLeWardleyMapSnippet.

	self
		putTag: 'figure'
		andAttributes: #('class' 'snippet picture-snippet paragraphWidth')
		with: [

			self
				putTag: 'img'
				andAttributes: {'class'. 'picture-snippet-image'. 'src'. aFileName }.

			(aLeWardleyMapSnippet title isNotNil
				and: [ aLeWardleyMapSnippet title trimBoth isNotEmpty ])
				ifTrue: [ self
						putTag: 'figcaption'
						andAttributes: #('class' 'picture-snippet-caption')
						with: [ self putString: aLeWardleyMapSnippet title trimBoth asString asHTMLString ] ] ]
]

{ #category : #visiting }
LeHtmlBookFragmentExporterVisitor >> visitYoutubeReferenceSnippet: aLeYoutubeReferenceSnippet [
	self putTag: 'div' andAttributes: #('class' 'snippet youtube-reference-snippet') with: [
		self putString: aLeYoutubeReferenceSnippet html]
]

{ #category : #accessing }
LeHtmlBookFragmentExporterVisitor >> writeExampleResult: aLeExampleSnippet [ 
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
