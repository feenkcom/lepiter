Class {
	#name : #LeGitHubIssueEditorModelElement,
	#superclass : #LeGitHubEditorModelElement,
	#instVars : [
		'issueEditor'
	],
	#category : 'Lepiter-GitHub-UI Model Elements'
}

{ #category : #initialization }
LeGitHubIssueEditorModelElement >> defaultTitle [
	^ 'Provide GitHub Issue Information'
]

{ #category : #initialization }
LeGitHubIssueEditorModelElement >> initializeInputFieldsElement [
	super initializeInputFieldsElement.
	
	issueEditor := self newInputNamed: self issueFieldName onModificationDo: [ :anEvent |
		self onIssueInputModified: anEvent ].
]

{ #category : #'private - accessing' }
LeGitHubIssueEditorModelElement >> issueEditor [
	<return: #BrEditor>
	^ issueEditor
]

{ #category : #'private - constants' }
LeGitHubIssueEditorModelElement >> issueFieldName [
	^ 'Issue Number'
]

{ #category : #initialization }
LeGitHubIssueEditorModelElement >> onIssueInputModified: anEvent [ 
	self model issueNumber: anEvent text asString source: self
]

{ #category : #'private - updating' }
LeGitHubIssueEditorModelElement >> updateInputFieldsElement [
	super updateInputFieldsElement.
	self issueEditor text: self model issueNumber asString.
]
