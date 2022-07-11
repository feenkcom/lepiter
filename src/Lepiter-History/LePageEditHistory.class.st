Class {
	#name : #LePageEditHistory,
	#superclass : #Object,
	#instVars : [
		'targetPage',
		'eventStore',
		'undoActions',
		'redoActions',
		'isUndoEnabled'
	],
	#category : #'Lepiter-History-Storage'
}

{ #category : #'instance creation' }
LePageEditHistory class >> forPage: aPage [
	^ self new
		initializeForPage: aPage
]

{ #category : #callbacks }
LePageEditHistory >> actOnCommandExecutedFor: anEvent [
	self addTraceEvent: anEvent result traceEvent
]

{ #category : #'api - undo/redo' }
LePageEditHistory >> addRedoActionForEvent: aTraceEvent [
	redoActions add: (LePageEditHistoryRedoAction new 
		pageHistory: self; 
		editEvent: aTraceEvent)
]

{ #category : #adding }
LePageEditHistory >> addTraceEvent: aTraceEvent [
	self eventStore addTraceEvent: aTraceEvent.
	
	self isUndoEnabled
		ifFalse: [ ^ self ].
	
	self addUndoActionForEvent: aTraceEvent.
	redoActions removeAll.
]

{ #category : #'api - undo/redo' }
LePageEditHistory >> addUndoActionForEvent: aTraceEvent [
	undoActions add: (LePageEditHistoryUndoAction new 
		pageHistory: self; 
		editEvent: aTraceEvent)
]

{ #category : #'api - undo/redo' }
LePageEditHistory >> disableDuring: aBlock [
	| wasUndoEnabled |
	
	wasUndoEnabled := isUndoEnabled.
	isUndoEnabled := false.
	
	aBlock ensure: [ isUndoEnabled := wasUndoEnabled ]
]

{ #category : #initialization }
LePageEditHistory >> disableUndo [
	isUndoEnabled := false
]

{ #category : #initialization }
LePageEditHistory >> enableUndo [
	isUndoEnabled := true
]

{ #category : #accessing }
LePageEditHistory >> eventStore [
	^ eventStore
]

{ #category : #'gt - extensions' }
LePageEditHistory >> gtViewTraceEventsListFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Events Log';
		priority: 10;
		object: [ self eventStore ];
		view: #gtViewTraceEventsListFor:
]

{ #category : #'gt - extensions' }
LePageEditHistory >> gtViewUndoRedoHistoryFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Undo/Redo History';
		priority: 1;
		items: [ redoActions reversed, undoActions reversed ];
		column: 'Type' text: [ :historyAction | historyAction labelText ] width: 100;
		column: 'Event' text: [ :historyAction | historyAction eventDescriptionText ]
]

{ #category : #initialization }
LePageEditHistory >> initialize [ 
	super initialize.

	eventStore := LePageEventStore new.
]

{ #category : #initialization }
LePageEditHistory >> initializeForPage: aPage [
	targetPage := aPage.
	
	undoActions := OrderedCollection new.
	redoActions := OrderedCollection new.
	self enableUndo.
	
	self registerEvents.
]

{ #category : #testing }
LePageEditHistory >> isUndoEnabled [
	^ isUndoEnabled ifNil: [ false ]
]

{ #category : #'api - undo/redo' }
LePageEditHistory >> redoCurrent [
	self redoOn: targetPage
]

{ #category : #'api - undo/redo' }
LePageEditHistory >> redoOn: aPage [
	redoActions ifNotEmpty: [ :currentRedoActions |
		self disableDuring: [ "undoActions add: ("
			currentRedoActions removeLast applyOn: aPage ] ]
]

{ #category : #initialization }
LePageEditHistory >> registerEvents [
	targetPage announcer weak
		when: LeContentCommandExecutedAnnouncement 
		send: #actOnCommandExecutedFor:
		to: self
]

{ #category : #'api - undo/redo' }
LePageEditHistory >> undoCurrent [
	self undoOn: targetPage
]

{ #category : #'api - undo/redo' }
LePageEditHistory >> undoOn: aPage [
	undoActions ifNotEmpty: [ :currentUndoActions |
		self disableDuring: [ "redoActions add: ("
			currentUndoActions removeLast applyOn: aPage ] ]
]
