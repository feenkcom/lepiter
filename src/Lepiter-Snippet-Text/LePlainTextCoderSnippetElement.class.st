Class {
	#name : #LePlainTextCoderSnippetElement,
	#superclass : #LeTextualSnippetElement,
	#instVars : [
		'editorElement'
	],
	#category : #'Lepiter-Snippet-Text-Snippet'
}

{ #category : #'api - snippet view model' }
LePlainTextCoderSnippetElement >> alignContentLeftBy: aNumber [
	editorElement padding: ((editorElement padding withLeft: aNumber) withRight: aNumber)
]

{ #category : #'private - accessing' }
LePlainTextCoderSnippetElement >> editor [
	<return: #BrTextEditorModel>
	^ self editorElement editor
]

{ #category : #'private - accessing' }
LePlainTextCoderSnippetElement >> editorElement [
	<return: #BrEditor>

	^ editorElement
]

{ #category : #initialization }
LePlainTextCoderSnippetElement >> initialize [
	super initialize.
	self initializeEditorElement
]

{ #category : #initialization }
LePlainTextCoderSnippetElement >> initializeEditorElement [
	editorElement := GtTextualCoderEditorElement new.
	editorElement aptitudeDo: [ :aLook | aLook glamorousRegularDefaultFont ].

	editorElement padding: (BlInsets top: 5 bottom: 5).
	editorElement margin: BlInsets empty.
	editorElement editor
		addEventHandler: (LeEditorReachedBorderEventHandler new snippetElement: self).

	editorElement editor ensureNoUndoRedoShortcuts
]

{ #category : #'private - event handling' }
LePlainTextCoderSnippetElement >> onLinkTargetChanged: aLeSnippetLinkTargetChanged [
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
LePlainTextCoderSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.

	self updateCoderViewModel
]

{ #category : #'private - editing' }
LePlainTextCoderSnippetElement >> renamePageIn: anEditorElement [
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
LePlainTextCoderSnippetElement >> snippetContent [
	"Return an element that represents a content of the snippet.
	The embedder is responsible for placing #snippetContent in the right place within snippet element depending on the
	View Model properties and derived look"
	<return: #BlElement>

	^ self editorElement
]

{ #category : #'api - view' }
LePlainTextCoderSnippetElement >> snippetToolbar [
	"Return an element that represents a toolbar of the snippet. A toolbar usually appears below the snippet content.
	The embedder is responsible for placing #snippetToolbar in the right place within snippet element depending on the
	View Model properties and derived look.
	If returned #snippetToolbar is nil, no toolbar will be added"
	<return: #BlElement or: nil>

	^ nil
]

{ #category : #'api - snippet view model' }
LePlainTextCoderSnippetElement >> subscribeToSnippetViewModel [
	super subscribeToSnippetViewModel.

	self snippet weak
		when: LeSnippetLinkTargetChanged
			send: #onLinkTargetChanged:
			to: self
]

{ #category : #'api - snippet view model' }
LePlainTextCoderSnippetElement >> unsubscribeFromSnippetViewModel [
	super unsubscribeFromSnippetViewModel.

	self snippet unsubscribe: self
]

{ #category : #'private - updating' }
LePlainTextCoderSnippetElement >> updateCoderViewModel [
	editorElement textualCoderViewModel: self snippetViewModel coderViewModel
]
