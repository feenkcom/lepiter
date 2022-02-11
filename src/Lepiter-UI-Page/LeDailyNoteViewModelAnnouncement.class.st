Class {
	#name : #LeDailyNoteViewModelAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'dailyNoteViewModel'
	],
	#category : 'Lepiter-UI-Page-Events'
}

{ #category : #accessing }
LeDailyNoteViewModelAnnouncement >> dailyNoteViewModel [
	^ dailyNoteViewModel
]

{ #category : #accessing }
LeDailyNoteViewModelAnnouncement >> dailyNoteViewModel: anObject [
	dailyNoteViewModel := anObject
]
