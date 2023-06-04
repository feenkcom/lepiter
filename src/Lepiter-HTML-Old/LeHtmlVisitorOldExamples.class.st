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
