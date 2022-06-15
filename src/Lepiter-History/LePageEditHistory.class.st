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

{ #category : #callbacks }
LePageEditHistory >> actOnSnippetIndentedFor: anAnnouncement [
	self addCommand: (LePageIndentSnippetCommand forSnippet: anAnnouncement content)
]

{ #category : #callbacks }
LePageEditHistory >> actOnSnippetMovedDownFor: anAnnouncement [
	self addCommand: (LePageMoveDownSnippetCommand forSnippet: anAnnouncement content)
]

{ #category : #callbacks }
LePageEditHistory >> actOnSnippetMovedUpFor: anAnnouncement [
	self addCommand: (LePageMoveUpSnippetCommand forSnippet: anAnnouncement content)
]

{ #category : #callbacks }
LePageEditHistory >> actOnSnippetUnindentedFor: anAnnouncement [
	self addCommand: (LePageUnindentSnippetCommand forSnippet: anAnnouncement content)
]

{ #category : #adding }
LePageEditHistory >> addCommand: anEditCommand [
	self commandsLog add: anEditCommand.
	
	isUndoEnabled
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
	| wasEnabled |
	
	wasEnabled := isUndoEnabled.
	isUndoEnabled := false.
	
	aBlock ensure: [ isUndoEnabled := wasEnabled ]
]

{ #category : #'gt - extensions' }
LePageEditHistory >> gtViewCommandsListFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Log';
		items: [ self commandsLog ];
		column: 'Command' text: [ :aCommand | aCommand class commandDescription ];
		column: 'Target' text: [ :aCommand | aCommand targetSnippetUid ]
]

{ #category : #initialization }
LePageEditHistory >> initializeForPage: aPage [
	aPage announcer weak 
		when: LeContentTreeIndented send: #actOnSnippetIndentedFor: to: self;
		when: LeContentTreeUnindented send: #actOnSnippetUnindentedFor: to: self;
		when: LeContentTreeMovedUp send: #actOnSnippetMovedUpFor: to: self;
		when: LeContentTreeMovedDown send: #actOnSnippetMovedDownFor: to: self
]

{ #category : #'api - undo/redo' }
LePageEditHistory >> redoOn: aBrTextEditor [
	redoCommands ifNotEmpty: [ :currentRedoCommands |
		self disableDuring: [ undoCommands add: (currentRedoCommands 
			removeLast redoOn: aBrTextEditor) ] ]
]

{ #category : #'api - undo/redo' }
LePageEditHistory >> undoOn: aBrTextEditor [
	undoCommands ifNotEmpty: [ :currentUndoCommands |
		self disableDuring: [ redoCommands add: (currentUndoCommands 
			removeLast undoOn: aBrTextEditor) ] ]
]
