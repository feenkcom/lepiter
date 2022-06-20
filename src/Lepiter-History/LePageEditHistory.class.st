Class {
	#name : #LePageEditHistory,
	#superclass : #Object,
	#instVars : [
		'commandsLog',
		'redoCommands',
		'undoCommands',
		'isUndoEnabled'
	],
	#category : #'Lepiter-History'
}

{ #category : #'instance creation' }
LePageEditHistory class >> forPage: aPage [
	^ self new
		initializeForPage: aPage
]

{ #category : #adding }
LePageEditHistory >> addCommand: anEditCommand [
	self commandsLog add: anEditCommand.
	
	self isUndoEnabled
		ifFalse: [ ^ self ].
	
	undoCommands add: anEditCommand.
	redoCommands removeAll.
]

{ #category : #accessing }
LePageEditHistory >> commandsLog [
	^ commandsLog ifNil: [ 
		commandsLog := OrderedCollection new ]
]

{ #category : #'api - undo/redo' }
LePageEditHistory >> disableDuring: aBlock [
	| wasUndoEnabled |
	
	wasUndoEnabled := isUndoEnabled.
	isUndoEnabled := false.
	
	aBlock ensure: [ isUndoEnabled := wasUndoEnabled ]
]

{ #category : #'gt - extensions' }
LePageEditHistory >> gtViewCommandsListFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Log';
		items: [ self commandsLog ];
		column: 'Command' 
			text: [ :aCommand | aCommand class commandDescription ]
			width: 200;
		column: 'Description' text: [ :aCommand | aCommand description ]
]

{ #category : #initialization }
LePageEditHistory >> initializeForPage: aPage [
]

{ #category : #testing }
LePageEditHistory >> isUndoEnabled [
	^ isUndoEnabled ifNil: [ false ]
]

{ #category : #'api - undo/redo' }
LePageEditHistory >> redoOn: aPage [
	redoCommands ifNotEmpty: [ :currentRedoCommands |
		self disableDuring: [ undoCommands add: (currentRedoCommands 
			removeLast redoOn: aPage) ] ]
]

{ #category : #'api - undo/redo' }
LePageEditHistory >> undoOn: aPage [
	undoCommands ifNotEmpty: [ :currentUndoCommands |
		self disableDuring: [ redoCommands add: (currentUndoCommands 
			removeLast undoOn: aPage) ] ]
]
