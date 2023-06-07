Extension { #name : #LeHtmlFragmentExporterVisitor }

{ #category : #'*Lepiter-Snippet-Youtube' }
LeHtmlFragmentExporterVisitor >> visitYoutubeReferenceSnippet: aLeYoutubeReferenceSnippet [
	self putTag: 'div' andAttributes: #('class' 'snippet youtube-reference-snippet') with: [
		self putString: aLeYoutubeReferenceSnippet html]
]
