Extension { #name : #LeDatabase }

{ #category : #'*Lepiter-Tool' }
LeDatabase class >> asHomeDatabaseElementInstance [
	^ LeHomeDatabaseElement new
]

{ #category : #'*Lepiter-Tool' }
LeDatabase >> databasesToDisplayDo: aBlock [
	aBlock cull: self
]

{ #category : #'*Lepiter-Tool' }
LeDatabase >> localSyncMonitorStatus [
	| currentMonitor |
	currentMonitor := self monitor.

	currentMonitor ifNil: [ ^ LeLocalSyncMissingMonitorStatus forDatabase: self ].
	currentMonitor isRunning 
		ifFalse: [ ^ LeLocalSyncMonitorStoppedStatus forDatabase: self ].
	currentMonitor hasCorruptPages 
		ifTrue: [ ^ LeLocalSyncCorruptedFilesStatus forDatabase: self ].
	currentMonitor isEmpty 
		ifFalse: [ ^ LeLocalSyncPendingChangesStatus forDatabase: self ] .
	
	^ LeLocalSyncMonitorCleanStatus forDatabase: self
]
