Class {
	#name : #LeHtmlVisitorOldExamples,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Old-! New - Examples'
}

{ #category : #'examples - incoplete visitor' }
LeHtmlVisitorOldExamples >> elementSnippet_IncompleteVisitor [
	<gtExample>
	| snippet html resources context visitor |
	snippet := LeElementSnippet
			code: BrExamplesShowroom name , ' new ' , #glamorousBreadcrumb asString.
	html := String
			streamContents: [ :stream | 
				snippet
					acceptVisitor: (visitor := LeHtmlIncopleteVisitor new
								context: (context := LeHtmlContextOld new
											resources: (resources := LeExportResources2 new);
											stream: stream)) ].
											
	self 
		assert: html isEmpty 
		description: [ 'HTML output must be empty'].
	self 
		assert: resources asArray isEmpty
		description: [ 'Resources must be empty.' ].
	self 
		assert: context log asArray size = 1
		description: [ 'Log must NOT be empty.' ].
	self 
		assert: context log asArray first isProblemLog
		description: [ 'Log item must be a problem.' ].

	^ visitor
]

{ #category : #'examples - element snippet' }
LeHtmlVisitorOldExamples >> elementSnippet_InexistentMethod [
	<gtExample>
	| snippet html resources context visitor |
	snippet := LeElementSnippet 
		code: LeHtmlVisitorOldExamples name, ' new inexistentMethod'.
	html := String streamContents: [ :stream | 
		snippet acceptVisitor: (visitor := LeHtmlVisitorOld new
			context: (context := LeHtmlContextOld new
				resources: (resources := LeExportResources2 new);
				stream: stream)) ].
	
	self 
		assert: html isNotEmpty 
		description: [ 'HTML output must be non-empty'].
	
	self assert: (html includesSubstring: '<figure class="snippet picture-snippet').
	self assert: (html includesSubstring: '<img class="picture-snippet-image" src="gt-figures/1000.png"/>').
	
	self assert: resources asArray size equals: 1.
	self 
		assert: resources asArray first state isReady not
		description: [ 'Resource must NOT be ready.' ].

	^ visitor
]

{ #category : #'examples - element snippet' }
LeHtmlVisitorOldExamples >> elementSnippet_InexistentMethod_PrepareResources [
	<gtExample>
	| resources visitor context |
	visitor := self elementSnippet_InexistentMethod.
	context := visitor context.
	resources := context resources.
	context assembler assemble.
	
	self assert: resources asArray size equals: 1.
	self 
		assert: resources asArray first state isReady not
		description: [ 'Resource must be ready.' ].

	^ visitor
]
