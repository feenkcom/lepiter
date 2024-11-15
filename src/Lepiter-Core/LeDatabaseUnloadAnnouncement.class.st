Class {
	#name : #LeDatabaseUnloadAnnouncement,
	#superclass : #LeUnloadAnnouncement,
	#category : #'Lepiter-Core-Announcements'
}

{ #category : #'api - accessing' }
LeDatabaseUnloadAnnouncement >> database [ 

	^ content
]

{ #category : #printing }
LeDatabaseUnloadAnnouncement >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		print: self database;
		nextPut: $)
]
