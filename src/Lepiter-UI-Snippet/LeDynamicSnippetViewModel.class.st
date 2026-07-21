Class {
	#name : #LeDynamicSnippetViewModel,
	#superclass : #LeAbstractSnippetViewModel,
	#category : 'Lepiter-UI-Snippet-! View Models'
}

{ #category : #accessing }
LeDynamicSnippetViewModel >> snippetView [
	<return: #LeSnippetView>

	^ super snippetView needsEmbellishments: false
]
