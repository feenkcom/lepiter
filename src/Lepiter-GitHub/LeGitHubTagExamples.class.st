Class {
	#name : #LeGitHubTagExamples,
	#superclass : #LeGitHubExamples,
	#category : #'Lepiter-GitHub-Examples'
}

{ #category : #'examples - ui auxiliar' }
LeGitHubTagExamples >> basicEditorModelElement [
	<gtExample>
	<return: #LeGitHubTagEditorModelElement>
	| anElement |
	anElement := LeGitHubTagEditorModelElement new.
	^ anElement
]

{ #category : #'examples - model' }
LeGitHubTagExamples >> basicModel [
	<gtExample>
	<return: #LeGitHubTagModel>
	| aModel |
	aModel := LeGitHubTagModel new.
	^ aModel
]

{ #category : #'examples - ui model' }
LeGitHubTagExamples >> basicModelElement [
	<gtExample>
	<return: #LeGitHubTagModelElement>
	| anElement |
	anElement := LeGitHubTagModelElement new.
	^ anElement
]

{ #category : #'examples - snippet' }
LeGitHubTagExamples >> basicSnippet [
	<gtExample>
	<return: #LeGitHubTagSnippet>
	| aSnippet |
	aSnippet := LeGitHubTagSnippet new.
	^ aSnippet
]

{ #category : #'examples - ui snippet' }
LeGitHubTagExamples >> basicSnippetElement [
	<gtExample>
	<return: #LeGitHubTagSnippetElement>
	| anElement |
	anElement := LeGitHubTagSnippetElement new.
	self assert: anElement hasSnippetViewModel not.
	^ anElement
]

{ #category : #'examples - ui auxiliar' }
LeGitHubTagExamples >> basicSummaryModelElement [
	<gtExample>
	<return: #LeGitHubTagSummaryModelElement>
	| anElement |
	anElement := LeGitHubTagSummaryModelElement new.
	^ anElement
]

{ #category : #'examples - ui auxiliar' }
LeGitHubTagExamples >> editorModelElement [
	<gtExample>
	<return: #LeGitHubTagEditorModelElement>
	| anElement aModel |
	anElement := self basicEditorModelElement.

	aModel := self model.
	anElement model: aModel.

	self assert: anElement model equals: aModel.

	^ anElement
]

{ #category : #'examples - model' }
LeGitHubTagExamples >> model [
	<gtExample>
	<return: #LeGitHubTagModel>
	| aModel |
	aModel := self basicModel.
	aModel ownerName: self ownerName.
	aModel projectName: self projectName.
	aModel tagName: self tagName.
	^ aModel
]

{ #category : #'examples - ui model' }
LeGitHubTagExamples >> modelElement [
	<gtExample>
	<return: #LeGitHubTagModelElement>
	| anElement aModel |
	anElement := self basicModelElement.

	aModel := self model.
	anElement model: aModel.

	self assert: anElement model equals: aModel.

	^ anElement
]

{ #category : #'examples - snippet' }
LeGitHubTagExamples >> snippet [
	<gtExample>
	<return: #LeGitHubTagSnippet>
	| aSnippet |
	aSnippet := self basicSnippet.
	aSnippet ownerName: self ownerName.
	aSnippet projectName: self projectName.
	aSnippet tagName: self tagName.
	^ aSnippet
]

{ #category : #'examples - ui snippet' }
LeGitHubTagExamples >> snippetElement [
	<gtExample>
	<return: #LeGitHubTagSnippetElement>
	| anElement aSnippet |
	anElement := self basicSnippetElement.
	aSnippet := self snippet.
	anElement snippetViewModel: aSnippet asSnippetViewModel.
	self assert: anElement snippet equals: aSnippet.
	^ anElement
]

{ #category : #'examples - ui snippet' }
LeGitHubTagExamples >> snippetElement_WithResponse [
	<gtExample>
	<return: #LeGitHubTagSnippetElement>
	| anElement aSnippet |
	anElement := self basicSnippetElement.
	aSnippet := self snippet.
	aSnippet model response.
	anElement snippetViewModel: aSnippet asSnippetViewModel.
	self assert: anElement snippet equals: aSnippet.
	^ anElement
]

{ #category : #'examples - ui auxiliar' }
LeGitHubTagExamples >> summaryModelElement [
	<gtExample>
	<return: #LeGitHubTagSummaryModelElement>
	| anElement aModel |
	anElement := self basicSummaryModelElement.

	aModel := self model.
	anElement model: aModel.

	self assert: anElement model equals: aModel.

	^ anElement
]

{ #category : #'examples - snippet' }
LeGitHubTagExamples >> tagName [
	^ 'v0.8.439'
]
