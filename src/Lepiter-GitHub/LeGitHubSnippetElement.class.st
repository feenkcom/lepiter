Class {
	#name : #LeGitHubSnippetElement,
	#superclass : #LeSnippetElement,
	#instVars : [
		'modelElement'
	],
	#category : #'Lepiter-GitHub-UI Snippet Elements'
}

{ #category : #initialization }
LeGitHubSnippetElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
LeGitHubSnippetElement >> defaultModelElement [
	<return: #LeGitHubModelElement>
	^ self subclassResponsibility
]

{ #category : #initialization }
LeGitHubSnippetElement >> initialize [
	super initialize.
	
	modelElement := self defaultModelElement
]

{ #category : #'private - accessing' }
LeGitHubSnippetElement >> modelElement [
	<return: #LeGitHubModelElement>
	^ modelElement
]

{ #category : #'api - snippet view model' }
LeGitHubSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.
	self modelElement
		model: self snippet model;
		snippetViewModel: self snippetViewModel
]

{ #category : #'api - view' }
LeGitHubSnippetElement >> snippetContent [
	"Return an element that represents a content of the snippet.
	The embedder is responsible for placing #snippetContent in the right place within snippet element depending on the
	View Model properties and derived look"
	<return: #BlElement>

	^ self modelElement
]

{ #category : #'api - view' }
LeGitHubSnippetElement >> snippetToolbar [
	"Return an element that represents a toolbar of the snippet. A toolbar usually appears below the snippet content.
	The embedder is responsible for placing #snippetToolbar in the right place within snippet element depending on the
	View Model properties and derived look.
	If returned #snippetToolbar is nil, no toolbar will be added"
	<return: #BlElement or: nil>

	^ nil
]
