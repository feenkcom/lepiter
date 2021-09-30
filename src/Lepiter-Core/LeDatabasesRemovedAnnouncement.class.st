Class {
	#name : #LeDatabasesRemovedAnnouncement,
	#superclass : #LeDatabaseAnnouncement,
	#instVars : [
		'parent'
	],
	#category : 'Lepiter-Core-Announcements'
}

{ #category : #accessing }
LeDatabasesRemovedAnnouncement >> parent [
	<return: #LeLogicalDatabase>
	^ parent
]

{ #category : #accessing }
LeDatabasesRemovedAnnouncement >> parent: anObject [
	parent := anObject
]
