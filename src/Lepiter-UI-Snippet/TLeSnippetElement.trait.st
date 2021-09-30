Trait {
	#name : #TLeSnippetElement,
	#category : 'Lepiter-UI-Snippet-! Views'
}

{ #category : #'api - snippet view model' }
TLeSnippetElement >> alignContentLeftBy: aNumber [
	"All snippets should be nicely aligned to the left. However, only snippets themselves know their content and layout structure.
	Override me to align the content by aNumber of points to the left. Usually it should just involve setting a corresponding padding or margin"
]

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
