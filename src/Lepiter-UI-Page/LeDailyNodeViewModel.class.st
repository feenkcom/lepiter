Class {
	#name : #LeDailyNodeViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TLeWithDailyNoteModel',
	#classTraits : 'TGtAnnouncer classTrait + TLeWithDailyNoteModel classTrait',
	#instVars : [
		'announcer'
	],
	#category : 'Lepiter-UI-Page-! View Models'
}

{ #category : #announcer }
LeDailyNodeViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - daily note' }
LeDailyNodeViewModel >> notifyDailyNoteReplaced [
	self announce: (LeDailyNoteViewModelDailyNoteChanged new 
		dailyNoteViewModel: self)
]

{ #category : #'api - daily note' }
LeDailyNodeViewModel >> onDailyNoteModelChanged [
	"Is sent when a new daily note model is assigned to the view model"
	
	self notifyDailyNoteReplaced.
]
