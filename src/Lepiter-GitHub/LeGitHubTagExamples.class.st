Class {
	#name : 'LeGitHubTagExamples',
	#superclass : 'LeGitHubExamples',
	#category : 'Lepiter-GitHub-Examples'
}

{ #category : 'examples - ui auxiliar' }
LeGitHubTagExamples >> basicEditorModelElement [
	<gtExample>
	| anElement |
	anElement := LeGitHubTagEditorModelElement new.
	^ anElement
]

{ #category : 'examples - model' }
LeGitHubTagExamples >> basicModel [
	<gtExample>
	| aModel |
	aModel := LeGitHubTagModel new.
	^ aModel
]

{ #category : 'examples - ui model' }
LeGitHubTagExamples >> basicModelElement [
	<gtExample>
	| anElement |
	anElement := LeGitHubTagModelElement new.
	^ anElement
]

{ #category : 'examples - snippet' }
LeGitHubTagExamples >> basicSnippet [
	<gtExample>
	| aSnippet |
	aSnippet := LeGitHubTagSnippet new.
	^ aSnippet
]

{ #category : 'examples - ui snippet' }
LeGitHubTagExamples >> basicSnippetElement [
	<gtExample>
	| anElement |
	anElement := LeGitHubTagSnippetElement new.
	self assert: anElement hasSnippetViewModel not.
	^ anElement 
]

{ #category : 'examples - ui auxiliar' }
LeGitHubTagExamples >> basicSummaryModelElement [
	<gtExample>
	| anElement |
	anElement := LeGitHubTagSummaryModelElement new.
	^ anElement
]

{ #category : 'examples - ui auxiliar' }
LeGitHubTagExamples >> editorModelElement [
	<gtExample>
	| anElement aModel |
	anElement := self basicEditorModelElement.

	aModel := self model.
	anElement model: aModel.

	self assert: anElement model equals: aModel.
	
	^ anElement
]

{ #category : 'examples - model' }
LeGitHubTagExamples >> model [
	<gtExample>
	| aModel |
	aModel := self basicModel.
	aModel ownerName: self ownerName.
	aModel projectName: self projectName.
	aModel tagName: self tagName.
	^ aModel
]

{ #category : 'examples - ui model' }
LeGitHubTagExamples >> modelElement [
	<gtExample>
	| anElement aModel |
	anElement := self basicModelElement.

	aModel := self model.
	anElement model: aModel.

	self assert: anElement model equals: aModel.
	
	^ anElement
]

{ #category : 'examples - snippet' }
LeGitHubTagExamples >> snippet [
	<gtExample>
	| aSnippet |
	aSnippet := self basicSnippet.
	aSnippet ownerName: self ownerName.
	aSnippet projectName: self projectName.
	aSnippet tagName: self tagName.
	^ aSnippet
]

{ #category : 'examples - ui snippet' }
LeGitHubTagExamples >> snippetElement [
	<gtExample>
	| anElement aSnippet |
	anElement := self basicSnippetElement.
	aSnippet := self snippet.
	anElement snippetViewModel: aSnippet asSnippetViewModel.
	self assert: anElement snippet equals: aSnippet.
	^ anElement
]

{ #category : 'examples - ui snippet' }
LeGitHubTagExamples >> snippetElement_WithResponse [
	<gtExample>
	| anElement aSnippet |
	anElement := self basicSnippetElement.
	aSnippet := self snippet.
	aSnippet model response.
	anElement snippetViewModel: aSnippet asSnippetViewModel.
	self assert: anElement snippet equals: aSnippet.
	^ anElement
]

{ #category : 'examples - ui auxiliar' }
LeGitHubTagExamples >> summaryModelElement [
	<gtExample>
	| anElement aModel |
	anElement := self basicSummaryModelElement.

	aModel := self model.
	anElement model: aModel.

	self assert: anElement model equals: aModel.
	
	^ anElement
]

{ #category : 'examples - snippet' }
LeGitHubTagExamples >> tagName [
	^ 'v0.8.439'
]
