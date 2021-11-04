Class {
	#name : #GtEpiceaUpdatedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'hasImpact',
		'impactChanged',
		'numberOfEvents',
		'previousNumberOfEvents'
	],
	#category : #'Lepiter-UI-Core-Announcements'
}

{ #category : #accessing }
GtEpiceaUpdatedAnnouncement >> eventDifference [
	^ self numberOfEvents - self previousNumberOfEvents
]

{ #category : #accessing }
GtEpiceaUpdatedAnnouncement >> hasImpact [
	^ hasImpact
]

{ #category : #accessing }
GtEpiceaUpdatedAnnouncement >> hasImpact: anObject [
	hasImpact := anObject
]

{ #category : #accessing }
GtEpiceaUpdatedAnnouncement >> impactChanged [
	^ impactChanged
]

{ #category : #accessing }
GtEpiceaUpdatedAnnouncement >> impactChanged: anObject [
	impactChanged := anObject
]

{ #category : #testing }
GtEpiceaUpdatedAnnouncement >> impactChangedOrNumberOfEventsChanged [
	^ self impactChanged or: [ self eventDifference isZero not ]
]

{ #category : #accessing }
GtEpiceaUpdatedAnnouncement >> numberOfEvents [
	^ numberOfEvents
]

{ #category : #accessing }
GtEpiceaUpdatedAnnouncement >> numberOfEvents: anObject [
	numberOfEvents := anObject
]

{ #category : #accessing }
GtEpiceaUpdatedAnnouncement >> previousNumberOfEvents [
	^ previousNumberOfEvents
]

{ #category : #accessing }
GtEpiceaUpdatedAnnouncement >> previousNumberOfEvents: anObject [
	previousNumberOfEvents := anObject
]

{ #category : #printing }
GtEpiceaUpdatedAnnouncement >> printOn: aStream [
	aStream
		nextPutAll: 'Epicea updated, impact: ';
		print: self hasImpact;
		nextPutAll: ', changed: ';
		print: self impactChanged;
		nextPutAll: ', events: ';
		print: self numberOfEvents;
		nextPutAll: ', previously: ';
		print: self previousNumberOfEvents
]
