Class {
	#name : #LePageEventStore,
	#superclass : #Object,
	#instVars : [
		'events'
	],
	#category : #'Lepiter-History-Storage'
}

{ #category : #adding }
LePageEventStore >> addTraceEvent: aTraceEvent [
	self events add: aTraceEvent.
]

{ #category : #accessing }
LePageEventStore >> events [
	^ events
]

{ #category : #'gt - extensions' }
LePageEventStore >> gtViewCommandSpecificationsListFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Command Specifications';
		priority: 15;
		items: [ self events collect: [ :aTraceEvent |
			aTraceEvent commandSpecification ] ];
		column: 'Index' text: [ :aCommandSpecification :index | index ] width: 150;
		column: 'Command Type' text: [ :aCommandSpecification | 
			aCommandSpecification commandTypeName ]
]

{ #category : #'gt - extensions' }
LePageEventStore >> gtViewTraceEventsListFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Events Log';
		priority: 10;
		items: [ self events ];
		column: 'Index' text: [ :aTraceEvent :index | index ] width: 100;
		column: 'Main Command' text: [ :aTraceEvent | 
			aTraceEvent commandSpecification commandTypeName ];
		column: 'Undo Command' text: [ :aTraceEvent | 
			aTraceEvent undoSpecification commandTypeName ]
]

{ #category : #initialization }
LePageEventStore >> initialize [ 
	super initialize.
	
	events := OrderedCollection new.
]
