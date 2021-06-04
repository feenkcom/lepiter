Class {
	#name : #LeExampleSnippetElement,
	#superclass : #LeSnippetElement,
	#traits : 'TBlElementError',
	#classTraits : 'TBlElementError classTrait',
	#instVars : [
		'exampleContainer',
		'exampleEditor',
		'toolbarContainer',
		'updateRequester'
	],
	#category : #'Lepiter-Snippet-Example-Snippet'
}

{ #category : #initialization }
LeExampleSnippetElement >> initialize [
	super initialize.
	
	exampleContainer := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		layout: BlLinearLayout vertical;
		padding: (BlInsets top: 5 left: 7 bottom: 5 right: 5);
		yourself.	
	
	exampleEditor := GtTextualCoderEditorElement new
		hMatchParent;
		vFitContent;
		aptitude: BrGlamorousRegularEditorAptitude + BrGlamorousEditorSpacingAptitude;
		padding: (BlInsets top: 2 left: 3 bottom: 2 right: 3);
		margin: (BlInsets left: 2 right: 2).
	
	exampleEditor editor addEventHandler: (LeEditorReachedBorderEventHandler new snippetElement: self).

	toolbarContainer := BrHorizontalPane new
		hMatchParent;
		vFitContent;
		padding: (BlInsets top: 0 left: 3 bottom: 2 right: 3);
		addChildren: { 
			BrLabel new
				margin: (BlInsets top: 1);
				aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
				text: '{{gtExample:'.
			exampleEditor.
			BrLabel new
				margin: (BlInsets top: 1);
				aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
				text: '}}' }.
				
	updateRequester := GtPhlowUpdateRequester new 
		element: self selector: #updateExamplePreview.
]

{ #category : #'private - event handling' }
LeExampleSnippetElement >> onExampleSnippetContentChanged [
	updateRequester requestUpdate
]

{ #category : #'api - snippet view model' }
LeExampleSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.
	
	self updateExamplePreview
]

{ #category : #'api - snippet view model' }
LeExampleSnippetElement >> onSnippetViewModelFocused: aBoolean [
	"Override me to either request or lose focus when the focused state is changed in the UI Model"

	(aBoolean and: [ self snippetViewModel annotationCoderViewModel focused not ])
		ifTrue: [ self requestFocus ].

	aBoolean
		ifFalse: [ self loseFocus ]
]

{ #category : #'api - view' }
LeExampleSnippetElement >> snippetContent [
	"Return an element that represents a content of the snippet.
	The embedder is responsible for placing #snippetContent in the right place within snippet element depending on the
	View Model properties and derived look"
	<return: #BlElement>

	^ exampleContainer
]

{ #category : #'api - view' }
LeExampleSnippetElement >> snippetToolbar [
	"Return an element that represents a toolbar of the snippet. A toolbar usually appears below the snippet content.
	The embedder is responsible for placing #snippetToolbar in the right place within snippet element depending on the
	View Model properties and derived look.
	If returned #snippetToolbar is nil, no toolbar will be added"
	<return: #BlElement or: nil>

	^ toolbarContainer
]

{ #category : #'api - snippet view model' }
LeExampleSnippetElement >> subscribeToSnippetViewModel [
	super subscribeToSnippetViewModel.
	
	self snippetViewModel weak
		when: LeExampleSnippetContentChanged
		send: #onExampleSnippetContentChanged
		to: self
]

{ #category : #'private - updating' }
LeExampleSnippetElement >> updateExamplePreview [
	exampleEditor textualCoderViewModel: self snippetViewModel annotationCoderViewModel.
	
	exampleContainer removeChildNamed: #example.

	self snippetViewModel gtExampleDo: [ :aGtExample |
		| anExampleElement |
	
		anExampleElement := GtExamplePreviewStencil new
			example: aGtExample;
			codeExpanded: self snippetViewModel codeExpanded;
			noCode: self snippetViewModel noCode;
			previewExpanded: self snippetViewModel previewExpanded;
			previewShowSelector: self snippetViewModel previewShowSelector;
			previewHeight: self snippetViewModel previewHeight;
			asElement.

		exampleContainer addChild: anExampleElement as: #example.
		^ self ].
	
	exampleContainer addChild: (BrHorizontalPane new
		hMatchParent;
		vExact: self snippetViewModel previewHeight;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		alignCenter;
		background: self theme default backdropColor;
		addChild: (BrLabel new
			aptitude: (BrGlamorousLabelAptitude new light foreground: Color veryDarkGray);
			text: 'Example not found')
	) as: #example.
]

{ #category : #generated }
LeExampleSnippetElement >> visitPreviewShowArgument: aPreviewShowArgument [
	self previewShowSelector: aPreviewShowArgument selectorValue asSymbol
]
