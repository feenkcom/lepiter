Class {
	#name : #LeLocalStoreMonitorStarted,
	#superclass : #Announcement,
	#instVars : [
		'monitor'
	],
	#category : #'Lepiter-Store-LocalJSON-Store'
}

{ #category : #accessing }
LeLocalStoreMonitorStarted >> monitor [

	^ monitor
]

{ #category : #accessing }
LeLocalStoreMonitorStarted >> monitor: anObject [

	monitor := anObject
]
