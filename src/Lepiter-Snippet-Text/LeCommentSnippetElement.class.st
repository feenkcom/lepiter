"
I am a view for a {{gtClass:name=LeCommentSnippet}}.
I am like my parent, except that I am usually hidden, and when I am displayed, my background is yellow.
"
Class {
	#name : #LeCommentSnippetElement,
	#superclass : #LePlainTextCoderSnippetElement,
	#instVars : [
		'contentElement',
		'iconElement',
		'toolbarElement',
		'hideButton',
		'saveAptitude'
	],
	#category : #'Lepiter-Snippet-Text-Snippet'
}

{ #category : #icons }
LeCommentSnippetElement class >> noteIcon [
	"Thanks to https://icons8.com/icon/pEzgX8KLqEy5/note"
	<gtExample>
	^ Form
		extent: 24 @ 24
		depth: 32
		fromArray: (self noteIconArray
			collect: [ :c | 
				c isZero
				ifTrue: [ Color paleYellow pixelValueForDepth: 32 ]
				ifFalse: [ c ] ])
		offset: 0 @ 0
]

{ #category : #icons }
LeCommentSnippetElement class >> noteIconArray [
	^ #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3976200192 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 3959422976 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 4278190080 0 0 0 3556769792 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 3556769792 0 0 0 4278190080 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 4278190080 0 0 0 3556769792 4278190080 4278190080 4278190080 4278190080 3556769792 0 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 0 0 0 0 0 3976200192 4278190080 4278190080 4278190080 4278190080 4043309056 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 0 0 0 0 0 4278190080 0 0 1006632960 3909091328 1107296256 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 0 0 0 0 0 4278190080 0 1006632960 3909091328 1107296256 0 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 0 0 0 0 0 4278190080 1006632960 3909091328 1107296256 0 0 0 0 0 0 0 0 4278190080 0 0 0 0 0 0 0 0 0 0 0 4278190080 3925868544 1073741824 0 0 0 0 0 0 0 0 0 3959422976 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4043309056 1073741824 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
]

{ #category : #'api - snippet view model' }
LeCommentSnippetElement >> alignContentLeftBy: aNumber [
	"All snippets should be nicely aligned to the left. However, only snippets themselves know their content and layout structure.
	Override me to align the content by aNumber of points to the left. Usually it should just involve setting a corresponding padding or margin"
]

{ #category : #accessing }
LeCommentSnippetElement >> contentElement [
	^ contentElement
]

{ #category : #accessing }
LeCommentSnippetElement >> contentElement: anObject [
	contentElement := anObject
]

{ #category : #accessing }
LeCommentSnippetElement >> hideButton [
	^ hideButton
]

{ #category : #'event handling' }
LeCommentSnippetElement >> hideComment [
	"Hide the comment element and show the iconized element instead."

	self snippetContainerDo: #hFitContent.
	self editorElement visibility: BlVisibility gone.
	self hideButton visibility: BlVisibility gone.
	self iconElement visibility: BlVisibility visible.
	self
		snippetAptitudeDo: [ :a | 
			a shouldShowSidebar: false.
			a shouldShowBottomToolbar: false ]
]

{ #category : #accessing }
LeCommentSnippetElement >> iconElement [
	^ iconElement
]

{ #category : #accessing }
LeCommentSnippetElement >> iconElement: anObject [
	iconElement := anObject
]

{ #category : #initalization }
LeCommentSnippetElement >> initialize [
	super initialize.
	self initializeIconElement.
	self initializeContentElement.
	self initializeToolbarElement
]

{ #category : #initalization }
LeCommentSnippetElement >> initializeContentElement [
	"The contentElement holds both the editorElement and the iconElement, only ione of which is visible at a time, depending on the state of the snippet."
	contentElement := BrFrame new
			padding: (BlInsets bottom: 5);
			vFitContent;
			hMatchParent.
	contentElement addChild: self editorElement as: #editor.
	iconElement visibility: BlVisibility gone.
	contentElement addChild: self iconElement as: #noteIcon.
]

{ #category : #initalization }
LeCommentSnippetElement >> initializeEditorElement [
	super initializeEditorElement.
	editorElement background: Color paleYellow.
	editorElement padding: (BlInsets all: 5)
]

{ #category : #initalization }
LeCommentSnippetElement >> initializeIconElement [
	iconElement := BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude;
			icon: self class noteIcon;
			label: 'Show comment';
			action: [ :aButton | self onShowAction: aButton ]
]

{ #category : #initalization }
LeCommentSnippetElement >> initializeToolbarElement [
	"We only need a hide button, because the icon in the hidden state itself is a show button."
	toolbarElement := BrToolbar new
		aptitude: BrGlamorousToolbarAptitude;
		hMatchParent;
		vFitContent.
		
	hideButton := BrButton new
		beTinySize;
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons accept;
		label: 'Hide comment';
		action: [ :aButton | self onHideAction: aButton ].
		
	toolbarElement addItem: hideButton.
	
]

{ #category : #'event handling' }
LeCommentSnippetElement >> onHideAction: aButton [
	"Update the model. Eventually this will trigger hideComment"

	self snippet hide
]

{ #category : #'event handling' }
LeCommentSnippetElement >> onShowAction: aButton [
	"Update the model. Eventually this will trigger showComment"

	self snippet show
]

{ #category : #'event handling' }
LeCommentSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.

	self snippetViewModel isHidden
		ifTrue: [ self hideComment ]
		ifFalse: [ self showComment ]
]

{ #category : #'event handling' }
LeCommentSnippetElement >> showComment [
	"Hide the icon element and show the comment element instead."

	self snippetContainerDo: #hMatchParent.
	self editorElement visibility: BlVisibility visible.
	self hideButton visibility: BlVisibility visible.
	self iconElement visibility: BlVisibility gone.
	self
		snippetAptitudeDo: [ :a | 
			a shouldShowSidebar: true.
			a shouldShowBottomToolbar: true ]
]

{ #category : #'event handling' }
LeCommentSnippetElement >> snippetAptitudeDo: aBlock [
	(self aptitude isKindOf: LeSnippetAptitude)
		ifTrue: [ aBlock value: self aptitude ]
]

{ #category : #'event handling' }
LeCommentSnippetElement >> snippetContainerDo: aBlockWithArgument [
	self
		allParentsDetect: [ :each | each isKindOf: LeSnippetContainerElement ]
		ifFound: [ :each | aBlockWithArgument value: each ]
		ifNone: [ nil ]
]

{ #category : #'api - view' }
LeCommentSnippetElement >> snippetContent [
	<return: #BlElement>

	^ self contentElement
]

{ #category : #'api - view' }
LeCommentSnippetElement >> snippetToolbar [
	<return: #BlElement or: nil>

	^ self toolbarElement
]

{ #category : #'event handling' }
LeCommentSnippetElement >> subscribeToSnippetViewModel [
	"Actually, here we directly subscribe to the view."

	super subscribeToSnippetViewModel.

	self snippet weak
		when: LeCommentSnippetVisibilityChanged
		send: #onSnippetViewModelChanged
		to: self
]

{ #category : #accessing }
LeCommentSnippetElement >> toolbarElement [
	^ toolbarElement
]

{ #category : #accessing }
LeCommentSnippetElement >> toolbarElement: anObject [
	toolbarElement := anObject
]
