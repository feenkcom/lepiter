Class {
	#name : #LeLocalSyncErrorStatus,
	#superclass : #LeLocalSyncMonitorStatus,
	#category : #'Lepiter-Tool-Monitoring'
}

{ #category : #accessing }
LeLocalSyncErrorStatus >> corruptFiles [
	^ self database monitor corruptFiles
]

{ #category : #'gt-extensions' }
LeLocalSyncErrorStatus >> gtViewCorruptFilesFor: aView [
	<gtView>
	^ aView forward
		title: 'Corrupt files';
		priority: 15;
		object: [ self database ];
		view: #gtViewCorruptFilesFor:
]

{ #category : #'gt-extensions' }
LeLocalSyncErrorStatus >> gtViewDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		priority: 10;
		items: [ {
			'Has corrupt files' -> (self corruptFiles size > 0) .
			'Is monitor stopped' -> self database monitor isRunning }];
		column: 'Name' text: #key;
		column: 'Value' text: #value;
		send: #value
]

{ #category : #testing }
LeLocalSyncErrorStatus >> isErrorStatus [
	^ true
]

{ #category : #accessing }
LeLocalSyncErrorStatus >> statusColor [
	^ Color red
]

{ #category : #accessing }
LeLocalSyncErrorStatus >> statusIcon [
	^ BrGlamorousIcons redcircle
]
