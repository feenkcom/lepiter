Class {
	#name : 'LeGitHubIssueExamples',
	#superclass : 'LeGitHubExamples',
	#category : 'Lepiter-GitHub-Examples'
}

{ #category : 'examples - ui auxiliar ' }
LeGitHubIssueExamples >> basicEditorModelElement [
	<gtExample>
	| anElement |
	anElement := LeGitHubIssueEditorModelElement new.
	^ anElement
]

{ #category : 'examples - model' }
LeGitHubIssueExamples >> basicModel [
	<gtExample>
	| aModel |
	aModel := LeGitHubIssueModel new.
	^ aModel
]

{ #category : 'examples - ui model' }
LeGitHubIssueExamples >> basicModelElement [
	<gtExample>
	| anElement |
	anElement := LeGitHubIssueModelElement new.
	^ anElement
]

{ #category : 'examples - snippet' }
LeGitHubIssueExamples >> basicSnippet [
	<gtExample>
	| aSnippet |
	aSnippet := LeGitHubIssueSnippet new.
	^ aSnippet
]

{ #category : 'examples - ui snippet' }
LeGitHubIssueExamples >> basicSnippetElement [
	<gtExample>
	| anElement |
	anElement := LeGitHubIssueSnippetElement new.
	"self assert: anElement hasContent not."
	^ anElement 
]

{ #category : 'examples - ui auxiliar ' }
LeGitHubIssueExamples >> basicSummaryModelElement [
	<gtExample>
	| anElement |
	anElement := LeGitHubIssueSummaryModelElement new.
	^ anElement
]

{ #category : 'examples - ui auxiliar ' }
LeGitHubIssueExamples >> editorModelElement [
	<gtExample>
	| anElement aModel |
	anElement := self basicEditorModelElement.

	aModel := self model.
	anElement model: aModel.

	self assert: anElement model equals: aModel.
	
	^ anElement
]

{ #category : 'examples - model' }
LeGitHubIssueExamples >> issueNumber [
	^ 1772
]

{ #category : 'examples - model' }
LeGitHubIssueExamples >> model [
	<gtExample>
	| aModel |
	aModel := self basicModel.
	aModel ownerName: self ownerName.
	aModel projectName: self projectName.
	aModel issueNumber: self issueNumber.
	^ aModel
]

{ #category : 'examples - ui model' }
LeGitHubIssueExamples >> modelElement [
	<gtExample>
	| anElement aModel |
	anElement := self basicModelElement.

	aModel := self model.
	anElement model: aModel.

	self assert: anElement model equals: aModel.
	
	^ anElement
]

{ #category : 'examples - snippet' }
LeGitHubIssueExamples >> snippet [
	<gtExample>
	| aSnippet |
	aSnippet := self basicSnippet.
	aSnippet ownerName: self ownerName.
	aSnippet projectName: self projectName.
	aSnippet issueNumber: self issueNumber.
	^ aSnippet
]

{ #category : 'examples - ui snippet' }
LeGitHubIssueExamples >> snippetElement [
	<gtExample>
	| anElement aSnippet |
	anElement := self basicSnippetElement.
	aSnippet := self snippet.
	anElement snippetViewModel: aSnippet asSnippetViewModel.
	self assert: anElement snippet equals: aSnippet.
	^ anElement 
]

{ #category : 'examples - ui snippet' }
LeGitHubIssueExamples >> snippetElement_WithResponse [
	<gtExample>
	| anElement aSnippet |
	anElement := self basicSnippetElement.
	aSnippet := self snippet.
	aSnippet model response.
	anElement snippetViewModel: aSnippet asSnippetViewModel.
	self assert: anElement snippet equals: aSnippet.
	^ anElement 
]

{ #category : 'examples - ui auxiliar ' }
LeGitHubIssueExamples >> summaryModelElement [
	<gtExample>
	| anElement aModel |
	anElement := self basicSummaryModelElement.

	aModel := self model.
	aModel response.
	anElement model: aModel.

	self assert: anElement model equals: aModel.
	
	^ anElement
]

{ #category : 'examples - ui auxiliar ' }
LeGitHubIssueExamples >> summaryModelElement_ResponseAfter [
	<gtExample>
	| anElement aModel |
	anElement := self basicSummaryModelElement.

	aModel := self model.
	anElement model: aModel.
	aModel response.

	self assert: anElement model equals: aModel.
	
	^ anElement
]
