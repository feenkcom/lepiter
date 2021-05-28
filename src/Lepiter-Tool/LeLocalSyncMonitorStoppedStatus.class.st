Class {
	#name : #LeLocalSyncMonitorStoppedStatus,
	#superclass : #LeLocalSyncMonitorStatus,
	#category : #'Lepiter-Tool-Monitoring'
}

{ #category : #testing }
LeLocalSyncMonitorStoppedStatus >> isErrorStatus [
	^ true
]

{ #category : #accessing }
LeLocalSyncMonitorStoppedStatus >> shortName [
	^ 'Monitor Stopped'
]

{ #category : #accessing }
LeLocalSyncMonitorStoppedStatus >> statusColor [
	^ Color red
]

{ #category : #accessing }
LeLocalSyncMonitorStoppedStatus >> statusIcon [
	^ BrGlamorousIcons redcircle
]
