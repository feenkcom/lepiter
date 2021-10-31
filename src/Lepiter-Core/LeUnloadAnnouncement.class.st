"
Announce that the specified content has been unloaded from the system.

"
Class {
	#name : #LeUnloadAnnouncement,
	#superclass : #LeAnnouncement,
	#instVars : [
		'content'
	],
	#category : 'Lepiter-Core-Announcements'
}

{ #category : #accessing }
LeUnloadAnnouncement >> content [
	^ content
]

{ #category : #accessing }
LeUnloadAnnouncement >> content: anObject [
	content := anObject
]

{ #category : #'api - accessing' }
LeUnloadAnnouncement >> database [ 

	^ content database
]
