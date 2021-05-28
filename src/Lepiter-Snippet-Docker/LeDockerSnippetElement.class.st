Class {
	#name : #LeDockerSnippetElement,
	#superclass : #LeSnippetElement,
	#instVars : [
		'contentElement'
	],
	#category : #'Lepiter-Snippet-Docker-View-Element'
}

{ #category : #accessing }
LeDockerSnippetElement >> contentElement [
	^ contentElement
]

{ #category : #accessing }
LeDockerSnippetElement >> createFormElement [
	| jenkinsAccount urlInputElement formElement |
	formElement := BlElement new.
	formElement
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal matchParent ].
	formElement
		layout:
			(BlGridLayout horizontal
				columnCount: 2;
				cellSpacing: 10).
	urlInputElement := self inputElementNamed: 'Url' in: formElement.
	
	^ formElement 
]

{ #category : #accessing }
LeDockerSnippetElement >> initialize [
	| snippetContainer playBlueInspectButton anExpanderElement jenkinsAccount formElement |
	super initialize.
	contentElement := BrVerticalPane new.
	formElement := self createFormElement.
		contentElement
		vFitContent;
		hMatchParent.
	"contentElement addChild: resultContainer."
	contentElement addChild: formElement.
	"contentElement addChild: toolbar.
	showFormToggle := self createShowFormToggleButton.
	contentElement addChild: showFormToggle."
]

{ #category : #accessing }
LeDockerSnippetElement >> inputElementNamed: aString in: formElement [
	| labelElement inputElement text |
	labelElement := BrLabel new text: aString, ':'; aptitude: BrGlamorousLabelAptitude.
	labelElement constraintsDo: [ :c | 
		c vertical fitContent.
		c horizontal fitContent.
		c grid vertical alignCenter ].
	
	inputElement := BrEditor new
				hMatchParent;
				vFitContentLimited;
				aptitude: BrGlamorousInputFieldSpacingAptitude new + BrGlamorousRegularEditorAptitude new;
				text: ''.
	
	formElement addChild: labelElement.
	formElement addChild: inputElement.
	^ inputElement
]

{ #category : #accessing }
LeDockerSnippetElement >> snippetContent [
	^ contentElement
]

{ #category : #accessing }
LeDockerSnippetElement >> snippetToolbar [
]
