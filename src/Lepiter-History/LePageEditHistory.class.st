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
LePageEditHistory >> actOnCommandExecutedFor: anAnnouncement [
	self addTraceEvent: anAnnouncement result traceEvent
]

{ #category : #callbacks }
LePageEditHistory >> actOnTraceableChangeFor: anAnnouncement [
	self addTraceEvent: anAnnouncement traceEvent
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
LePageEditHistory >> gtViewTraceEventsGroupedByCommandTypeFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Events by command type';
		priority: 35;
		object: [ self eventStore ];
		view: #gtViewEventsGroupedByCommandTypeFor:
]

{ #category : #'gt - extensions' }
LePageEditHistory >> gtViewTraceEventsGroupedByContentUidFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Events by content uid';
		priority: 30;
		object: [ self eventStore ];
		view: #gtViewEventsGroupedByContentUidFor:
]

{ #category : #'gt - extensions' }
LePageEditHistory >> gtViewTraceEventsListFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Events log';
		priority: 10;
		object: [ self eventStore ];
		view: #gtViewTraceEventsListFor:
]

{ #category : #'gt - extensions' }
LePageEditHistory >> gtViewUndoRedoHistoryFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Undo/Redo actions';
		priority: 1;
		items: [ self redoUndoActions ];
		column: 'Index' text: [ :historyAction :anIndex | anIndex ] width: 50;
		column: 'Type' text: [ :historyAction | historyAction labelText ] width: 75;
		column: 'Content Uid' text: [ :historyAction | 
			historyAction editEvent contentUid ];
		column: 'Edit Event' text: [ :historyAction | 
			historyAction eventDescriptionText ];
		actionUpdateButton
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

{ #category : #accessing }
LePageEditHistory >> redoActions [
	^ redoActions reversed
]

{ #category : #'api - undo/redo' }
LePageEditHistory >> redoCurrent [
	^ self redoOn: targetPage
]

{ #category : #'api - undo/redo' }
LePageEditHistory >> redoOn: aPage [
	| redoResult |
	redoResult := nil.
	
	redoActions ifNotEmpty: [ :currentRedoActions |
		self disableDuring: [
			redoResult := currentRedoActions removeLast 
				applyOn: aPage ] ].
	
	^ redoResult
]

{ #category : #accessing }
LePageEditHistory >> redoUndoActions [
	^ redoActions reversed, undoActions reversed
]

{ #category : #initialization }
LePageEditHistory >> registerEvents [
	targetPage announcer weak
		when: LeContentCommandExecutedAnnouncement 
			send: #actOnCommandExecutedFor:
			to: self;
		when: LeContentTraceableChangeExecutedAnnouncement
			send: #actOnTraceableChangeFor:
			to: self
]

{ #category : #accessing }
LePageEditHistory >> targetPage [
	^ targetPage
]

{ #category : #accessing }
LePageEditHistory >> undoActions [
	^ undoActions reversed 
]

{ #category : #'api - undo/redo' }
LePageEditHistory >> undoCurrent [
	^ self undoOn: targetPage
]

{ #category : #'api - undo/redo' }
LePageEditHistory >> undoOn: aPage [
	| undoResult |
	undoResult := nil.
	
	undoActions ifNotEmpty: [ :currentUndoActions |
		self disableDuring: [ 
			undoResult := currentUndoActions removeLast 
				applyOn: aPage ] ].
				
	^ undoResult
]
