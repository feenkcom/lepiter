Class {
	#name : #LeLocalSyncMonitorStoppedStatus,
	#superclass : #LeLocalSyncErrorStatus,
	#category : #'Lepiter-Tool-Monitoring'
}

{ #category : #accessing }
LeLocalSyncMonitorStoppedStatus >> gtReloadAllFor: anAction [
	<gtAction>
	database ifNil: [ ^ anAction noAction ].
	^ anAction button
		priority: 1;
		icon: BrGlamorousVectorIcons refresh;
		tooltip: 'Reload database';
		action: [ :aButton | self database reload ]
]

{ #category : #accessing }
LeLocalSyncMonitorStoppedStatus >> gtStartMonitoringFor: anAction [
	<gtAction>
	database ifNil: [ ^ anAction noAction ].
	^ anAction button
		priority: 2;
		icon: BrGlamorousVectorIcons play;
		tooltip: 'Start database monitoring';
		action: [ :aButton | self database startMonitoring ]
]

{ #category : #accessing }
LeLocalSyncMonitorStoppedStatus >> shortName [
	^ 'Monitor Stopped'
]
