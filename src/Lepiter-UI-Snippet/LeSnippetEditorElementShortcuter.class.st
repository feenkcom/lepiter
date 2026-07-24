"
I define text editor common shortcuts.
I am used during {{gtClass:BrEditor}} initialization.

"
Class {
	#name : #LeSnippetEditorElementShortcuter,
	#superclass : #Object,
	#instVars : [
		'editor'
	],
	#category : #'Lepiter-UI-Snippet-Shortcuts'
}

{ #category : #'gt-extensions' }
LeSnippetEditorElementShortcuter class >> gtKeyboardShortcutsFor: aView [
	<gtClassView>
	^ aView forward
		title: 'Keyboard shortcuts';
		priority: 45;
		object: [ LeSnippetElement ];
		view: #gtKeyboardShortcutsFor:
]

{ #category : #'api - initialization' }
LeSnippetEditorElementShortcuter >> editor [
	^ editor
]

{ #category : #'api - initialization' }
LeSnippetEditorElementShortcuter >> editor: anObject [
	editor := anObject
]

{ #category : #shortcuts }
LeSnippetEditorElementShortcuter >> indent [
	self editor
		"Indent LeSnippet"
		addEditorShortcut: LeSnippetIndentSnippetShortcut new;
		"Unindent LeSnippet"
		addEditorShortcut: LeSnippetUnindentSnippetShortcut new.
]

{ #category : #private }
LeSnippetEditorElementShortcuter >> keyboardShortcut: aSymbol [
	"Answer the named keyboard shortcut"
	
	^ LeSnippetElement keyboardShortcut: aSymbol
]

{ #category : #shortcuts }
LeSnippetEditorElementShortcuter >> loseFocus [
	self editor
		"Lose focus LeBlock"
		addEditorShortcut: BrEditorShortcut loseFocus
]

{ #category : #shortcuts }
LeSnippetEditorElementShortcuter >> moveUpAndDown [
	self editor
		"Move block up"
		addEditorShortcut: LeSnippetMoveSnippetUpShortcut new;
		"Move block down"
		addEditorShortcut: LeSnippetMoveSnippetDownShortcut new
]
