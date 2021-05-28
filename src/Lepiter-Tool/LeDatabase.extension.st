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

	currentMonitor ifNil: [ ^ LeLocalSyncMissingMonitorStatus new ].
	currentMonitor isRunning 
		ifFalse: [ ^ LeLocalSyncMonitorStoppedStatus new ].
	currentMonitor hasCorruptFiles 
		ifTrue: [ ^ LeLocalSyncCorruptedFilesStatus new ].
	currentMonitor isEmpty 
		ifFalse: [ ^ LeLocalSyncPendingChangesStatus new ] .
	
	^ LeLocalSyncMonitorCleanStatus new
]
