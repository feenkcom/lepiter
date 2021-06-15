Class {
	#name : #LeLocalSyncConcreteDatabaseMonitorStatus,
	#superclass : #LeLocalSyncStatus,
	#category : #'Lepiter-Tool-Monitoring'
}

{ #category : #accessing }
LeLocalSyncConcreteDatabaseMonitorStatus >> databaseName [
	^ self database databaseName
]
