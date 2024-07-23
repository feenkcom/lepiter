Class {
	#name : #LeWardleyMapSnippetElement,
	#superclass : #LeSnippetElement,
	#instVars : [
		'wardleyMapElement',
		'wardleyMapContainer',
		'maximizerAptitude'
	],
	#category : #'Lepiter-Snippet-WardleyMap-Snippet'
}

{ #category : #accessing }
LeWardleyMapSnippetElement >> gtWardleyScriptFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Wardley script';
		priority: 0.5;
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ GtWardleyMapParser gtStyler ];
		text: [ self snippet wardleyMap asWardleyMapScript ];
		actionUpdateButtonTooltip: 'Update Script';
		actionButtonLabel: 'Import'
			tooltip: 'Create a new Wardley script model'
			action: [ :aButton | 
				| aText aWardleyMap |
				aText := aButton phlow textViewContent.
				aText 
					ifNotNil: [
						aWardleyMap := GtWardleyMapScriptImporter forString: aText asString.
						self snippet wardleyMap: aWardleyMap ]
					ifNil: [ self inform: 'Cannot find text editor with Wardley script' ] ];
		actionButtonLabel: 'Copy'
			action: [ Clipboard clipboardText: self snippet wardleyMap asWardleyMapScript ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Model'
			tooltip: 'Inspect Wardley Map model'
			action: [ :aButton | aButton phlow spawnObject: self snippet wardleyMap ]
]

{ #category : #initialization }
LeWardleyMapSnippetElement >> initialize [
	super initialize.
	
	wardleyMapElement := GtWardleyMapElement new.
	wardleyMapElement vExact: 300.
	
	wardleyMapElement addAptitude: BrGlamorousWithVerticalResizerAptitude new beBottom.
	wardleyMapElement
		when: BlResizerResizedEvent
		do: [ :aResizerEvent | self snippet height: aResizerEvent extent y ].

	maximizerAptitude := BrGlamorousWithMaximizerAptitude new
		// GtWardleyMapElement;
		preferredBackground: Color white.
		
	wardleyMapContainer := BrVerticalPane new
		fitContent;
		clipChildren: true;
		addAptitude: maximizerAptitude;
		addChild: wardleyMapElement.
	self onSnippetViewModelFocused: false
]

{ #category : #'private - event handling' }
LeWardleyMapSnippetElement >> onSnippetHeightChanged [
	wardleyMapElement vExact: self snippet height
]

{ #category : #'api - snippet view model' }
LeWardleyMapSnippetElement >> onSnippetViewModelChanged [
	"Is sent when a new Snippet view model is assigned to the element"

	wardleyMapElement wardleyMapViewModel: self snippetViewModel wardleyMapViewModel.
	self onSnippetHeightChanged
]

{ #category : #'api - snippet view model' }
LeWardleyMapSnippetElement >> onSnippetViewModelFocused: aBoolean [
	"Override me to either request or lose focus when the focused state is changed in the UI Model"

	aBoolean
		ifTrue: [ self requestFocus ]
		ifFalse: [ self loseFocus ].
	aBoolean
		ifTrue: [ maximizerAptitude showMaximizeButton ]
		ifFalse: [ maximizerAptitude hideMaximizeButton ].
]

{ #category : #'api - snippet view model' }
LeWardleyMapSnippetElement >> onSnippetWardleyMapChanged [
	wardleyMapElement wardleyMapViewModel: (GtWardleyMapViewModel new 
		wardleyMapModel: self snippet wardleyMap)
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
		to: self.
		
	self snippet weak 
		when: LeSnippetWardleyMapChanged
		send: #onSnippetWardleyMapChanged
		to: self
]

{ #category : #'api - snippet view model' }
LeWardleyMapSnippetElement >> unsubscribeFromSnippetViewModel [
	super unsubscribeFromSnippetViewModel.

	self snippet unsubscribe: self
]

{ #category : #accessing }
LeWardleyMapSnippetElement >> wardleyMapViewModel [
	^ wardleyMapElement wardleyMapViewModel
]
