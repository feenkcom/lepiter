Class {
	#name : #LeLocalSyncStatus,
	#superclass : #Object,
	#category : #'Lepiter-Tool-Monitoring'
}

{ #category : #accessing }
LeLocalSyncStatus >> formattedShortName [
	^ self shortName asRopedText 
		foreground: self statusColor
]

{ #category : #testing }
LeLocalSyncStatus >> hasPendingChanges [
	^ false
]

{ #category : #testing }
LeLocalSyncStatus >> isErrorStatus [
	^ false
]

{ #category : #testing }
LeLocalSyncStatus >> isRunningCleanly [
	^ self isErrorStatus not
]

{ #category : #printing }
LeLocalSyncStatus >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' (';
		nextPutAll: self shortName;
		nextPutAll: ')'
]

{ #category : #accessing }
LeLocalSyncStatus >> shortName [
	^ self subclassResponsibility
]

{ #category : #accessing }
LeLocalSyncStatus >> statusColor [
	^ self subclassResponsibility
]

{ #category : #accessing }
LeLocalSyncStatus >> statusIcon [
	^ self subclassResponsibility
]
