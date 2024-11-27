Class {
	#name : #LeDatabaseDailyNotesGroupedItems,
	#superclass : #Object,
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #computing }
LeDatabaseDailyNotesGroupedItems >> fromNavigationModel: aNavigationModel [
	^ aNavigationModel database dailyNotesGroup
		collect: [ :aDailyNote | aDailyNote date -> aDailyNote children ]
]
