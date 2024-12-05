Class {
	#name : #LeGitHubEditorAndSummaryModelElement,
	#superclass : #LeGitHubModelElement,
	#instVars : [
		'editorElement',
		'summaryElement'
	],
	#category : #'Lepiter-GitHub-UI Model Elements'
}

{ #category : #initialization }
LeGitHubEditorAndSummaryModelElement >> defaultEditorModelElementClass [
	<return: #LeGitHubEditorModelElement>
	^ self subclassResponsibility
]

{ #category : #initialization }
LeGitHubEditorAndSummaryModelElement >> defaultSummaryModelElementClass [
	<return: #LeGitHubModelElement>
	^ self subclassResponsibility
]

{ #category : #'private - accessing' }
LeGitHubEditorAndSummaryModelElement >> editorElement [
	<return: #LeGitHubTagEditorModelElement>
	^ editorElement
]

{ #category : #initialization }
LeGitHubEditorAndSummaryModelElement >> initialize [
	super initialize.
	self initializeEditorElement.
	self initializeSummaryElement.
	
	self addChild: self editorElement as: #editor.
	self addChild: self summaryElement as: #summary
]

{ #category : #initialization }
LeGitHubEditorAndSummaryModelElement >> initializeEditorElement [
	editorElement := self defaultEditorModelElementClass new
		visibility: BlVisibility gone
]

{ #category : #initialization }
LeGitHubEditorAndSummaryModelElement >> initializeSummaryElement [
	summaryElement := self defaultSummaryModelElementClass new
		visibility: BlVisibility gone
]

{ #category : #'private - updating' }
LeGitHubEditorAndSummaryModelElement >> showEditor [
	self editorElement model: self model.
	self editorElement visibility: BlVisibility visible.
	self summaryElement visibility: BlVisibility gone.
]

{ #category : #'private - updating' }
LeGitHubEditorAndSummaryModelElement >> showSummary [
	self summaryElement model: self model.
	self editorElement visibility: BlVisibility gone.
	self summaryElement visibility: BlVisibility visible.

]

{ #category : #'as yet unclassified' }
LeGitHubEditorAndSummaryModelElement >> snippetViewModel: anObject [
	super snippetViewModel: anObject.
	
	summaryElement snippetViewModel: anObject.
	editorElement snippetViewModel: anObject
]

{ #category : #'private - accessing' }
LeGitHubEditorAndSummaryModelElement >> summaryElement [
	<return: #LeGitHubTagSummaryModelElement>
	^ summaryElement
]

{ #category : #'private - updating' }
LeGitHubEditorAndSummaryModelElement >> updateElement [
	super updateElement.
	self hasSuccessResponse 
		ifTrue: [ self showSummary ]
		ifFalse: [ self showEditor ].
]
