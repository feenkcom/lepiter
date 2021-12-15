Class {
	#name : #LeGitHubTagSummaryModelElement,
	#superclass : #LeGitHubModelElement,
	#instVars : [
		'messageElement',
		'titleElement'
	],
	#category : 'Lepiter-GitHub-UI Model Elements'
}

{ #category : #initialization }
LeGitHubTagSummaryModelElement >> initialize [
	super initialize.

	self initializeTitleElement.
	self initializeMessageElement.
	
	self addChild: self titleElement as: #title.
	self addChild: self messageElement as: #message.
	
	self addAptitude: (BrLayoutResizerAptitude inherit 
		anyToFitContent: self titleElement;
		hInherit: self messageElement;
		vAnyToFitContent: self messageElement).
	
]

{ #category : #initialization }
LeGitHubTagSummaryModelElement >> initializeMessageElement [
	messageElement := BrEditor new
		beReadOnlyWithSelection;
		aptitude: BrGlamorousRegularEditorAptitude;
		styler: LeSnippetStyler new;
		hMatchParent;
		vFitContentLimited. 
]

{ #category : #initialization }
LeGitHubTagSummaryModelElement >> initializeTitleElement [
	titleElement := BrLabel new
		text: '';
		beLargeSize;
		aptitude: (BrGlamorousLabelAptitude new bold);
		fitContent.
]

{ #category : #'private - accessing' }
LeGitHubTagSummaryModelElement >> messageElement [
	<return: #BrEditor>
	^ messageElement
]

{ #category : #'private - accessing' }
LeGitHubTagSummaryModelElement >> titleElement [
	<return: #BrLabel>
	^ titleElement
]

{ #category : #'private - updating' }
LeGitHubTagSummaryModelElement >> updateElement [
	super updateElement.

	self titleElement text: self model tagName.
	self messageElement text: self model message.
]
