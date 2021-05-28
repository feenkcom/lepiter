Trait {
	#name : #TLeSnippetElement,
	#category : #'Lepiter-UI-Snippet-! Views'
}

{ #category : #'api - snippet view model' }
TLeSnippetElement >> snippetContent [
	<return: #BlElement>

	^ nil
]

{ #category : #'api - snippet view model' }
TLeSnippetElement >> snippetViewModel [
	"Return a not-null Snippet view model assigned to the receiver element"

	^ self explicitRequirement
]

{ #category : #'api - snippet view model' }
TLeSnippetElement >> snippetViewModel: aSnippetViewModel [
	"Set a not-null Snippet view model assigned to the receiver element"
	
	self explicitRequirement
]
