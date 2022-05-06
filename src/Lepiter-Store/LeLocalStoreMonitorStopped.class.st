Class {
	#name : #LeLocalStoreMonitorStopped,
	#superclass : #Announcement,
	#instVars : [
		'monitor'
	],
	#category : #'Lepiter-Store-LocalJSON-Store'
}

{ #category : #accessing }
LeLocalStoreMonitorStopped >> monitor [

	^ monitor
]

{ #category : #accessing }
LeLocalStoreMonitorStopped >> monitor: anObject [

	monitor := anObject
]
