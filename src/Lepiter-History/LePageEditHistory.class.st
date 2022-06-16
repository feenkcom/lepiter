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
LePageEditHistory >> actOnPageTitleChangedFor: anAnnouncement [
	self addCommand: (LePageRenameCommand forPage: anAnnouncement page)
]

{ #category : #callbacks }
LePageEditHistory >> actOnSnippetAddedFor: anAnnouncement [
	self addCommand: (LePageAddSnippetCommand forSnippet: anAnnouncement content)
]

{ #category : #callbacks }
LePageEditHistory >> actOnSnippetContentChangedFor: anAnnouncement [
	self addCommand: (LePageChangeSnippetCommand forSnippet: anAnnouncement snippet)
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
LePageEditHistory >> actOnSnippetRemovedFor: anAnnouncement [
	self addCommand: (LePageRemoveSnippetCommand forSnippet: anAnnouncement content)
]

{ #category : #callbacks }
LePageEditHistory >> actOnSnippetUnindentedFor: anAnnouncement [
	self addCommand: (LePageUnindentSnippetCommand forSnippet: anAnnouncement content)
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
	aPage announcer weak 
		when: LeContentTreeIndented send: #actOnSnippetIndentedFor: to: self;
		when: LeContentTreeUnindented send: #actOnSnippetUnindentedFor: to: self;
		when: LeContentTreeMovedUp send: #actOnSnippetMovedUpFor: to: self;
		when: LeContentTreeMovedDown send: #actOnSnippetMovedDownFor: to: self;
		when: LeContentTreeRemoved send: #actOnSnippetRemovedFor: to: self;
		when: LeContentTreeAdded send: #actOnSnippetAddedFor: to: self;
		when: LeSnippetContentChanged send: #actOnSnippetContentChangedFor: to: self;
		when: LePageTitleChanged send: #actOnPageTitleChangedFor: to: self
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
