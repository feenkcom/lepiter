Class {
	#name : #LePageEditHistory,
	#superclass : #Object,
	#instVars : [
		'targetPage',
		'eventStore',
		'redoEvents',
		'undoEvents',
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

{ #category : #adding }
LePageEditHistory >> addTraceEvent: aTraceEvent [
	self eventStore addTraceEvent: aTraceEvent.
	
	self isUndoEnabled
		ifFalse: [ ^ self ].
	
	undoEvents add: aTraceEvent.
	redoEvents removeAll.
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
		items: [
			(redoEvents reversed collect: [ :eachCommand | eachCommand -> #Redo ]),
			(undoEvents reversed collect: [ :eachCommand | eachCommand -> #Undo ]) ];
		column: 'Type' text: [ :eachCommandAndType |
			eachCommandAndType value = #Redo
				ifTrue: [ eachCommandAndType value gtDisplayText foreground: Color gray ]
				ifFalse: [ eachCommandAndType value gtDisplayText ] ] width: 100;
		column: 'Command' text: [ :eachCommandAndType |
			eachCommandAndType value = #Redo
				ifTrue: [ eachCommandAndType key gtDisplayText foreground: Color gray ]
				ifFalse: [ eachCommandAndType key gtDisplayText ] ];
		send: [ :eachCommandAndType | eachCommandAndType key ]
]

{ #category : #initialization }
LePageEditHistory >> initialize [ 
	super initialize.

	eventStore := LePageEventStore new.
]

{ #category : #initialization }
LePageEditHistory >> initializeForPage: aPage [
	targetPage := aPage.
	
	undoEvents := OrderedCollection new.
	redoEvents := OrderedCollection new.
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
	redoEvents ifNotEmpty: [ :currentRedoEvents |
		self disableDuring: [ undoEvents add: (currentRedoEvents 
			removeLast redoOn: aPage) ] ]
]

{ #category : #initialization }
LePageEditHistory >> registerEvents [
	targetPage 
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
	undoEvents ifNotEmpty: [ :currentUndoEvents |
		self disableDuring: [ redoEvents add: (currentUndoEvents
			removeLast undoOn: aPage) ] ]
]
