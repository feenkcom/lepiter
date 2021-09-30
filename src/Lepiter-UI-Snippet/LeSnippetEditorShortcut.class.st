Class {
	#name : #LeSnippetEditorShortcut,
	#superclass : #BrEditorShortcut,
	#category : 'Lepiter-UI-Snippet-Shortcuts'
}

{ #category : #'gt-extensions' }
LeSnippetEditorShortcut >> gtSourceCodeFor: aView [ 
	<gtView>

	^ aView forward
		title: 'Source';
		object: [ self class >> #performOnEditor:snippet:dueTo: ];
		view: #gtSourceFor:
]

{ #category : #evaluation }
LeSnippetEditorShortcut >> performOnEditor: aBrTextEditor block: aLeSnippetElement dueTo: aShortcutEvent [
	self deprecated: 'use #performOnEditor:snippet:dueTo: instead.'.
	self performOnEditor: aBrTextEditor snippet: aLeSnippetElement dueTo: aShortcutEvent.
]

{ #category : #evaluation }
LeSnippetEditorShortcut >> performOnEditor: aBrTextEditor element: aBrEditorElement dueTo: aShortcutEvent [
	aBrEditorElement
		withAllParentsDetect: [ :eachParent | eachParent isKindOf: LeSnippetElement ]
		ifFound: [ :aSnippetElement | 
			self
				performOnEditor: aBrTextEditor
				snippet: aSnippetElement
				dueTo: aShortcutEvent ]
		ifNone: [  ]
]

{ #category : #evaluation }
LeSnippetEditorShortcut >> performOnEditor: aBrTextEditor snippet: aLeSnippetElement dueTo: aShortcutEvent [
	self subclassResponsibility
]
