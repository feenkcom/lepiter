Extension { #name : #LeHtmlBookFragmentExporterVisitor }

{ #category : #'*Lepiter-Snippet-Youtube' }
LeHtmlBookFragmentExporterVisitor >> visitYoutubeReferenceSnippet: aLeYoutubeReferenceSnippet [
	self putTag: 'div' andAttributes: #('class' 'snippet youtube-reference-snippet') with: [
		self putString: aLeYoutubeReferenceSnippet html]
]
