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
		title: 'Command specifications';
		priority: 15;
		items: [ self events collect: [ :aTraceEvent |
			aTraceEvent mainCommandSpecification ] ];
		column: 'Index' text: [ :aCommandSpecification :index | index ] width: 150;
		column: 'Command Type' text: [ :aCommandSpecification | 
			aCommandSpecification commandTypeName ]
]

{ #category : #'gt - extensions' }
LePageEventStore >> gtViewEventsGroupedByCommandTypeFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'By command type';
		priority: 35;
		object: [ self events ];
		view: #gtViewEventsGroupedByCommandTypeFor:
]

{ #category : #'gt - extensions' }
LePageEventStore >> gtViewEventsGroupedByContentUidFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'By content uid';
		priority: 30;
		object: [ self events ];
		view: #gtViewEventsGroupedByContentUidFor:
]

{ #category : #'gt - extensions' }
LePageEventStore >> gtViewTraceEventsListFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Events log';
		priority: 10;
		object: [ self events ];
		view: #gtItemsFor:
]

{ #category : #initialization }
LePageEventStore >> initialize [ 
	super initialize.
	
	events := LeContentTraceEventsGroup new.
]

{ #category : #testing }
LePageEventStore >> isEmpty [
	^ self events isEmpty
]

{ #category : #printing }
LePageEventStore >> printOn: aStream [ 
	super printOn: aStream.
	aStream 
		<< ' [';
		print: self size;
		<< ' ';
		<< (self size = 1 
			ifTrue: [ 'item' ]
			ifFalse: [ 'items' ]);
		<< ']'
]

{ #category : #accessing }
LePageEventStore >> size [
	^ self events size
]
