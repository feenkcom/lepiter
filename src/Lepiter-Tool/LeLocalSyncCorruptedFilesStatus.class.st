Class {
	#name : #LeLocalSyncCorruptedFilesStatus,
	#superclass : #LeLocalSyncMonitorStatus,
	#category : #'Lepiter-Tool-Monitoring'
}

{ #category : #testing }
LeLocalSyncCorruptedFilesStatus >> isErrorStatus [
	^ true
]

{ #category : #accessing }
LeLocalSyncCorruptedFilesStatus >> shortName [
	^ 'Corrupted Files'
]

{ #category : #accessing }
LeLocalSyncCorruptedFilesStatus >> statusColor [
	^ Color red
]

{ #category : #accessing }
LeLocalSyncCorruptedFilesStatus >> statusIcon [
	^ BrGlamorousIcons redcircle
]
