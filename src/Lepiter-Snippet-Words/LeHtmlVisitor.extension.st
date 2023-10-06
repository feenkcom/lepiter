Extension { #name : #LeHtmlVisitor }

{ #category : #'*Lepiter-Snippet-Words' }
LeHtmlVisitor >> visitWordSnippet: aLeWordSnippet [
	context html
		tag: #div
		attributes: (self
				classesFor: aLeWordSnippet
				withClasses: 'snippet textual-snippet word-snippet')
		do: [ LeWordExplanationHtmlBuilder new
				explanation: aLeWordSnippet explanation;
				context: context;
				build ].

	^ self visitContent: aLeWordSnippet
]
