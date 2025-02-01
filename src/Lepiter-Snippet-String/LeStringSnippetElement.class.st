Class {
	#name : #LeStringSnippetElement,
	#superclass : #LeEvaluatedSnippetElement,
	#instVars : [
		'contentElement',
		'bindingEditor',
		'indicatorElement',
		'indicatorStencil'
	],
	#category : #'Lepiter-Snippet-String'
}

{ #category : #'private - accessing' }
LeStringSnippetElement >> editorElement [
	"Answer the BrEditor used by the receiver"

	^ editorElement
]

{ #category : #initialization }
LeStringSnippetElement >> go [
	| string bindingName sharedBindings binding |
	string := editorElement text asString.
	self snippetViewModel contentString: string.
	bindingName := bindingEditor text asString.
	self snippetViewModel bindingName: bindingName.
	sharedBindings := self snippetViewModel snippetBindings.
	binding := sharedBindings bindingOf: bindingName asSymbol.
	binding value: string.
	^ string
]

{ #category : #initialization }
LeStringSnippetElement >> initialize [
	super initialize.
	self initializeEditorElement.
	self initializeIndicatorElement.
	self initializeContentElement.
	self initializeCoderToolbarElement
]

{ #category : #initialization }
LeStringSnippetElement >> initializeCoderToolbarElement [
	| playButton playInspectButton |
	coderToolbar := GtSourceCoderActionsElement new.
	playButton := BrButton new
			beTinySize;
			margin: (BlInsets left: 0 right: 3);
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousVectorIcons play;
			label: 'Set string';
			action: [ :aButton | self go ];
			constraintsDo: [ :c | c linear vertical alignCenter ].
	coderToolbar addChild: playButton.
	playInspectButton := BrButton new
			beTinySize;
			margin: (BlInsets left: 0 right: 3);
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousVectorIcons playinspect;
			label: 'Set string and inspect';
			action: [ :aButton | aButton phlow spawnObject: self go ];
			constraintsDo: [ :c | c linear vertical alignCenter ].
	coderToolbar addChild: playInspectButton.
	coderToolbar
		addChild: (BrLabel new
				beTinySize;
				margin: (BlInsets left: 0 right: 1);
				text: 'Binding:' asRopedText;
				constraintsDo: [ :c | c linear vertical alignCenter ];
				aptitude: BrGlamorousLabelAptitude new).
	bindingEditor := BrEditor new
			vFitContent;
			hFitContentLimited;
			constraintsDo: [ :c | 
				c linear vertical alignCenter.
				c minWidth: 100 ];
			aptitude: BrGlamorousEditableLabelAptitude new glamorousCodeTinySize;
			addAptitude: BrGlamorousCodeEditorAptitude new.
	bindingEditor editor text: '' asRopedText.
	coderToolbar addChild: bindingEditor
]

{ #category : #initialization }
LeStringSnippetElement >> initializeContentElement [
	contentElement := BrFrame new
			hMatchParent;
			vFitContent;
			addChildren: {editorElement.
					indicatorElement}
]

{ #category : #initialization }
LeStringSnippetElement >> initializeEditorElement [
	editorElement := GtSourceCoderEditorElement new
			hMatchParent;
			vFitContentLimited;
			padding: (BlInsets
					top: 5
					left: 7
					bottom: 5
					right: 0);
			margin: BlInsets empty.
	editorElement editor
		addEventHandler: (LeEditorReachedBorderEventHandler new snippetElement: self);
		ensureNoUndoRedoShortcuts.

	true
		ifFalse: [ editorElement aptitudeDo: [ :aLook | aLook glamorousRegularDefaultFont ] ]
]

{ #category : #initialization }
LeStringSnippetElement >> initializeIndicatorElement [
	indicatorStencil := GtSpotterDropdownButtonStencil new
			icon: nil;
			label: 'String';
			tooltip: 'Set string parser';
			aptitude: [ BrGlamorousButtonWithLabelAptitude - BrGlamorousButtonExteriorAptitude ];
			beSmallSize;
			hidePreview;
			extent: 300@400;
			receiver: LeStringSpotterStart selector: #new;
			objectActOn: [ :anActOnEvent :aParserClass :aButton | self onParserSelected: aParserClass actOnEvent: anActOnEvent ].

	indicatorElement := indicatorStencil asElement.

	indicatorElement
		background: Color white;
		margin: (BlInsets top: 5 right: 5);
		constraintsDo: [ :c | 
			c frame horizontal alignRight.
			c frame vertical alignTop ]
]

{ #category : #'private - event handling' }
LeStringSnippetElement >> onParserSelected: aParserClass actOnEvent: anActOnEvent [
	self hasSnippetViewModel ifFalse: [ ^ self ].
	self snippetViewModel selectParserClass: aParserClass.
	anActOnEvent actedUpon: true.
]

{ #category : #'api - snippet view model' }
LeStringSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.
	self updateElement
]

{ #category : #'private - announcement handling' }
LeStringSnippetElement >> onStringFormatChanged: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self updateIndicatorElement.
			self updateEditorElement ]
]

{ #category : #accessing }
LeStringSnippetElement >> snippetContent [
	^ contentElement
]

{ #category : #'api - snippet view model' }
LeStringSnippetElement >> subscribeToSnippetViewModel [
	super subscribeToSnippetViewModel.

	self snippetViewModel announcer weak
		when: LeStringFormatChanged
		send: #onStringFormatChanged:
		to: self
]

{ #category : #'api - snippet view model' }
LeStringSnippetElement >> unsubscribeFromSnippetViewModel [
	super unsubscribeFromSnippetViewModel.

	self snippetViewModel announcer unsubscribe: self
]

{ #category : #'private - updating' }
LeStringSnippetElement >> updateBindingElement [
	bindingEditor
		text: (self snippetViewModel bindingName ifNil: [ String new ]) asRopedText
]

{ #category : #'private - updating' }
LeStringSnippetElement >> updateEditorElement [
	| aParserClass |
	editorElement
		text: (self snippetViewModel contentString ifNil: [ String empty ]) asRopedText.

	aParserClass := self snippetViewModel parser.
	(aParserClass isNotNil and: [ aParserClass gtStyler isNotNil ])
		ifTrue: [ editorElement styler: aParserClass gtStyler ]
]

{ #category : #'private - updating' }
LeStringSnippetElement >> updateElement [
	self updateEditorElement.
	self updateBindingElement.
	self updateIndicatorElement.
]

{ #category : #'private - updating' }
LeStringSnippetElement >> updateIndicatorElement [
	| aParserClass aParserName anIndicatorLabel |
	aParserClass := self snippetViewModel parser.
	aParserName := LeStringParserNameBuilder new
			parserClass: aParserClass;
			build.
	anIndicatorLabel := aParserName
			ifNil: [ 'String' ]
			ifNotNil: [ 'String ({1})' format: {aParserName} ].
	indicatorElement label: anIndicatorLabel.
	indicatorStencil label: anIndicatorLabel
]
