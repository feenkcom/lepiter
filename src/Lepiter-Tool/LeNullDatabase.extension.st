Extension { #name : #LeNullDatabase }

{ #category : #'*Lepiter-Tool' }
LeNullDatabase >> databasesToDisplayDo: aBlock [
	"do nothing"
]

{ #category : #'*Lepiter-Tool' }
LeNullDatabase >> localSyncMonitorStatus [
	^ LeLocalSyncMissingMonitorStatus forDatabase: self
]
