Extension { #name : #LeDatabaseSnippetUpdater }

{ #category : #'*Lepiter-Snippet-Text' }
LeDatabaseSnippetUpdater >> text: aText [
	self updateTimeAndEmail.
	super text: aText.
]
