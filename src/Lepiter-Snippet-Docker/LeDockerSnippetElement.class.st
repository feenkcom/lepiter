Class {
	#name : #LeDockerSnippetElement,
	#superclass : #LeSnippetElement,
	#instVars : [
		'contentElement',
		'urlInputElement'
	],
	#category : #'Lepiter-Snippet-Docker-View-Element'
}

{ #category : #accessing }
LeDockerSnippetElement >> contentElement [
	^ contentElement
]

{ #category : #accessing }
LeDockerSnippetElement >> createFormElement [
	| formElement |
	formElement := BlElement new.
	formElement
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal matchParent ].
	formElement
		layout:
			(BlGridLayout horizontal
				columnCount: 3;
				cellSpacing: 10).
	urlInputElement := self inputElementNamed: 'Url' in: formElement.
	formElement addChild: self createInspectButtonToolbar.
	^ formElement 
]

{ #category : #accessing }
LeDockerSnippetElement >> createInspectButtonToolbar [
	| playInspectButton |
	playInspectButton := BrButton new.
	playInspectButton
		beSmallSize;
		aptitude: BrGlamorousButtonWithIconAptitude;
		label: 'Inspect connection';
		icon: BrGlamorousVectorIcons playinspect;
		constraintsDo: [ :c | 
			c grid vertical alignCenter ];
		action: [ | urlString |
			urlString := urlInputElement editor text asString.
			playInspectButton phlow 
						spawnObject: (GtDeAPIClient new baseUrl: urlString)].
	
	^ playInspectButton
]

{ #category : #accessing }
LeDockerSnippetElement >> initialize [
	| formElement |
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
	| labelElement inputElement |
	labelElement := BrLabel new text: aString, ':'; aptitude: BrGlamorousLabelAptitude.
	labelElement constraintsDo: [ :c | 
		c vertical fitContent.
		c horizontal fitContent.
		c grid vertical alignCenter ].
	
	inputElement := BrEditor new
				hMatchParent;
				vFitContentLimited;
				aptitude: BrGlamorousInputFieldSpacingAptitude new + BrGlamorousRegularEditorAptitude new;
				text: 'http://localhost:2375'.
	
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
	^ nil
]
