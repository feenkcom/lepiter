"
I am a {{gtClass:LeSnippetElement}}.
I display {{gtClass:LeWordSnippet}} information.
## Example
### User Input
{{gtExample:LeWordExamples>>#editInputEditorText|codeExpanded=false|previewExpanded=true}}
### Word Explanation
{{gtExample:LeWordExamples>>#searchAnotherWordExplanation|codeExpanded=false|previewExpanded=true}}

"
Class {
	#name : #LeWordSnippetElement,
	#superclass : #LeSnippetElement,
	#instVars : [
		'contentElement',
		'toolbarElement',
		'inputElement',
		'explanationElement',
		'acceptButton',
		'errorLabelElement',
		'editButton'
	],
	#category : #'Lepiter-Snippet-Words-UI Snippet Element'
}

{ #category : #'private - accessing' }
LeWordSnippetElement >> acceptButton [
	<return: #BrButton>
	^ acceptButton
]

{ #category : #'private - accessing' }
LeWordSnippetElement >> contentElement [
	^ contentElement
]

{ #category : #'private - accessing' }
LeWordSnippetElement >> editButton [
	<return: #BrButton>
	^ editButton
]

{ #category : #'private - accessing' }
LeWordSnippetElement >> errorLabelElement [
	<return: #BrLabel>
	^ errorLabelElement
]

{ #category : #'private - accessing' }
LeWordSnippetElement >> explanationElement [
	<return: #LeWordViewElement>
	^ explanationElement
]

{ #category : #initialization }
LeWordSnippetElement >> initialize [
	super initialize.
	self initializeContentElement.
	self initializeToolbarElement.
]

{ #category : #initialization }
LeWordSnippetElement >> initializeContentElement [
	contentElement := BrFrame new
		padding: (BlInsets bottom: 5);
		vFitContent;
		hMatchParent.
	
	inputElement := LeWordInputElement new.
	inputElement visibility: BlVisibility visible.
	inputElement
		whenEditor: BrTextEditorModifiedEvent
		do: [ :anEvent | self onWordInputModified: anEvent ];
		addEditorShortcut: (LeWordSearchExplanationShortcut new combination: (LeTextualSnippetElement keyboardShortcut: #NewLine); repeatable: false);
		addEditorShortcut: (LeWordSearchExplanationShortcut new combination: (LeTextualSnippetElement keyboardShortcut: #SecondaryNewLine); repeatable: false).

	LeSnippetEditorElementShortcuter new
		editor: inputElement;
		indent;
		moveUpAndDown;
		loseFocus.
	
	contentElement addChild: inputElement as: #editor.
	
	explanationElement := LeWordViewElement new.
	explanationElement visibility: BlVisibility gone.
	contentElement addChild: explanationElement as: #explanation.
	
	LeSnippetEditorElementShortcuter new
		editor: explanationElement;
		indent;
		moveUpAndDown;
		loseFocus.
]

{ #category : #initialization }
LeWordSnippetElement >> initializeToolbarElement [
	toolbarElement := BrToolbar new
		aptitude: BrGlamorousToolbarAptitude;
		hMatchParent;
		vFitContent.
		
	acceptButton := BrButton new
		beTinySize;
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons accept;
		label: 'Search definition';
		action: [ :aButton | self onAcceptAction: aButton ].
		
	toolbarElement addItem: acceptButton.
	
	editButton := BrButton new
		beTinySize;
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons edit;
		label: 'Change definition';
		visibility: BlVisibility gone;
		action: [ :aButton | self onEditAction: aButton ].
		
	toolbarElement addItem: editButton.
	
	errorLabelElement := BrLabel new
		id: LeWordErrorMessageElementId;
		aptitude: (BrGlamorousLabelAptitude new foreground: BrGlamorousColors errorBackgroundColor);
		text: '';
		vFitContentLimited;
		vFitContent.
		
	toolbarElement addItem: errorLabelElement
]

{ #category : #'private - accessing' }
LeWordSnippetElement >> inputElement [
	<return: #LeWordInputElement>
	^ inputElement
]

{ #category : #'private - event handling' }
LeWordSnippetElement >> onAcceptAction: aButton [
	self snippetViewModel searchExplanation.
]

{ #category : #'private - event handling' }
LeWordSnippetElement >> onEditAction: aButton [
	self snippetViewModel editStateFrom: nil.
]

{ #category : #'api - snippet view model' }
LeWordSnippetElement >> onSnippetViewModelChanged [ 
	super onSnippetViewModelChanged.
	self updateContentElement.
]

{ #category : #'api - snippet view model' }
LeWordSnippetElement >> onSnippetViewModelFocused: aBoolean [
	"Override me to either request or lose focus when the focused state is changed in the UI Model"

	"ignore for now"
]

{ #category : #'private - announcement handling' }
LeWordSnippetElement >> onViewModelWordChanged: anAnnouncement [
	anAnnouncement source == self ifTrue: [ ^ self ].
	self enqueueTask: (BlTaskAction new action: [
		self updateContentElement ])
]

{ #category : #'private - event handling' }
LeWordSnippetElement >> onWordInputModified: anEvent [
	self snippetViewModel word: anEvent text asString source: self
]

{ #category : #'private - updating' }
LeWordSnippetElement >> showExplanationElement [
	self explanationElement explanation: self snippetViewModel explanation.
	self inputElement visibility: BlVisibility gone.
	self explanationElement visibility: BlVisibility visible.
	self acceptButton visibility: BlVisibility gone.
	self errorLabelElement visibility: BlVisibility gone.
	self editButton visibility: BlVisibility visible.
]

{ #category : #'private - updating' }
LeWordSnippetElement >> showInputElement [
	self inputElement word: self snippetViewModel word.
	self errorLabelElement text: self snippetViewModel userMessage.
	
	self inputElement visibility: BlVisibility visible.
	self explanationElement visibility: BlVisibility gone.
	self acceptButton visibility: BlVisibility visible.
	self errorLabelElement visibility: BlVisibility visible.
	self editButton visibility: BlVisibility gone.
	self acceptButton enable.
	self inputElement enable.
]

{ #category : #'api - view' }
LeWordSnippetElement >> snippetContent [
	"Return an element that represents a content of the snippet.
	The embedder is responsible for placing #snippetContent in the right place within snippet element depending on the
	View Model properties and derived look"
	<return: #BlElement>

	^ self contentElement
]

{ #category : #'api - view' }
LeWordSnippetElement >> snippetToolbar [
	"Return an element that represents a toolbar of the snippet. A toolbar usually appears below the snippet content.
	The embedder is responsible for placing #snippetToolbar in the right place within snippet element depending on the
	View Model properties and derived look.
	If returned #snippetToolbar is nil, no toolbar will be added"
	<return: #BlElement or: nil>

	^ self toolbarElement
]

{ #category : #'api - snippet view model' }
LeWordSnippetElement >> subscribeToSnippetViewModel [
	super subscribeToSnippetViewModel.
	
	self snippetViewModel weak
		when: LeWordViewModelChangedAnnouncement
		send: #onViewModelWordChanged:
		to: self
]

{ #category : #'private - accessing' }
LeWordSnippetElement >> toolbarElement [
	<return: #BrToolbar>
	^ toolbarElement
]

{ #category : #'private - updating' }
LeWordSnippetElement >> updateContentElement [

	self snippetViewModel acceptStateVisitor: self.

	"self snippetViewModel
		ifSuccess: [ self showExplanationElement ]
		otherwise: [ self showInputElement ]"
]

{ #category : #visiting }
LeWordSnippetElement >> visitLeWordSnippetViewModelEditState: aState [
	self showInputElement.
]

{ #category : #visiting }
LeWordSnippetElement >> visitLeWordSnippetViewModelSearchState: aState [
	self showInputElement.
	self acceptButton disable.
	self inputElement disable.
	self errorLabelElement text: 'Searching...'
]

{ #category : #visiting }
LeWordSnippetElement >> visitLeWordSnippetViewModelViewState: aState [
	self showExplanationElement.
]
