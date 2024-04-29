Extension { #name : #LeShellCommandSnippet }

{ #category : #'*Lepiter-UI' }
LeShellCommandSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeShellCommandSnippetViewModel new snippetModel: self
]
