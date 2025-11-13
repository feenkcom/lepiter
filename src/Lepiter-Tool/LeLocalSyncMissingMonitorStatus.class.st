Class {
	#name : #LeLocalSyncMissingMonitorStatus,
	#superclass : #LeLocalSyncConcreteDatabaseMonitorStatus,
	#category : #'Lepiter-Tool-Monitoring'
}

{ #category : #testing }
LeLocalSyncMissingMonitorStatus >> isErrorStatus [
	^ true
]

{ #category : #accessing }
LeLocalSyncMissingMonitorStatus >> shortName [
	^ 'Missing Monitor'
]

{ #category : #accessing }
LeLocalSyncMissingMonitorStatus >> statusColor [
	^ Color red
]

{ #category : #accessing }
LeLocalSyncMissingMonitorStatus >> statusIcon [
	^ BrGlamorousVectorIcons redcircle
]
