Extension { #name : #LeHtmlVisitor }

{ #category : #'*Lepiter-Snippet-Example' }
LeHtmlVisitor >> visitExampleSnippet: aLeExampleSnippet [

	| snippetResources |
	
	snippetResources := self resourcesFor: aLeExampleSnippet.
	
	context html
		tag: #div
		do: [
		
			LeHtmlExampleWriter new 
				html: context html;
				sequencer: context sequencer;
				resources: snippetResources;
				write.

			self visitContent: aLeExampleSnippet ].
		
	^ aLeExampleSnippet
]

{ #category : #'*Lepiter-Snippet-Example' }
LeHtmlVisitor >> writeExampleSourceCode: aLeExampleSnippet [

	context html 
		tag: #div
		attributes: #('class' 'snippet textual-snippet code-snippet pharo-snippet documentWidth')
		do: [ 
			context html 
				tag: #pre
				attributes: #('class' 'no_bottom_margin') 
				do: [
					context html
						escape: aLeExampleSnippet referencedExample sourceCode asString
				]
		].
]
