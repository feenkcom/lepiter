Class {
	#name : #LeLocalSyncMonitorStatus,
	#superclass : #LeLocalSyncConcreteDatabaseMonitorStatus,
	#category : #'Lepiter-Tool-Monitoring'
}

{ #category : #'gt-extensions' }
LeLocalSyncMonitorStatus >> gtViewStatusDetailsFor: aView [
	<gtView>
	self database monitor ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Details';
		priority: 10;
		object: [ self database monitor ];
		view: #gtViewStatusDetailsFor:
]
