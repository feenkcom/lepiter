Class {
	#name : #LeContentTraceEventsGroup,
	#superclass : #Object,
	#traits : 'TGtGroupWithItems',
	#classTraits : 'TGtGroupWithItems classTrait',
	#category : #'Lepiter-History-Storage'
}

{ #category : #'accessing - grouping' }
LeContentTraceEventsGroup >> groupedByCommandType [
	^ self groupedBy: [ :aTraceEvent |
		aTraceEvent mainCommandTypeName ]
]

{ #category : #'accessing - grouping' }
LeContentTraceEventsGroup >> groupedByContentUid [
	^ self groupedBy: [ :aTraceEvent |
		aTraceEvent contentUid ]
]

{ #category : #'gt - extensions' }
LeContentTraceEventsGroup >> gtItemsFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Events';
		priority: 10;
		items: [ self ];
		column: 'Index' text: [ :aTraceEvent :index | index ] width: 50;
		column: 'Timestamp' text: [ :aTraceEvent |
			aTraceEvent timestamp printToSeconds ] width: 125;
		column: 'Type' text: [ :aTraceEvent | aTraceEvent label ] width: 50;
		column: 'Content Uid' text: [ :aTraceEvent | aTraceEvent contentUid ];
		column: 'Main Command' text: [ :aTraceEvent | 
			aTraceEvent mainCommandLabel ];
		"column: 'Undo Command' text: [ :aTraceEvent | 
			aTraceEvent undoCommandLabel ];"
		actionUpdateButton
]

{ #category : #accessing }
LeContentTraceEventsGroup >> gtViewEventsGroupedByCommandTypeFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'By command type';
		priority: 35;
		items: [ self groupedByCommandType associations
			sorted: [ :each | each value size] descending ];
		column: 'Command Type' text: [ :assoc | assoc key ];
		column: 'Trace Events' text: [ :assoc | assoc value size ];
		send: [ :assoc | assoc value ]
]

{ #category : #accessing }
LeContentTraceEventsGroup >> gtViewEventsGroupedByContentUidFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'By content uid';
		priority: 30;
		items: [ self groupedByContentUid associations ];
		column: 'Content Uid' text: [ :assoc | assoc key ];
		column: 'Trace Events' text: [ :assoc | assoc value size ];
		send: [ :assoc | assoc value ]
]
