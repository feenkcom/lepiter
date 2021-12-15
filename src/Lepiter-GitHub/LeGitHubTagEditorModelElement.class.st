Class {
	#name : #LeGitHubTagEditorModelElement,
	#superclass : #LeGitHubEditorModelElement,
	#instVars : [
		'tagEditor'
	],
	#category : 'Lepiter-GitHub-UI Model Elements'
}

{ #category : #initialization }
LeGitHubTagEditorModelElement >> defaultTitle [
	^ 'Provide GitHub Tag Information'
]

{ #category : #initialization }
LeGitHubTagEditorModelElement >> initializeInputFieldsElement [
	super initializeInputFieldsElement.
	
	tagEditor := self newInputNamed: self tagFieldName onModificationDo: [ :anEvent |
		self onTagInputModified: anEvent ].
]

{ #category : #initialization }
LeGitHubTagEditorModelElement >> onTagInputModified: anEvent [ 
	self model tagName: anEvent text asString source: self
]

{ #category : #'private - accessing' }
LeGitHubTagEditorModelElement >> tagEditor [
	<return: #BrEditor>
	^ tagEditor
]

{ #category : #'private - constants' }
LeGitHubTagEditorModelElement >> tagFieldName [
	^ 'Tag'
]

{ #category : #'private - updating' }
LeGitHubTagEditorModelElement >> updateInputFieldsElement [
	super updateInputFieldsElement.
	self tagEditor text: self model tagName.
]
