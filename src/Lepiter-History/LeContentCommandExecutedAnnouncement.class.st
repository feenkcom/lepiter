Class {
	#name : #LeContentCommandExecutedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'result',
		'command'
	],
	#category : #'Lepiter-History-Announcements'
}

{ #category : #accessing }
LeContentCommandExecutedAnnouncement >> command [

	^ command
]

{ #category : #accessing }
LeContentCommandExecutedAnnouncement >> command: anObject [

	command := anObject
]

{ #category : #accessing }
LeContentCommandExecutedAnnouncement >> result [

	^ result
]

{ #category : #accessing }
LeContentCommandExecutedAnnouncement >> result: anObject [

	result := anObject
]
