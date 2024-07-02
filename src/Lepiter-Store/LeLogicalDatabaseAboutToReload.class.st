Class {
	#name : #LeLogicalDatabaseAboutToReload,
	#superclass : #Announcement,
	#instVars : [
		'database'
	],
	#category : #'Lepiter-Store-Reload - Announcements'
}

{ #category : #accessing }
LeLogicalDatabaseAboutToReload >> database [

	^ database
]

{ #category : #accessing }
LeLogicalDatabaseAboutToReload >> database: aLogicalDatabase [

	database := aLogicalDatabase
]
