Class {
	#name : #LePageViewModelAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'pageViewModel'
	],
	#category : 'Lepiter-UI-Page-Events'
}

{ #category : #accessing }
LePageViewModelAnnouncement >> pageViewModel [
	^ pageViewModel
]

{ #category : #accessing }
LePageViewModelAnnouncement >> pageViewModel: anObject [
	pageViewModel := anObject
]
