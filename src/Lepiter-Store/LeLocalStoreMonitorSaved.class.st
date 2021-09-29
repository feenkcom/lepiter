"
LeLocalStoreMonitorSaved is announced each time the monitor has completed a cycle of saving changed and removed pages.

"
Class {
	#name : #LeLocalStoreMonitorSaved,
	#superclass : #Announcement,
	#instVars : [
		'monitor'
	],
	#category : 'Lepiter-Store-LocalJSON-Store'
}

{ #category : #accessing }
LeLocalStoreMonitorSaved >> monitor [
	^ monitor
]

{ #category : #accessing }
LeLocalStoreMonitorSaved >> monitor: anObject [
	monitor := anObject
]
