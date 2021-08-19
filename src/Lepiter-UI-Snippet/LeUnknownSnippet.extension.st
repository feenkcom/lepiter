Extension { #name : 'LeUnknownSnippet' }

{ #category : '*Lepiter-UI-Snippet' }
LeUnknownSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeUnknownSnippetViewModel new snippetModel: self
]
