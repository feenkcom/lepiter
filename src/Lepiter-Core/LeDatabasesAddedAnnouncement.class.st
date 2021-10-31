Class {
	#name : #LeDatabasesAddedAnnouncement,
	#superclass : #LeDatabaseAnnouncement,
	#instVars : [
		'parent'
	],
	#category : 'Lepiter-Core-Announcements'
}

{ #category : #accessing }
LeDatabasesAddedAnnouncement >> parent [
	<return: #LeLogicalDatabase>
	^ parent
]

{ #category : #accessing }
LeDatabasesAddedAnnouncement >> parent: anObject [
	parent := anObject
]
