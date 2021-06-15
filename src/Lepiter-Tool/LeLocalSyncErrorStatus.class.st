Class {
	#name : #LeLocalSyncErrorStatus,
	#superclass : #LeLocalSyncMonitorStatus,
	#category : #'Lepiter-Tool-Monitoring'
}

{ #category : #'gt-extensions' }
LeLocalSyncErrorStatus >> gtViewCorruptFilesFor: aView [
	<gtView>
	^ aView forward
		title: 'Corrupt files';
		priority: 15;
		object: [ self database ];
		view: #gtViewCorruptFilesFor:
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
