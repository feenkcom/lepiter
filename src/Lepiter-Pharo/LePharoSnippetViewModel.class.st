Class {
	#name : #LePharoSnippetViewModel,
	#superclass : #LeCodeSnippetViewModel,
	#category : #'Lepiter-Pharo-Snippet'
}

{ #category : #'gt extensions' }
LePharoSnippetViewModel >> gtActionCreateExampleFor: anAction [

	<gtAction>
	^ anAction button
		  tooltip: 'Create example';
		  icon: BrGlamorousVectorIcons eg;
		  target: LeSnippetContextMenuActionTarget uniqueInstance;
		  priority: 10;
		  action: [ :aButton :aSnippetElement | 
			  | index |
			  index := aButton parent childIndexOf: aButton.
			  (index < aButton parent childrenCount and: [ 
					   (aButton parent childAt: index + 1) isKindOf:
							   LePharoCreateExampleElement ])
				  ifTrue: [ (aButton parent childAt: index + 1) removeFromParent ]
				  ifFalse: [ 
					  aButton parent addChild: (LePharoCreateExampleElement new
								   snippet: snippetModel;
								   constraintsDo: [ :c | c grid horizontal span: 2 ]) ] ]
]

{ #category : #'gt extensions' }
LePharoSnippetViewModel >> gtBindingsFor: aView [
	<gtView>
	^ aView forward
		title: 'Bindings';
		priority: 5;
		object: [ self coderViewModel ];
		view: #gtBindingsFor:
]

{ #category : #initialization }
LePharoSnippetViewModel >> initializeCoderAddOns: aCoderViewModel [
	"Initialise the keyboard shortcuts in the code editor"
	
	aCoderViewModel localBindings
		localAt: #thisSnippetViewModel
		put: self.

	aCoderViewModel localBindings
		localAt: #thisSnippet
		put: self snippetModel.

	aCoderViewModel
		"Create New snippet (after the current snippet)"
		addShortcut: (LeSnippetSplitSnippetShortcut new combination: (self keyboardShortcut: #SplitSnippet));
		"Delete previous character, or merge with previous snippet"	
		addShortcut: (LeSnippetDeletePreviousShortcut new combination: (self keyboardShortcut: #DeletePrevious));
		"Indent LeSnippet"
		addShortcut: (LeSnippetIndentSnippetShortcut new combination: (self keyboardShortcut: #IndentSnippet));
		"Unindent LeSnippet"
		addShortcut: (LeSnippetUnindentSnippetShortcut new combination: (self keyboardShortcut: #UnindentSnippet));
		"Move Snippet up"
		addShortcut: (LeSnippetMoveSnippetUpShortcut new combination: (self keyboardShortcut: #MoveSnippetUp));
		"Move Snippet down"
		addShortcut: (LeSnippetMoveSnippetDownShortcut new combination: (self keyboardShortcut: #MoveSnippetDown))
]

{ #category : #'api - bindings' }
LePharoSnippetViewModel >> onSelfObjectChanged [
	coderViewModel selfObject: sharedContext selfObject
]

{ #category : #accessing }
LePharoSnippetViewModel >> onSnippetModelChanged [
	super onSnippetModelChanged.
	self updateHighlighter
]

{ #category : #'filter view' }
LePharoSnippetViewModel >> parserClass [
	^ GtPharoParser
]

{ #category : #'api - bindings' }
LePharoSnippetViewModel >> sharedSnippetContext: aLeSharedSnippetContext [
	sharedContext unsubscribe: self.
	
	super sharedSnippetContext: aLeSharedSnippetContext.
	coderViewModel
		sharedBindings: aLeSharedSnippetContext sharedBindings;
		selfObjectHolder: aLeSharedSnippetContext selfObjectHolder;
		variableValueToggleModel: aLeSharedSnippetContext variablePreviewToggle;
		context: aLeSharedSnippetContext pharoRuntimeContext.
	
	aLeSharedSnippetContext whenSelfObjectChangedSend: #onSelfObjectChanged to: self
]

{ #category : #accessing }
LePharoSnippetViewModel >> snippetElementClass [
	^ LePharoSnippetElement
]
