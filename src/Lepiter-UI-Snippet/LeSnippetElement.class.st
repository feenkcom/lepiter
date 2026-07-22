Class {
	#name : #LeSnippetElement,
	#superclass : #BlElement,
	#traits : 'TLeWithSnippetViewModel + TBrLayoutResizable',
	#classTraits : 'TLeWithSnippetViewModel classTrait + TBrLayoutResizable classTrait',
	#classVars : [
		'KeyboardShortcuts'
	],
	#category : #'Lepiter-UI-Snippet-! Views'
}

{ #category : #'gt-extensions' }
LeSnippetElement class >> gtKeyboardShortcutsFor: aView [
	<gtClassView>
	KeyboardShortcuts ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Keyboard shortcuts';
		priority: 45;
		object: [ self keyboardShortcuts ];
		view: #gtItemsFor:
]

{ #category : #'class initialization' }
LeSnippetElement class >> initialize [

	SessionManager default
		registerUserClassNamed: self name.
	self initializeKeyboardShortcuts.
]

{ #category : #'class initialization' }
LeSnippetElement class >> initializeKeyboardShortcuts [
	"Initialise the keyboard shortcuts used by subclasses"
	<script>

	KeyboardShortcuts := IdentityDictionary new.

	KeyboardShortcuts
		at: #NewLine
			put: BlKeyCombination return;
		
		at: #SecondaryNewLine
			put: 	BlKeyCombination builder secondary return build;

		at: #LoseFocus
			put: BlKeyCombination escape;

		at: #SplitSnippet
			put: BlKeyCombination builder primary return build;

		at: #DeletePrevious
			put: BlKeyCombination builder backspace build;

		at: #DeleteNext
			put: BlKeyCombinationBuilder new delete build;

		at: #IndentSnippet
			put: (BlKeyCombinationBuilder new 
						primary key: BlKeyboardKey rightBracket) build;

		at: #UnindentSnippet
			put: (BlKeyCombinationBuilder new 
						primary key: BlKeyboardKey leftBracket) build;

		at: #MoveSnippetUp
			put: BlKeyCombinationBuilder new alt shift arrowUp build;

		at: #MoveSnippetDown
			put: BlKeyCombinationBuilder new alt shift arrowDown build;

		at: #RenameSnippet
			put: BlKeyCombinationBuilder new primary r build.
]

{ #category : #accessing }
LeSnippetElement class >> keyboardShortcut: aSymbol [
	"Answer the named keyboard shortcut"

	^ KeyboardShortcuts at: aSymbol
]

{ #category : #accessing }
LeSnippetElement class >> keyboardShortcuts [
	"Answer all keyboard shortcuts used by subclasses"

	^ KeyboardShortcuts

]

{ #category : #'class initialization' }
LeSnippetElement class >> startUp: resuming [
	"Let's not to initialize the keyboard shortcuts on every startup.
	https://github.com/feenkcom/gtoolkit/issues/3086"

	resuming ifTrue: [ "self initializeKeyboardShortcuts" ]
]

{ #category : #'api - snippet view model' }
LeSnippetElement >> alignContentLeftBy: aNumber [
	"All snippets should be nicely aligned to the left. However, only snippets themselves know their content and layout structure.
	Override me to align the content by aNumber of points to the left. Usually it should just involve setting a corresponding padding or margin"
]

{ #category : #private }
LeSnippetElement >> assertUIProcess [
	"Make sure that I am executing in a UI process"
	| aCurrentProcess aUIProcess |
	
	self isAttachedToSceneGraph
		ifFalse: [ ^ self ].
		
	self space isOpened
		ifFalse: [ ^ self ].

	aCurrentProcess := Processor activeProcess.	

	aUIProcess := nil.
	self space host uiProcessDo: [ :aProcess | aUIProcess := aProcess ].

	aUIProcess
		ifNil: [ ^ self ].
		
	(aUIProcess == aCurrentProcess)
		ifFalse: [ self error: ('I am running from a non-UI process ({1}) expected ({2})' format: { aCurrentProcess asString . aUIProcess asString }) ]
]

{ #category : #'api - accessing' }
LeSnippetElement >> database [
	<return: #LeDatabase>

	snippetViewModel ifNil: [ ^ LeNullDatabase new ].
	^ self snippet database
]

{ #category : #initialization }
LeSnippetElement >> initialize [ 
	super initialize.
	
	self layout: BlLinearLayout vertical.
	
	self hMatchParent.
	self vFitContent.
	self beFocusable.

	self registerFocusEventHandlers.

	self
		when: BlClickEvent
		do: [ :anEvent | 
			anEvent consumed: true.
			self snippetViewModel focused: true ]
]

{ #category : #'private - focus' }
LeSnippetElement >> onFocusChangedAnnouncement: anAnnouncement [
	self assertUIProcess.
	
	anAnnouncement source == self
		ifTrue: [ ^ self ].

	anAnnouncement source == self snippetViewModel
		ifFalse: [ ^ self ].

	self onSnippetViewModelFocused: anAnnouncement focused
]

{ #category : #'api - snippet view model' }
LeSnippetElement >> onSnippetViewModelChanged [
	"Is sent when a new Snippet view model is assigned to the element"
	
	self onSnippetViewModelFocused: self snippetViewModel focused
]

{ #category : #'api - snippet view model' }
LeSnippetElement >> onSnippetViewModelFocused: aBoolean [
	"Override me to either request or lose focus when the focused state is changed in the UI Model"
]

{ #category : #'api - accessing' }
LeSnippetElement >> page [
	"Answer the page that the receiver is part of"

	^ self snippet page
]

{ #category : #'private - focus' }
LeSnippetElement >> registerFocusEventHandlers [
	"Register event handlers to update the focused state of the Block UI Model"

	"Re-focusing infinite loop breaker warning!
	When multiple snippet elements are created for the same snippet view model there is a danger of an infinite re-focusing loop. The UI framework guarantees that there us only one UI element focused at the time, which may lead to the situation when two snippet elements are competing for the focus.
	Passing the source of the focus allows snippet elements to ignore focus changes that do not come from the view model, hence breaking the cycle.
	Relevant issue: https://github.com/feenkcom/gtoolkit/issues/1944"
	self when: BlFocusInEvent do: [ :anEvent |
		self snippetViewModel focused: true from: self ].
	self when: BlFocusOutEvent do: [ :anEvent |
		"when elements are removed from the scene graph due to tab switching or scrolling they lose focus.
		We are only interested when focus is lost explicitly via user interaction"
		anEvent isDueToRemoval
			ifFalse: [ self snippetViewModel focused: false from: self ] ]
]

{ #category : #'api - accessing' }
LeSnippetElement >> snippet [
	<return: #LeTextSnippet>
	^ self snippetViewModel snippetModel
]

{ #category : #'api - view' }
LeSnippetElement >> snippetContent [
	"Return an element that represents a content of the snippet.
	The embedder is responsible for placing #snippetContent in the right place within snippet element depending on the
	View Model properties and derived look"
	<return: #BlElement>

	^ self subclassResponsibility
]

{ #category : #'api - view' }
LeSnippetElement >> snippetToolbar [
	"Return an element that represents a toolbar of the snippet. A toolbar usually appears below the snippet content.
	The embedder is responsible for placing #snippetToolbar in the right place within snippet element depending on the
	View Model properties and derived look.
	If returned #snippetToolbar is nil, no toolbar will be added"
	<return: #BlElement or: nil>

	^ self subclassResponsibility
]

{ #category : #'api - snippet view model' }
LeSnippetElement >> subscribeToSnippetViewModel [
	"Is sent after a new Snippet view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromSnippetViewModel if elements subscribe to them"
	
	self snippetViewModel weak
		when: LeSnippetFocusChanged
		send: #onFocusChangedAnnouncement:
		to: self
]

{ #category : #'api - accessing' }
LeSnippetElement >> text [
	<return: #BlText>

	^ self snippet text
]

{ #category : #'api - accessing' }
LeSnippetElement >> textCopy [
	<return: #BlText>

	^ self text copy
]

{ #category : #'api - snippet view model' }
LeSnippetElement >> unsubscribeFromSnippetViewModel [
	"Is sent before a new Snippet view model is assigned to the element.
	Elements that subscribe to Snippet view model in domain model are required to implement this methods"
	
	self snippetViewModel unsubscribe: self
]
