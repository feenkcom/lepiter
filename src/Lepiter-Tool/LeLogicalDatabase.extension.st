Extension { #name : #LeLogicalDatabase }

{ #category : #'*Lepiter-Tool' }
LeLogicalDatabase class >> asHomeDatabaseElementInstance [
	^ LeHomeLogicalDatabaseElement new
]

{ #category : #'*Lepiter-Tool' }
LeLogicalDatabase >> databasesToDisplayDo: aBlock [
	aBlock cull: primaryDB.
	registeredDBs do: [ :db |
		aBlock cull: db ].
	(playgroundDB notNil and: [ playgroundDB ~= primaryDB ])
		ifTrue: [ aBlock cull: playgroundDB ]
]

{ #category : #'*Lepiter-Tool' }
LeLogicalDatabase >> localSyncMonitorStatus [
	| monitorStatus |
	monitorStatus := LeLocalSyncLogicalDatabaseMonitorStatus forDatabase: self.
	self databasesDo: [ :aDatabase | 
		monitorStatus addDatabaseStatus: aDatabase localSyncMonitorStatus ].
	^ monitorStatus
]
