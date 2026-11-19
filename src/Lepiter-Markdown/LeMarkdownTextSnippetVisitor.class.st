"
Preserves Markdown source while replacing Lepiter-specific AST nodes and resource URLs.
"
Class {
	#name : #LeMarkdownTextSnippetVisitor,
	#superclass : #LeExportTextSnippetVisitor,
	#instVars : [
		'replacements',
		'diagnostics'
	],
	#category : #'Lepiter-Markdown-Core'
}

{ #category : #visiting }
LeMarkdownTextSnippetVisitor >> acceptNode: aNode [
	aNode ifNil: [ ^ nil ].
	^ aNode acceptVisitor: self
]

{ #category : #accessing }
LeMarkdownTextSnippetVisitor >> diagnostics: anObject [
	diagnostics := anObject
]

{ #category : #writing }
LeMarkdownTextSnippetVisitor >> markdown [
	| source position |
	replacements := OrderedCollection new.
	snippet ast acceptVisitor: self.
	source := snippet string.
	position := 1.
	^ String
		streamContents: [ :out | 
			(replacements sorted: [ :a :b | a first < b first ])
				do: [ :each | 
					each first >= position
						ifTrue: [ out
								nextPutAll: (source copyFrom: position to: each first - 1);
								nextPutAll: each third.
							position := each second + 1 ] ].
			out nextPutAll: (source copyFrom: position to: source size) ]
]

{ #category : #writing }
LeMarkdownTextSnippetVisitor >> replace: aNode with: aString [
	replacements
		add: {aNode startPosition.
				aNode stopPosition.
				aString}
]

{ #category : #visiting }
LeMarkdownTextSnippetVisitor >> visitDocumenterAnnotation: aNode [
	| annotation resource |
	annotation := aNode annotation.
	resource := nil.
	context resources
		do: [ :each | 
			(each isKindOf: LeExportTextSnippetExampleAnnotationResource)
				ifTrue: [ each annotation == annotation ifTrue: [ resource := each ] ] ].
	resource
		ifNotNil: [ resource wantsLabelOutput
				ifTrue: [ | label |
					label := resource computedLabel.
					label
						ifNotNil: [ self replace: aNode with: (LeMarkdownVisitor new escapeLabel: label asString).
							^ aNode ] ].
			resource wantsLabelOutput
				ifFalse: [ resource beRequiredResource.
					self
						replace: aNode
						with: String lf , '![](<' , resource pathName , '>)' , String lf.
					^ aNode ] ].
	diagnostics add: 'Unsupported annotation: ' , aNode source.
	self
		replace: aNode
		with: '`' , (aNode source copyReplaceAll: '`' with: '''') , '`'.
	^ aNode
]

{ #category : #visiting }
LeMarkdownTextSnippetVisitor >> visitDoubleBracketLink: aNode [
	context pageLinks
		linkTitled: aNode linkUID
		ifFound: [ :link | 
			self
				replace: aNode
				with: '[' , (LeMarkdownVisitor new escapeLabel: aNode linkUID) , '](<'
						, (LeExportFilenameAndExtensionHypertextReferenceBuilder new
								hrefFromPageLink: link) , '>)' ]
		ifNone: [ diagnostics add: 'Unresolved page: ' , aNode linkUID.
			self replace: aNode with: (LeMarkdownVisitor new escapeLabel: aNode linkUID) ].
	^ aNode
]

{ #category : #visiting }
LeMarkdownTextSnippetVisitor >> visitExternalImageLink: aNode [
	context resources
		do: [ :each | 
			(each source == aNode and: [ each respondsTo: #imgSrc ])
				ifTrue: [ self
						replace: aNode
						with: '![' , (LeMarkdownVisitor new escapeLabel: aNode label) , '](<' , each imgSrc
								, '>)' ] ].
	^ aNode
]
