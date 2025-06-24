Class {
	#name : #LeGitHubIssueExamples,
	#superclass : #LeGitHubExamples,
	#category : #'Lepiter-GitHub-Examples'
}

{ #category : #'examples - ui auxiliar ' }
LeGitHubIssueExamples >> basicEditorModelElement [
	<gtExample>
	<return: #LeGitHubIssueEditorModelElement>
	| anElement |
	anElement := LeGitHubIssueEditorModelElement new.
	^ anElement
]

{ #category : #'examples - model' }
LeGitHubIssueExamples >> basicModel [
	<gtExample>
	<return: #LeGitHubIssueModel>
	| aModel |
	aModel := LeGitHubIssueModel new.
	^ aModel
]

{ #category : #'examples - ui model' }
LeGitHubIssueExamples >> basicModelElement [
	<gtExample>
	<return: #LeGitHubIssueModelElement>
	| anElement |
	anElement := LeGitHubIssueModelElement new.
	^ anElement
]

{ #category : #'examples - snippet' }
LeGitHubIssueExamples >> basicSnippet [
	<gtExample>
	<return: #LeGitHubIssueSnippet>
	| aSnippet |
	aSnippet := LeGitHubIssueSnippet new.
	^ aSnippet
]

{ #category : #'examples - ui snippet' }
LeGitHubIssueExamples >> basicSnippetElement [
	<gtExample>
	<return: #LeGitHubIssueSnippetElement>
	| anElement |
	anElement := LeGitHubIssueSnippetElement new.	"self assert: anElement hasContent not."
	^ anElement
]

{ #category : #'examples - ui auxiliar ' }
LeGitHubIssueExamples >> basicSummaryModelElement [
	<gtExample>
	<return: #LeGitHubIssueSummaryModelElement>
	| anElement |
	anElement := LeGitHubIssueSummaryModelElement new.
	^ anElement
]

{ #category : #'examples - ui auxiliar ' }
LeGitHubIssueExamples >> editorModelElement [
	<gtExample>
	<return: #LeGitHubIssueEditorModelElement>
	| anElement aModel |
	anElement := self basicEditorModelElement.

	aModel := self model.
	anElement model: aModel.

	self assert: anElement model equals: aModel.

	^ anElement
]

{ #category : #'examples - model' }
LeGitHubIssueExamples >> issueNumber [
	^ 1772
]

{ #category : #'examples - model' }
LeGitHubIssueExamples >> model [
	<gtExample>
	<return: #LeGitHubIssueModel>
	| aModel |
	aModel := self basicModel.
	aModel ownerName: self ownerName.
	aModel projectName: self projectName.
	aModel issueNumber: self issueNumber.
	^ aModel
]

{ #category : #'examples - ui model' }
LeGitHubIssueExamples >> modelElement [
	<gtExample>
	<return: #LeGitHubIssueModelElement>
	| anElement aModel |
	anElement := self basicModelElement.

	aModel := self model.
	anElement model: aModel.

	self assert: anElement model equals: aModel.

	^ anElement
]

{ #category : #'examples - snippet' }
LeGitHubIssueExamples >> snippet [
	<gtExample>
	<return: #LeGitHubIssueSnippet>
	| aSnippet |
	aSnippet := self basicSnippet.
	aSnippet ownerName: self ownerName.
	aSnippet projectName: self projectName.
	aSnippet issueNumber: self issueNumber.
	^ aSnippet
]

{ #category : #'examples - ui snippet' }
LeGitHubIssueExamples >> snippetElement [
	<gtExample>
	<return: #LeGitHubIssueSnippetElement>
	| anElement aSnippet |
	anElement := self basicSnippetElement.
	aSnippet := self snippet.
	anElement snippetViewModel: aSnippet asSnippetViewModel.
	self assert: anElement snippet equals: aSnippet.
	^ anElement
]

{ #category : #'examples - ui snippet' }
LeGitHubIssueExamples >> snippetElement_WithResponse [
	<gtExample>
	<return: #LeGitHubIssueSnippetElement>
	| anElement aSnippet |
	anElement := self basicSnippetElement.
	aSnippet := self snippet.
	aSnippet model response.
	anElement snippetViewModel: aSnippet asSnippetViewModel.
	self assert: anElement snippet equals: aSnippet.
	^ anElement
]

{ #category : #'examples - ui auxiliar ' }
LeGitHubIssueExamples >> summaryModelElement [
	<gtExample>
	<return: #LeGitHubIssueSummaryModelElement>
	| anElement aModel |
	anElement := self basicSummaryModelElement.

	aModel := self model.
	aModel response.
	anElement model: aModel.

	self assert: anElement model equals: aModel.

	^ anElement
]

{ #category : #'examples - ui auxiliar ' }
LeGitHubIssueExamples >> summaryModelElement_ResponseAfter [
	<gtExample>
	<return: #LeGitHubIssueSummaryModelElement>
	| anElement aModel |
	anElement := self basicSummaryModelElement.

	aModel := self model.
	anElement model: aModel.
	aModel response.

	self assert: anElement model equals: aModel.

	^ anElement
]
