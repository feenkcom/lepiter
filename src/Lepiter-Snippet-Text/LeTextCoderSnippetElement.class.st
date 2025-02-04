Class {
	#name : #LeTextCoderSnippetElement,
	#superclass : #LeTextualSnippetElement,
	#instVars : [
		'editorElement'
	],
	#category : #'Lepiter-Snippet-Text-Snippet'
}

{ #category : #'api - snippet view model' }
LeTextCoderSnippetElement >> alignContentLeftBy: aNumber [
	editorElement padding: ((editorElement padding withLeft: aNumber) withRight: aNumber)
]

{ #category : #'private - accessing' }
LeTextCoderSnippetElement >> editor [
	<return: #BrTextEditorModel>
	^ self editorElement editor
]

{ #category : #'private - accessing' }
LeTextCoderSnippetElement >> editorElement [
	<return: #BrEditor>

	^ editorElement
]

{ #category : #initialization }
LeTextCoderSnippetElement >> initialize [
	super initialize.
	self initializeEditorElement
]

{ #category : #initialization }
LeTextCoderSnippetElement >> initializeEditorElement [
	editorElement := GtTextualCoderEditorElement new.
	editorElement aptitudeDo: [ :aLook | aLook glamorousRegularDefaultFont ].

	editorElement padding: (BlInsets top: 5 bottom: 5).
	editorElement margin: BlInsets empty.
	editorElement editor
		addEventHandler: (LeEditorReachedBorderEventHandler new snippetElement: self).

	editorElement editor ensureNoUndoRedoShortcuts
]

{ #category : #'private - elements' }
LeTextCoderSnippetElement >> newMarkupToggle [
	| newToggle |
	newToggle := BrToggle new
		beNormalSize;
		label: 'Show/Hide Markups';
		vExact: 20;
		padding: (BlInsets left: 5 right: 5);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	newToggle
		aptitude:
			BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude
				- BrGlamorousButtonRectangularAptitude + BrGlamorousButtonLayoutAptitude
				+ BrGlamorousToggleBackgroundAptitude.
	newToggle icon: BrGlamorousVectorIcons edit.
	^ newToggle
]

{ #category : #'private - event handling' }
LeTextCoderSnippetElement >> onLinkTargetChanged: aLeSnippetLinkTargetChanged [
	self hasSnippetViewModel
		ifFalse: [ ^ self ].
	aLeSnippetLinkTargetChanged snippet = self snippet
		ifFalse: [ ^ self ].
	self editorElement
		enqueueTask:
			(BlTaskAction new
				action: [ aLeSnippetLinkTargetChanged snippet = self snippet
						ifTrue: [ self editorElement editor styleText ] ])
]

{ #category : #'api - snippet view model' }
LeTextCoderSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.

	self updateCoderViewModel
]

{ #category : #'private - editing' }
LeTextCoderSnippetElement >> renamePageIn: anEditorElement [
	| position link interval renameAction |
	anEditorElement editor cursors isEmpty
		ifTrue: [ ^ self ].
	position := anEditorElement editor cursors first position.
	link := self snippet outgoingTextualLinks
		detect: [ :each | 
			each isTextualPageLink
				and: [ each target notNil
						and: [ position
								between: each node startPosition
								and: each node stopPosition ] ] ]
		ifNone: [ ^ self ].
	interval := link linkNameInterval.
	renameAction := LeRenameAction
		locations: {interval}
		element: anEditorElement.
	renameAction
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			(#(#accept) includes: ann eventType)
				ifTrue: [ link target renameTo: renameAction newName ] ].
	renameAction install
]

{ #category : #'api - view' }
LeTextCoderSnippetElement >> snippetContent [
	"Return an element that represents a content of the snippet.
	The embedder is responsible for placing #snippetContent in the right place within snippet element depending on the
	View Model properties and derived look"
	<return: #BlElement>

	^ self editorElement
]

{ #category : #'api - view' }
LeTextCoderSnippetElement >> snippetToolbar [
	"Return an element that represents a toolbar of the snippet. A toolbar usually appears below the snippet content.
	The embedder is responsible for placing #snippetToolbar in the right place within snippet element depending on the
	View Model properties and derived look.
	If returned #snippetToolbar is nil, no toolbar will be added"
	<return: #BlElement or: nil>

	^ nil
]

{ #category : #'api - snippet view model' }
LeTextCoderSnippetElement >> subscribeToSnippetViewModel [
	super subscribeToSnippetViewModel.

	self snippet weak
		when: LeSnippetLinkTargetChanged
			send: #onLinkTargetChanged:
			to: self
]

{ #category : #'api - snippet view model' }
LeTextCoderSnippetElement >> unsubscribeFromSnippetViewModel [
	super unsubscribeFromSnippetViewModel.

	self snippet unsubscribe: self
]

{ #category : #'private - updating' }
LeTextCoderSnippetElement >> updateCoderViewModel [
	editorElement textualCoderViewModel: self snippetViewModel coderViewModel
]
