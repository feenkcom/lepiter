"
Markdown snippet visitor. Unsupported snippets are reported and retain their children.
"
Class {
	#name : #LeMarkdownVisitor,
	#superclass : #LeExportVisitor,
	#instVars : [
		'stream',
		'diagnostics'
	],
	#category : #'Lepiter-Markdown-Core'
}

{ #category : #accessing }
LeMarkdownVisitor >> diagnostics: anObject [
	diagnostics := anObject
]

{ #category : #writing }
LeMarkdownVisitor >> escapeLabel: aString [
	| result |
	result := aString asString copyReplaceAll: '\' with: '\\'.
	#('[' ']' '*' '_')
		do: [ :each | result := result copyReplaceAll: each with: '\' , each ].
	^ result copyReplaceAll: String cr with: ' '
]

{ #category : #accessing }
LeMarkdownVisitor >> stream: anObject [
	stream := anObject
]

{ #category : #visiting }
LeMarkdownVisitor >> visitExampleSnippet: aSnippet [
	"Example previews are file resources with pathName, not picture resources with imgSrc."

	| found |
	found := false.
	context resources
		do: [ :resource | 
			resource source == aSnippet
				ifTrue: [ found := true.
					resource wantsCodeOutput
						ifTrue: [ self writeCode: resource sourceCode language: 'smalltalk' ].
					resource wantsPreviewOutput
						ifTrue: [ resource beRequiredResource.
							self
								writeBlock: '![Example](<' , (resource pathName copyReplaceAll: '>' with: '%3E') , '>)' ] ] ].
	found
		ifFalse: [ diagnostics add: 'No example resource: ' , aSnippet class name ].
	^ self visitContent: aSnippet
]

{ #category : #visiting }
LeMarkdownVisitor >> visitJavaScriptSnippet: aSnippet [
	self writeCode: aSnippet code language: 'javascript'.
	^ self visitContent: aSnippet
]

{ #category : #visiting }
LeMarkdownVisitor >> visitPage: aPage [
	self writeBlock: '# ' , (self escapeLabel: aPage title).
	^ self visitContent: aPage
]

{ #category : #visiting }
LeMarkdownVisitor >> visitPharoSnippet: aSnippet [
	self writeCode: aSnippet code language: 'smalltalk'.
	^ self visitContent: aSnippet
]

{ #category : #visiting }
LeMarkdownVisitor >> visitPictureSnippet: aSnippet [
	self writeImagesFor: aSnippet caption: (aSnippet caption ifNil: [ '' ]).
	^ self visitContent: aSnippet
]

{ #category : #visiting }
LeMarkdownVisitor >> visitPythonSnippet: aSnippet [
	self writeCode: aSnippet code language: 'python'.
	^ self visitContent: aSnippet
]

{ #category : #visiting }
LeMarkdownVisitor >> visitSnippet: aSnippet [
	diagnostics add: 'Unsupported snippet: ' , aSnippet class name.
	^ self visitContent: aSnippet
]

{ #category : #visiting }
LeMarkdownVisitor >> visitTextSnippet: aSnippet [
	| visitor |
	visitor := LeMarkdownTextSnippetVisitor new
			context: context;
			snippet: aSnippet;
			diagnostics: diagnostics.
	self writeBlock: visitor markdown.
	^ self visitContent: aSnippet
]

{ #category : #writing }
LeMarkdownVisitor >> writeBlock: aString [
	stream
		nextPutAll: aString;
		lf;
		lf
]

{ #category : #writing }
LeMarkdownVisitor >> writeCode: aString language: aLanguage [
	| fence |
	fence := '```'.
	[ aString includesSubstring: fence ] whileTrue: [ fence := fence , '`' ].
	stream
		nextPutAll: fence;
		nextPutAll: aLanguage;
		lf;
		nextPutAll: aString;
		lf;
		nextPutAll: fence;
		lf;
		lf
]

{ #category : #writing }
LeMarkdownVisitor >> writeImagesFor: aSnippet caption: aCaption [
	| found |
	found := false.
	context resources
		do: [ :each | 
			(each source == aSnippet and: [ each respondsTo: #imgSrc ])
				ifTrue: [ found := true.
					self
						writeBlock: '![' , (self escapeLabel: aCaption) , '](<'
								, (each imgSrc copyReplaceAll: '>' with: '%3E') , '>)' ] ].
	found ifFalse: [ diagnostics add: 'No image resource: ' , aSnippet class name ]
]
