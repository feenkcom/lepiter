Class {
	#name : #LeLocalSyncPendingChangesStatus,
	#superclass : #LeLocalSyncMonitorStatus,
	#category : #'Lepiter-Tool-Monitoring'
}

{ #category : #testing }
LeLocalSyncPendingChangesStatus >> hasPendingChanges [
	^ true
]

{ #category : #accessing }
LeLocalSyncPendingChangesStatus >> shortName [
	^ 'Pending Changes'
]

{ #category : #accessing }
LeLocalSyncPendingChangesStatus >> statusColor [
	^ Color yellow muchDarker
]

{ #category : #accessing }
LeLocalSyncPendingChangesStatus >> statusIcon [
	^ BrGlamorousVectorIcons yellowcircle
]
