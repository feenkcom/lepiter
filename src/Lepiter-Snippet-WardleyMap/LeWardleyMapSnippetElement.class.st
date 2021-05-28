Class {
	#name : #LeWardleyMapSnippetElement,
	#superclass : #LeSnippetElement,
	#instVars : [
		'wardleyMapElement',
		'wardleyMapContainer'
	],
	#category : #'Lepiter-Snippet-WardleyMap-Snippet'
}

{ #category : #initialization }
LeWardleyMapSnippetElement >> initialize [
	super initialize.
	
	wardleyMapElement := LeWardleyMapElement new.
	wardleyMapElement vExact: 300.
	wardleyMapElement evolutionSections: {
		'genesis'.
		'custom built'.
		'product (+rental)'.
		'commodity'
	}.
	
	wardleyMapElement addAptitude: BrGlamorousWithVerticalResizerAptitude new beBottom.
	wardleyMapElement
		when: BlResizerResizedEvent
		do: [ :aResizerEvent | self snippet height: aResizerEvent extent y ].

	wardleyMapContainer := BrVerticalPane new
		fitContent;
		addChild: wardleyMapElement
]

{ #category : #'private - event handling' }
LeWardleyMapSnippetElement >> onSnippetHeightChanged [
	wardleyMapElement vExact: self snippet height
]

{ #category : #'api - snippet view model' }
LeWardleyMapSnippetElement >> onSnippetViewModelChanged [
	"Is sent when a new Snippet view model is assigned to the element"

	| aWardleyMapViewModel |
	aWardleyMapViewModel := GtWardleyMapViewModel new.
	aWardleyMapViewModel
		wardleyMapModel: self snippetViewModel snippetModel wardleyMap.
	wardleyMapElement snippet: self snippet.
	wardleyMapElement wardleyMapViewModel: aWardleyMapViewModel.
	self onSnippetHeightChanged
]

{ #category : #'api - snippet view model' }
LeWardleyMapSnippetElement >> onSnippetViewModelFocused: aBoolean [
	"Override me to either request or lose focus when the focused state is changed in the UI Model"

	aBoolean
		ifTrue: [ self requestFocus ]
		ifFalse: [ self loseFocus ]
]

{ #category : #'api - view' }
LeWardleyMapSnippetElement >> snippetContent [
	"Return an element that represents a content of the snippet.
	The embedder is responsible for placing #snippetContent in the right place within snippet element depending on the
	View Model properties and derived look"
	<return: #BlElement>

	^ wardleyMapContainer
]

{ #category : #'api - view' }
LeWardleyMapSnippetElement >> snippetToolbar [
	"Return an element that represents a toolbar of the snippet. A toolbar usually appears below the snippet content.
	The embedder is responsible for placing #snippetToolbar in the right place within snippet element depending on the
	View Model properties and derived look.
	If returned #snippetToolbar is nil, no toolbar will be added"
	<return: #BlElement or: nil>

	^ nil
]

{ #category : #'api - snippet view model' }
LeWardleyMapSnippetElement >> subscribeToSnippetViewModel [
	super subscribeToSnippetViewModel.
	
	self snippet weak
		when: LeSnippetHeightChanged
		send: #onSnippetHeightChanged
		to: self
]

{ #category : #'api - snippet view model' }
LeWardleyMapSnippetElement >> unsubscribeFromSnippetViewModel [
	super unsubscribeFromSnippetViewModel.

	self snippet unsubscribe: self
]
