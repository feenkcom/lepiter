Class {
	#name : #LeContentTraceableChangeExecutedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'traceEvent'
	],
	#category : #'Lepiter-History-Announcements'
}

{ #category : #accessing }
LeContentTraceableChangeExecutedAnnouncement >> traceEvent [
	^ traceEvent
]

{ #category : #accessing }
LeContentTraceableChangeExecutedAnnouncement >> traceEvent: aTraceEvent [
	self assert: [ aTraceEvent notNil ].
	
	traceEvent := aTraceEvent
]
