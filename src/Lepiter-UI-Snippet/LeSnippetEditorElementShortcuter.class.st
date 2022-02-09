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

{ #category : #'api - shortcuts' }
LeSnippetEditorElementShortcuter >> indent [
	self editor
		"Indent LeSnippet"
		addEditorShortcut: (LeSnippetIndentSnippetShortcut new combination: (self keyboardShortcut: #IndentSnippet));
		"Unindent LeSnippet"
		addEditorShortcut: (LeSnippetUnindentSnippetShortcut new combination: (self keyboardShortcut: #UnindentSnippet)).
]

{ #category : #private }
LeSnippetEditorElementShortcuter >> keyboardShortcut: aSymbol [
	"Answer the named keyboard shortcut"
	
	^ LeSnippetElement keyboardShortcut: aSymbol
]

{ #category : #'api - shortcuts' }
LeSnippetEditorElementShortcuter >> loseFocus [
	self editor
		"Lose focus LeBlock"
		addEditorShortcut: (BrEditorShortcut loseFocus combination: (self keyboardShortcut: #LoseFocus))
		
]

{ #category : #'api - shortcuts' }
LeSnippetEditorElementShortcuter >> moveUpAndDown [
	self editor
		"Move block up"
		addEditorShortcut: (LeSnippetMoveSnippetUpShortcut new combination: (self keyboardShortcut: #MoveSnippetUp));
		"Move block down"
		addEditorShortcut: (LeSnippetMoveSnippetDownShortcut new combination: (self keyboardShortcut: #MoveSnippetDown))
]
