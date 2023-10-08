Extension { #name : #LeHtmlVisitor }

{ #category : #'*Lepiter-Snippet-Example' }
LeHtmlVisitor >> visitExampleSnippet: aLeExampleSnippet [
	| snippetResources |
	snippetResources := self resourcesFor: aLeExampleSnippet.

	context html
		tag: #div
		do: [ LeHtmlExampleWriter new
				html: context html;
				sequencer: context sequencer;
				resources: snippetResources;
				width: aLeExampleSnippet asSnippetViewModel snippetView desiredSnippetWidth;
				write.

			self visitContent: aLeExampleSnippet ].

	^ aLeExampleSnippet
]
