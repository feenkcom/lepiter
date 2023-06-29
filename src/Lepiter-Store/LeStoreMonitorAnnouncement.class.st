Class {
	#name : #LeStoreMonitorAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'monitor'
	],
	#category : #'Lepiter-Store-LocalJSON-Store'
}

{ #category : #accessing }
LeStoreMonitorAnnouncement >> monitor [
	^ monitor
]

{ #category : #accessing }
LeStoreMonitorAnnouncement >> monitor: anObject [
	monitor := anObject
]
