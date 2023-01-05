"
# Explicit snippet view model

"
Class {
	#name : #LeSnippetViewModel,
	#superclass : #LeAbstractSnippetViewModel,
	#category : #'Lepiter-UI-Snippet-! View Models'
}

{ #category : #'actions - utils' }
LeSnippetViewModel >> addChildOrSiblingSnippet: aNewSnippet [
	| insertCommand|
	insertCommand := self snippetModel 
		insertAsFirstChildCommandFor: aNewSnippet.
		
	^ insertCommand execute insertedSnippet.
]

{ #category : #'gt - extensions' }
LeSnippetViewModel >> gtActionIndentFor: anAction [
	<gtAction>

	^ anAction button
		tooltip: 'Indent snippet';
		icon: BrGlamorousVectorIcons right;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 4;
		action: [ :aButton :aSnippetElement | self indent ]
]

{ #category : #'gt - extensions' }
LeSnippetViewModel >> gtActionInspectSnippetFor: anAction [
	<gtAction>

	^ anAction button
		tooltip: 'Inspect Snippet Element';
		icon: BrGlamorousVectorIcons inspect;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 5;
		action: [ :aButton :aSnippetElement | aSnippetElement phlow spawnObject: aSnippetElement ]
]

{ #category : #'gt - extensions' }
LeSnippetViewModel >> gtActionInspectViewModelFor: anAction [
	<gtAction>

	^ anAction button
		tooltip: 'Inspect Snippet View Model';
		icon: BrGlamorousVectorIcons debug;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 6;
		action: [ :aButton :aSnippetElement | aSnippetElement phlow spawnObject: aSnippetElement snippetViewModel ]
]

{ #category : #'gt - extensions' }
LeSnippetViewModel >> gtActionMoveDownFor: anAction [
	<gtAction>

	^ anAction button
		tooltip: 'Move snippet down';
		icon: BrGlamorousVectorIcons down;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 2;
		action: [ :aButton :aSnippetElement | self moveDown ]
]

{ #category : #'gt - extensions' }
LeSnippetViewModel >> gtActionMoveUpFor: anAction [
	<gtAction>

	^ anAction button
		tooltip: 'Move snippet up';
		icon: BrGlamorousVectorIcons up;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 1;
		action: [ :aButton :aSnippetElement | self moveUp ]
]

{ #category : #'gt - extensions' }
LeSnippetViewModel >> gtActionUnindentFor: anAction [
	<gtAction>

	^ anAction button
		tooltip: 'Unindent snippet';
		icon: BrGlamorousVectorIcons left;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 3;
		action: [ :aButton :aSnippetElement | self unindent ]
]

{ #category : #'api - actions' }
LeSnippetViewModel >> indent [
	"Indent the receiver in the receiver's page, i.e. make it a child of the previous snippet.
	If this is the first snippet at the current level, do nothing"

	self snippetModel indentThroughCommand
]

{ #category : #'api - actions' }
LeSnippetViewModel >> insertNewSnippet: aLeSnippet [
	"Add a new snippet that is either:
	- a sibling of the receiver if there are no children.
	- the first child of the receiver.
	Give focus to the newly created snippet"

	self snippetsCollectionDo: [ :aSnippetsCollection | 
		| newSnippet newSnippetUIModel |
	
		newSnippet := self addChildOrSiblingSnippet: aLeSnippet.
		
		newSnippetUIModel := aSnippetsCollection
			findOrCreateSnippetViewModel: newSnippet.
		newSnippetUIModel focusAfterCreation.
		aSnippetsCollection scrollToViewModel: newSnippetUIModel ]
]

{ #category : #'api - actions' }
LeSnippetViewModel >> insertNewSnippetOfType: aLeSnippetClass [
	"Add a new snippet that is either:
	- a sibling of the receiver if there are no children.
	- the first child of the receiver.
	Give focus to the newly created snippet"
	
	self snippetsCollectionDo: [ :aSnippetsCollection |
		| newSnippet newSnippetUIModel |
		
		newSnippet := self snippetModel 
			addChildOrSiblingSnippetOfClass: aLeSnippetClass.
		
		newSnippetUIModel := aSnippetsCollection 
			findOrCreateSnippetViewModel: newSnippet.
		newSnippetUIModel focusAfterCreation.
		aSnippetsCollection scrollToViewModel: newSnippetUIModel ]
]

{ #category : #'api - actions' }
LeSnippetViewModel >> moveDown [
	"Move snippet down swapping it with a next sibling if it exists"

	self snippetModel moveDownThroughCommand
]

{ #category : #'api - actions' }
LeSnippetViewModel >> moveUp [
	"Move snippet up swapping it with a previous sibling if it exists"

	self snippetModel moveUpThroughCommand
]

{ #category : #accessing }
LeSnippetViewModel >> uid [
	"Each snippet view model displayed in the snippets element should have a uid.
	By default we take the uid of the content, however, custom snippet view models are free to override it"
	<return: #LeUID>

	^ self snippetModel uid
]

{ #category : #'api - actions' }
LeSnippetViewModel >> unindent [
	"Unindent the receiver in the receiver's page, i.e. make it follow its parent snippet.
	If this is a first level snippet, do nothing"

	self snippetModel unindentThroughCommand
]
