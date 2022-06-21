Class {
	#name : #LePageEditHistory,
	#superclass : #Object,
	#instVars : [
		'eventsLog',
		'redoCommands',
		'undoCommands',
		'isUndoEnabled'
	],
	#category : #'Lepiter-History-Store'
}

{ #category : #'instance creation' }
LePageEditHistory class >> forPage: aPage [
	^ self new
		initializeForPage: aPage
]

{ #category : #adding }
LePageEditHistory >> addTraceEvent: aTraceEvent [
	self eventsLog add: aTraceEvent.
	
	self isUndoEnabled
		ifFalse: [ ^ self ].
	
	undoCommands add: aTraceEvent.
	redoCommands removeAll.
]

{ #category : #'api - undo/redo' }
LePageEditHistory >> disableDuring: aBlock [
	| wasUndoEnabled |
	
	wasUndoEnabled := isUndoEnabled.
	isUndoEnabled := false.
	
	aBlock ensure: [ isUndoEnabled := wasUndoEnabled ]
]

{ #category : #accessing }
LePageEditHistory >> eventsLog [
	^ eventsLog ifNil: [ 
		eventsLog := OrderedCollection new ]
]

{ #category : #'gt - extensions' }
LePageEditHistory >> gtViewTraceEventsListFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Log';
		items: [ self eventsLog ];
		column: 'Event' 
			text: [ :anEvent | anEvent commandSpecification className ]
			width: 200;
		column: 'Description' text: [ :anEvent | anEvent commandSpecification ]
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
