Class {
	#name : #LeLocalSyncConcreteDatabaseMonitorStatus,
	#superclass : #LeLocalSyncStatus,
	#category : #'Lepiter-Tool-Monitoring'
}

{ #category : #testing }
LeLocalSyncConcreteDatabaseMonitorStatus >> isErrorStatus [
	^ false
]

{ #category : #testing }
LeLocalSyncConcreteDatabaseMonitorStatus >> isPendingChangesStatus [
	^ false
]

{ #category : #testing }
LeLocalSyncConcreteDatabaseMonitorStatus >> isRunningCleanly [
	^ self isErrorStatus not
]
