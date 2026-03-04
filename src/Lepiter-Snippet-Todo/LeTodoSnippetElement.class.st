"
I render a {{gtClass:name=LeTodoSnippet}} with a state dropdown and a description editor.
"
Class {
	#name : #LeTodoSnippetElement,
	#superclass : #LeTextCoderSnippetElement,
	#instVars : [
		'contentElement',
		'stateDropDown',
		'stateDropDownHandle'
	],
	#category : #'Lepiter-Snippet-Todo'
}

{ #category : #accessing }
LeTodoSnippetElement >> contentElement [
	^ contentElement
]

{ #category : #initialization }
LeTodoSnippetElement >> initialize [
	super initialize.
	self initializeStateDropDown.
	self initializeContentElement
]

{ #category : #initialization }
LeTodoSnippetElement >> initializeContentElement [
	contentElement := BrHorizontalPane new
		cellSpacing: 8;
		alignTopLeft;
		addChild: stateDropDown;
		addChild: self editorElement;
		yourself
]

{ #category : #initialization }
LeTodoSnippetElement >> initializeEditorElement [
	super initializeEditorElement.
	editorElement padding: (BlInsets left: 5 right: 5)
]

{ #category : #initialization }
LeTodoSnippetElement >> initializeStateDropDown [
	stateDropDownHandle := BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude - BrGlamorousButtonExteriorAptitude;
		padding: (BlInsets top: 3 left: 5 bottom: 3 right: 5);
		label: '';
		yourself.

	stateDropDown := BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude;
		padding: (BlInsets top: 3 left: 5 bottom: 3 right: 5);
		addAptitude: (BrGlamorousWithExplicitDropdownAptitude
			handle: [ stateDropDownHandle ]
			content: [ self popupListForStates ]);
		label: '';
		yourself
]

{ #category : #updating }
LeTodoSnippetElement >> onSnippetStateChanged: anAnnouncement [
	self updateStateDropDown
]

{ #category : #updating }
LeTodoSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.
	self updateStateDropDown
]

{ #category : #private }
LeTodoSnippetElement >> popupListForStates [
	| list |
	list := BrSimpleList new.
	list hFitContent.
	list
		stencil: [ :each :index |
			(BrLabel new)
				aptitude: BrGlamorousLabelAptitude new + BrGlamorousListItemAptitude;
				padding: (BlInsets top: 3 left: 3 bottom: 3 right: 8);
				text: (self snippetViewModel stateLabelFor: each);
				hMatchParent;
				when: BlClickEvent do: [ :event |
					event consumed: true.
					self snippet state: each.
					list selectOne: index.
					event currentTarget fireEvent: BrDropdownHideWish new ];
				yourself ].
	list items: self snippetViewModel states.
	^ list
]

{ #category : #accessing }
LeTodoSnippetElement >> snippetContent [
	<return: #BlElement>
	^ self contentElement
]

{ #category : #subscriptions }
LeTodoSnippetElement >> subscribeToSnippetViewModel [
	super subscribeToSnippetViewModel.
	self snippet weak
		when: LeTodoSnippetStateChanged
		send: #onSnippetStateChanged:
		to: self
]

{ #category : #updating }
LeTodoSnippetElement >> updateStateDropDown [
	| label |
	label := self snippetViewModel stateLabel.
	stateDropDown label: label.
	stateDropDownHandle label: label
]
